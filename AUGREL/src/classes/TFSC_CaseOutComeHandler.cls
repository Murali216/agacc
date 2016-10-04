/**
    * TFSC_CaseOutComeHandler - Trigger class for Cases
    * @author: Joanne Hicks
    * @version: 2.0
    * W-000513: updated service result advanced logic
*/

public with sharing class TFSC_CaseOutComeHandler implements TFSC_TriggerDispatcher.Handler {
    
    private static final String XDEFAULT = 'Default'; 
    public static boolean TriggerAlreadyRun = False;

  
    public void handle() {
          
          if(trigger.isInsert)
          {
            TriggerAlreadyRun = True;
          } 
          findCaseOutcome(trigger.new);
          if(trigger.isBefore && trigger.isInsert)
          {
              setServiceTypeonCustomProfieChangeCase(trigger.new);// S-311850
              setDefaultValues(trigger.new);//W-001207
          }
          //W-000167 10/28/15 jhicks
          // update Service_Request_Category__c
          if (trigger.isBefore)
             getServiceResult(trigger.new);
 
    }
    // S-311850 #Start 7/10/2015 By Paras Dhingra
    private void setServiceTypeonCustomProfieChangeCase(List<Case> cases){
        Id customerProfileChangeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Customer Profile Change').getRecordTypeId();
        
        //find all related FA Ids, so that we can query against the temp interaction table
        Set<string> FAIds = new Set<string>();
        Set<string> FACIds = new Set<string>();
        Boolean DealerDailyCase = False;
        for(Case cs : Cases){
            if(cs.Financial_Account__c != null){
                FAIds.add(String.valueOf(cs.Financial_Account__c).left(15));
            }
            if(cs.Financial_Account_customer__c != null){
                FACIds.add(String.valueOf(cs.Financial_Account_customer__c).left(15));
            }
            if(cs.origin =='DDPIFP' || cs.origin =='DDPIFC' )
            {
              DealerDailyCase=True;
            }
        }
        //find corresponding interaction types based on related FA records
        Map<string, String> interactionmap = new Map<string, string>();
        for(tempInteraction__c inter : [SELECT Name, Interaction_Type__c FROM tempinteraction__c WHERE Name IN :FAIds] ){
            interactionmap.put(inter.name, inter.Interaction_Type__c);
        }
        //Find the Title Type
        
        Map<string, String> FATitlemap = new Map<string, string>();
        if(DealerDailyCase)
        {
        for(Financial_Account__c FALst : [SELECT id, Title__r.Title_Type__c FROM Financial_Account__c WHERE id IN :FAIds] ){
            FATitleMap.put(String.ValueOf(FAlst.id).left(15), String.ValueOf(FAlst.Title__r.Title_Type__c));
        }
        }
        //Find the FACID
        Map<string, String> FACmap = new Map<string, string>();
        Map<string, String> FACContactmap = new Map<string, string>();
        if(DealerDailyCase)
        {
        for(Financial_Account_customer__c FACLst : [SELECT id, Financial_account_Customer__c,Customer_Full_Name__c FROM Financial_Account_Customer__c WHERE id IN :FACIds] ){
            FACMap.put(String.ValueOf(FAClst.id).left(15), String.ValueOf(FAClst.Financial_Account_Customer__c));
            FACContactMap.put(String.ValueOf(FAClst.id).left(15), String.ValueOf(FAClst.Customer_Full_Name__c));
        }
        }
       
        
        for(Case cs : cases){
            if(cs.RecordTypeId == customerProfileChangeId && cs.Financial_Account__c!=null){
                String interactiontype = interactionmap.get(String.valueOf(cs.Financial_Account__c).left(15));
                if(interactiontype !=null){
                   cs.Service_Type__c = interactiontype;
                }
            }
            if((cs.origin =='DDPIFP' || cs.origin =='DDPIFC') && trigger.isInsert)
            {
              

              String FACCID = FACmap.get(String.ValueOf(cs.Financial_Account_Customer__c).left(15));
              cs.Financial_Account_Customer_id__c=FACCID;
              String ContactName = FACContactmap.get(String.ValueOf(cs.Financial_Account_Customer__c).left(15));
              cs.Contact_Name__c = ContactName;
            
            if(DealerDailyCase)
            {
            if(cs.origin =='DDPIFP')
            {
              cs.Pif_group__c='';
              system.debug('FA****'+cs.financial_Account__c);
              system.debug('FAMAP****'+FATitleMap);

              String TitleType = FATitlemap.get(String.ValueOf(cs.Financial_Account__c).left(15));
              system.debug('TitleType****'+TitleType);
              
              if(TitleType == 'ELT')
                {
                  cs.Pif_group__c ='ELT Portal';
                  cs.CaseAssignmentRule__c = '';
                }else if (TitleType == 'Paper') {
                
                  cs.Pif_group__c ='Lease Portal';
                  cs.CaseAssignmentRule__c = ''; 
                }

                if(cs.Pif_group__c =='')
                {
                cs.CaseAssignmentRule__c = 'Admin - PIF Specialists';
                }
              //

            }
          }
        }

        }
    }
    // S-311850 #end
    private void findCaseOutcome(List<Case> cases) {

        List<Case> filteredCases = new List<Case>{};
        Set<String> subjects = new Set<String>{ XDEFAULT };
        for(Case c : cases) {
            //find cases that are now resolved but have no related outcome
            if ( c.Status == 'Resolved' && c.CaseOutCome__c == null) {
                subjects.add(c.Subject);
                filteredCases.add(c);
            }
        }

        if (!filteredCases.isEmpty()) {

            //find available and relevant CaseOutComes.  this includes the 'Default' outcome
            Map<string, CaseOutCome__c> caseOutComesMap = new Map<String, CaseOutCome__c>();
            for(CaseOutCome__c coc : [
                select CaseSubject__c, OutComeId__c
                from CaseOutCome__c
                where CaseSubject__c in :subjects
            ]) {
                caseOutComesMap.put(coc.CaseSubject__c, coc);
            }

            if (!caseOutComesMap.isEmpty()) {
                
                for(Case c : filteredCases) {
                    //if there is an outcome by subject
                    if ( caseOutComesMap.containsKey(c.Subject) ) {
                        c.CaseOutCome__c = caseOutComesMap.get(c.Subject).id;
                    } 
                    //else assign the defult outcome if available
                    else if ( caseOutComesMap.containsKey(XDEFAULT) ) {
                        c.CaseOutCome__c = caseOutComesMap.get(XDEFAULT).Id;
                    }

                }

            }

        }

    }
    
      //W-000167 10/28/15 jhicks
      // update Service_Request_Category__c
     private void getServiceResult(List<Case> cases) {
        
        string serviceRequestType = [select id, Service_Request_User_Group__c, Service_Request_Service_Type__c 
                                     from user where id = :UserInfo.getUserId()].Service_Request_User_Group__c;
        Id SupportRequestId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Support Request').getRecordTypeId();
        Id DueDateCRId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Due Date Change Request').getRecordTypeId();  
        Id WebcaserecordId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Web-To-Case').getRecordTypeId();                         
    Id ComplaintrecordId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Complaint').getRecordTypeId();  
          
       //W-000513 added transfer_to__c
        for (Case cs : cases) {
            if(cs.RecordTypeId != ComplaintRecordId)
          {  
              cs.Service_Result__c = TFSC_Utils.getServiceResult 
                (cs.action__c, cs.Category__c, cs.Service_Request_Type__c, cs.Payment_Channel__c, cs.Self_Service_Channel__c, cs.status, cs.Transfer_to__c, cs.Denial_Reason__c,False);
          } 
              if(trigger.isInsert)
              {
              If(cs.service_request_user_Group__C == null)
              {
                cs.Service_Request_User_Group__c = serviceRequestType ;
              }
             }else{

              if(TriggerAlreadyRun != True )
              {
                if(UserInfo.getname() != 'Integration User')
                {
                  cs.Service_Request_User_Group__c = serviceRequestType ;
                  system.debug('User Name'+UserInfo.getName());
                }else{
                  if(cs.origin =='DDPIFP' || cs.origin =='DDPIFC' )
                  {
                    cs.Service_Request_User_Group__c = 'SFDC System' ;  
                  }else  {
                    cs.Service_Request_User_Group__c = serviceRequestType;  
                  }
                  
                }
              }
            }

              //Add logic for ACT
              if(cs.RecordTypeId == SupportRequestId && cs.Source_System_Created_By__c == 'SFDC')
              {
                   cs.Action__c = 'Communities';
                   cs.Category__c = 'EMS comments';
                   cs.Service_Request_Type__c = 'Support Request';
                   
              }
              
              if(cs.RecordTypeId == DueDateCRId && cs.Source_System_Created_By__c == 'SFDC')
              {
                   cs.Action__c = 'Start Process';
                   cs.Category__c = 'Contract Modifications';
                   cs.Service_Request_Type__c = 'Due Date Change';
                   
              }
              
              if(cs.RecordTypeId == WebcaserecordId && cs.Source_System_Created_By__c == 'SFDC')
              {
                   cs.Action__c = 'Web to Case';
                   cs.Category__c = 'Web to Case';
                   cs.Service_Request_Type__c = 'Web to Case';
                   
              }
              //End logic for ACT
        }
     }
     //W-1207
private void setDefaultValues(List<Case> cases) {
//add logic
Id UCStartProcessId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Start Process').getRecordTypeId();
Id UCTitleReleaseId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Title Release').getRecordTypeId();

for (Case cs : cases) {
 //Dealer Daily Child Case
 if(cs.origin =='DDPIFC')
  {
    cs.Action__c = 'Start Process';
    cs.Category__c = 'Lease End';
    cs.Service_Request_Type__c ='Dealer Portal Lease Payoff';
    cs.Service_Type__c = 'Customer Correspondence';
    cs.Service_Recipient__c ='Primary Borrower';
    cs.RecordTypeId = UCStartProcessId;
    cs.Source_System_Created_By__C = 'SFDC';
    cs.Service_Request_User_Group__c = 'SFDC System';
    cs.Source_Created_By__c = 'Integration User';
    cs.Status = 'In Process';
    cs.ODO_Statement_Status__c = 'Pending'; 
    
  }
 //Dealer Daily Parent Case
  if(cs.origin =='DDPIFP')
  {
    //cs.Title__c = cs.Financial_Account__r.Title__r.id;
    cs.Status = 'Hold';
    cs.Action__c = 'Start Process';
    cs.Category__c = 'Title';
    cs.Service_Request_Type__c ='PIF Release';
    cs.Service_Type__c = 'Customer Correspondence';
    cs.Service_Recipient__c = 'Primary Borrower';
    cs.RecordTypeId = UCTitleReleaseId;
    cs.Source_System_Created_By__C = 'SFDC';
    cs.Service_Request_User_Group__c = 'SFDC System';
    cs.Source_Created_By__c = 'Integration User';
    cs.RETURN_ASSIGNMENT__C = 'Use Queue Rules';
    cs.CASEASSIGNMENTRULE__C = 'Admin - Holding Queue';
    cs.RUNRULES__C = True;
    


  }
}
//End W-001207
}

}