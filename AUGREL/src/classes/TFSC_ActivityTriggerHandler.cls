/* TFSC_ActivityTriggerHandler - Trigger class for Activity
    * @author: Joanne Hicks
    * @version: 2.0
    * W-000513: updated service result advanced logic
*/


public with sharing class TFSC_ActivityTriggerHandler implements TFSC_TriggerDispatcher.Handler {
    
    /* Handler for TFS_Activity__c before update/insert */
    
    public void handle(){
        execute(trigger.new);
    }
    
    public static void execute(List<TFS_Activity__c> activityList){
        
        system.debug('+++++++++++++++++++++++++++++++++ START SCTIVITY TRIGGER +++++++++++++++++++++++++++++++++++++++++++++++++++++');
        system.debug(activityList[0]);
        

        Set<Id> caseIds = new Set<Id>();
        for (TFS_Activity__c act : activityList) {
            if (act.case__c != null)
                caseIds.add(act.case__c);
        }
        
        Map<Id, Case> caseMap = new Map<Id,Case> ([select Id, financial_account__c, financial_account_customer__c, payment_channel__c, service_recipient__c
                       from case where id in :caseIds]);
        
        // get call interaction info            
         string ani = '';
         string connId = '';
         string Itype = '';
         
         // populate ani and connId if taking a call (customer profile edit)    
         // this is for customer profile edit activities which are generated by the system
         // and already have an fa id.
          //W-000215 Added Interaction Type
         try {
           string faId = activityList[0].financial_account__c;
           faId = faId.left(15);
           tempinteraction__c ti = [select  Interaction_Type__c,ani__c, conn_id__c from tempinteraction__c 
                                    where name = :faId  and createdById = :userInfo.getUserId() limit 1];
         
                 ani = ti.ani__c;
                 connId = ti.conn_id__c;
                 if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
                 IType= ti.Interaction_Type__c;
            }
         catch(exception e){}
        
        // get user's service request user group
        string serviceRequestType = [select id, Service_Request_User_Group__c, Service_Request_Service_Type__c 
                                     from user where id = :UserInfo.getUserId()].Service_Request_User_Group__c;
        

        for (TFS_Activity__c act : activityList){
            
            // populate Financial Account & Customer if Case is present
            if (act.case__c != null && act.financial_account__c == null) {
                act.financial_account__c = caseMap.get(act.case__c).financial_account__c;
                act.financial_account_customer__c = caseMap.get(act.case__c).financial_account_customer__c;
                
            }
            // make sure financial_account_customer_id__c is populated for integration
            if (act.financial_account_customer_id__c == null)
            	act.financial_account_customer_id__c = act.financial_account_customer__c;
             
            // populate service result, service recipient, ani, connId
            //W-000513 added blank as transfer to is not available for activity
            act.Service_Result__c = TFSC_Utils.getServiceResult(act.action__c, act.category__c, act.topic__c,  '', '', act.status__c,'','',act.Not_Interested__c);
             
            try {
            	//W-001317
            	if (act.Service_Recipient__c == null)
                	 act.Service_Recipient__c= caseMap.get(act.case__c).service_recipient__c;
            }
            catch(exception e){}
            
                
             act.ani__c = ani;
             act.conn_id__c = connId;       
             if(act.Service_Type__c !='Customer Correspondence' && IType!='')
             {
             act.Service_Type__c= Itype;
             }
                 
             if(act.service_request_user_group__c == null)
             {
             act.service_request_user_group__c = serviceRequestType;
             } 
            
            // special processing for Make a Payment
            if (act.case_action__c == 'Start Process' && act.case_category__c == 'Payments' && act.case_Topic__c == 'Make a Payment'
                        && act.Description__c != null) {    
                string activityDesc = act.Description__c.replace('$','').replace(',','');
                List<string> sDesc = activityDesc.split(' ');
                
                // parse description field and update:
                // payment amount, payment date, processing associate, confirmation number fields
                
                try {
                    for(integer i = 0; i < sDesc.size()-3; i++) {
                        //system.debug('+++ desc' + i +': ' + sDesc[i]);
                        
                        if (sDesc[i] == 'Payment'  && sDesc[i+1] == 'Amount:')
                            act.Payment_Amount__c = double.valueOf(sDesc[i+2]);
                            
                        else if (sDesc[i] == 'Payment'  && sDesc[i+1] == 'Date:')
                            act.Payment_Date__c = date.parse(sDesc[i+2]);
                            
                        else if (sDesc[i] == 'Collector'  && sDesc[i+1] == 'ID:')
                            act.Processing_Associate__c = sDesc[i+2];
                            
                        else if (sDesc[i] == 'Transaction'  && sDesc[i+1] == 'Confirmation'  && sDesc[i+2] == 'Number:'  ) 
                             act.Confirmation_Number__c= sDesc[i+3];                
                        
                    }
                }
                catch(exception e) {
                    act.addError(e);
                }
            }
            else if (act.case_action__c == 'Start Process' && act.case_category__c == 'Payments' && act.case_Topic__c == 'Refund'
                        && caseMap.get(act.case__c).payment_channel__c == 'WUSP' && act.Description__c != null) {   
                string activityDesc = act.Description__c.replace('$','').replace(',','');
                List<string> sDesc = activityDesc.split(' ');
                
                        system.debug('+++ act.Description__c' + act.Description__c);
                        system.debug('+++ sDesc:sDesc' + sDesc);
                        
                        
                // parse description field and update:
                // payment amount, payment date, processing associate, confirmation number fields
                
                try {
                    for(integer i = 0; i < sDesc.size()-3; i++) {
                        system.debug('+++ desc' + i +': ' + sDesc[i]);
                        
                        if (sDesc[i] == 'Refund'  && sDesc[i+1] == 'Amount:')
                            act.Refund_Amount__c = double.valueOf(sDesc[i+2]);
                            
                        else if (sDesc[i] == 'Payment'  && sDesc[i+1] == 'Date:')
                            act.Original_Payment_Date__c = date.parse(sDesc[i+2]);
                            
                        else if (sDesc[i] == 'Collector'  && sDesc[i+1] == 'ID:')
                            act.Processing_Associate__c = sDesc[i+2];
                            
                        else if (sDesc[i] == 'Transaction'  && sDesc[i+1] == 'Confirmation'  && sDesc[i+2] == 'Number:'  ) 
                             act.Confirmation_Number__c= sDesc[i+3];                
                        
                    }
                }
                catch(exception e) {
                    act.addError(e);
                }
            }           
        }
        system.debug('+++++++++++++++++++++++++++++++++ END ACTIVITY TRIGGER +++++++++++++++++++++++++++++++++++++++++++++++++++++');
                
    }
    

}