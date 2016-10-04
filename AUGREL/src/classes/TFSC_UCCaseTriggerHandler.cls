public with sharing class TFSC_UCCaseTriggerHandler  implements TFSC_TriggerDispatcher.Handler {


    // trigger created to handle Misapplied Payments in UC Console
    public static boolean alreadyProcessed = false;
    public static boolean alreadyAssigned = false;
    public  Map<Id, Id> facMap = new Map<Id,Id>();
    
    public void handle(){
        system.debug('+++ TFSC_UCCaseTriggerHandler - alreadyProcessed: ' + alreadyProcessed);
        if (!alreadyProcessed ) {
            handleMisappliedPayments(trigger.new);
            alreadyProcessed = true;
        }

    }
    

    public void handleMisappliedPayments(List<Case> caseList) {
    
            
            
            Set<Id> caseIds = new Set<Id>();
            Set<Id> faIds = new Set<Id>();
            for (Case c : caseList) {
                if (c.status == 'Resolved' || c.Service_Request_Type__c != 'Misapplied Payment')
                    continue;
                    
                Case oldCase;
                if (trigger.isUpdate)
                     oldCase = (Case) trigger.oldMap.get(c.Id);
                else
                     oldCase = new Case();
    
                if (oldCase.description != c.description ||
                    oldCase.Effective_Date__c != c.Effective_Date__c || 
                    oldCase.Payment_Amount__c != c.Payment_Amount__c ||
                    oldCase.Effective_Date1__c != c.Effective_Date1__c ||
                    oldCase.Payment_Amount1__c != c.Payment_Amount1__c ||
                    oldCase.Effective_Date2__c != c.Effective_Date2__c ||
                    oldCase.Payment_Amount2__c != c.Payment_Amount2__c) {
                
                        caseIds.add(c.Id);
                        faIds.add(c.Acct_Misapplied_To__c);
                        faIds.add(c.Apply_to_Account1__c);
                        faIds.add(c.Apply_to_Account2__c);
                    }
            }
            if (caseIds.size() == 0)
                return;
             
            faIds.remove(null); 

            // get primary borrowers for the FAs
            
            for (Financial_Account_Customer__c fac : [select Id, Financial_Account__c from Financial_Account_Customer__c where Financial_Account__c in : faIds
                        and Customer_Role_Type__c = '0-Primary Borrower' and Borrower_Status__c = 'Active' ]) {
                  facMap.put(fac.Financial_Account__c, fac.Id);
                 
            }
            // build map of cases and activities
            
            
            Map<Id, List<TFS_Activity__c>> caseActivityMap = new Map<Id, List<TFS_Activity__c>>();
            /* W-001386- Always create new Activity
            for (TFS_Activity__c act :[select Id, case__c, description__c, financial_account__c, financial_account_customer__c from TFS_Activity__c where case__c in :caseIds]) {
            
                List<TFS_Activity__c> tempActList = caseActivityMap.get(act.case__c);
                if (tempActList == null)
                    tempActList = new List<TFS_Activity__c>();
                tempActList.add(act);
                caseActivityMap.put(act.case__c,tempActList.clone());
            }         
            // determine if adding or updating activities
            */
            
            List<TFS_Activity__c> newActivities = new List<TFS_Activity__c>();
            List<TFS_Activity__c> activitiesToUpdate = new List<TFS_Activity__c>();
            
            
            for (Case c : caseList) {
                List<TFS_Activity__c> caseActivities = new List<TFS_Activity__c> ();
                caseActivities = caseActivityMap.get(c.Id);

                //No need to update activities
                //if (caseActivities == null)
                    newActivities.addAll(createActivities(c));
                //else {
                //    activitiesToUpdate.addAll(updateActivities(c, caseActivities));
                    
                //}
                    
                
            }

                if (newActivities.size() > 0)
                        insert newActivities;
                if (activitiesToUpdate.size() > 0)
                         update activitiesToUpdate;
                        
            
    }                   
        
    public List<TFS_Activity__c> createActivities(Case c) { 
    
        Id facId;
        List<TFS_Activity__c> newActivities = new List<TFS_Activity__c>();  
        if (c.action__c == 'Start Process' && c.Category__c == 'Payments' && c.Service_Request_Type__c == 'Misapplied Payment'
                    && c.Description != null  && c.Effective_Date__c != null && c.Payment_Amount__c!= null
                    && c.Effective_Date1__c != null && c.Payment_Amount1__c!= null
                    ) {
              try {
                 facId = this.facMap.get(c.Acct_Misapplied_To__c);
              }
              catch(exception e) {
                facId = null;
              }
              newActivities.add (new TFS_Activity__c(
                 case__c = c.Id,
                 action__c = c.action__c,
                 category__c = c.Category__c,
                 topic__c = c.service_request_type__c,
                 
                 financial_account__c = c.Acct_Misapplied_To__c,
                 financial_account_customer__c = facId,
                 
                 description__c = c.description + '\nEffective Date: ' + c.Effective_Date__c.format() + '\nPayment Amount: ' + 
                      string.valueOf(c.Payment_Amount__c)  
                 ));            

              try {
                 facId = facMap.get(c.Apply_to_Account1__c);
              }
              catch(exception e) {
                facId = null;
              }                     
              newActivities.add (new TFS_Activity__c(
                 case__c = c.Id,
                 action__c = c.action__c,
                 category__c = c.Category__c,
                 topic__c = c.service_request_type__c,
                 
                 financial_account__c = c.Apply_to_Account1__c,
                 financial_account_customer__c = facId,
                 description__c = c.description + '\nEffective Date: ' + c.Effective_Date1__c.format() + '\nPayment Amount: ' + 
                      string.valueOf(c.Payment_Amount1__c)  
                 ));            

              try {
                 facId = facMap.get(c.Apply_to_Account2__c);
              }
              catch(exception e) {
                facId = null;
              }                     
              if(c.Apply_to_Account2__c != null) {          
                  newActivities.add (new TFS_Activity__c(
                     case__c = c.Id,
                     action__c = c.action__c,
                     category__c = c.Category__c,
                     topic__c = c.service_request_type__c,
                     
                     financial_account__c = c.Apply_to_Account2__c,
                     financial_account_customer__c = facId,
                     
                     description__c = c.description + '\nEffective Date: ' + c.Effective_Date2__c.format() + '\nPayment Amount: ' + 
                          string.valueOf(c.Payment_Amount2__c)  
                     ));            
              }     
            }   
            return newActivities;
            
        }   
    
    public List<TFS_Activity__c> updateActivities(Case c, List<TFS_Activity__c> activityList) {
        
        List<TFS_Activity__c> updatedActivities = new List<TFS_Activity__c>();  
        //append description, effective date, payment amount

        for (TFS_Activity__c act : activityList) {
        //system.debug('++++ processing activity: ' + act.name);
            Case oldCase = (Case) trigger.oldMap.get(act.case__c);  
            
            string updatedDescription = '';
            string activityUpdate = '';
            string overallUpdate = '';
            
            if (oldCase.description != c.description ){
                updatedDescription += '\nDescription: ' + c.description;    // applies to all activities
                
            }
            

        
            if ( c.Acct_Misapplied_To__c == act.financial_account__c) {
                if ( oldCase.Effective_Date__c != c.Effective_Date__c){
                    activityUpdate += '\nEffective Date: ' +c.Effective_Date__c.format();
                }
                if ( oldCase.Payment_Amount__c != c.Payment_Amount__c){
                    activityUpdate += '\nPayment Amount: ' + string.valueOf(c.Payment_Amount__c)  ;
                }
                overallUpdate = updatedDescription + activityUpdate;

                if (overallUpdate != '') {
                    overallUpdate = '\n\n*** Updated: ' + datetime.now().format() + ' ***' + overallUpdate;
                    act.description__c += overallUpdate;
                }
                    
            }
            
            activityUpdate = '';
            overallUpdate = '';
            if ( c.Apply_to_Account1__c == act.financial_account__c) {
                if ( oldCase.Effective_Date1__c != c.Effective_Date1__c){
                    activityUpdate += '\nEffective Date: ' +c.Effective_Date1__c.format();
                }
                if ( oldCase.Payment_Amount1__c != c.Payment_Amount1__c){
                    activityUpdate += '\nPayment Amount: ' + string.valueOf(c.Payment_Amount1__c)  ;
                }
                overallUpdate = updatedDescription + activityUpdate;

                if (overallUpdate != '') {
                    overallUpdate = '\n\n*** Updated: ' + datetime.now().format() +  ' ***' + overallUpdate;
                    act.description__c += overallUpdate;
                }
                    
            }
            
            activityUpdate = '';
            overallUpdate = '';
            if ( c.Apply_to_Account2__c == act.financial_account__c) {
                if ( oldCase.Effective_Date2__c != c.Effective_Date2__c){
                    activityUpdate += '\nEffective Date: ' +c.Effective_Date2__c.format();
                }
                if ( oldCase.Payment_Amount2__c != c.Payment_Amount2__c){
                    activityUpdate += '\nPayment Amount: ' + string.valueOf(c.Payment_Amount2__c)  ;
                }
                overallUpdate = updatedDescription + activityUpdate;

                if (overallUpdate != '') {
                    overallUpdate = '\n\n*** Updated: ' + datetime.now().format() +  ' ***' + overallUpdate;
                    act.description__c += overallUpdate;
                }
                    
            }
            updatedActivities.add(act);
        }
        return updatedActivities;
    }
    

}