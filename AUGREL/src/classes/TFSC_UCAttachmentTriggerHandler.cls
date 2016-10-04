/**
    * Attachment Trigger Controller - Used to handle Attachment trigger
    * @author: Abhishek Ballabh
    * @version: 1.0
*/
public with sharing class TFSC_UCAttachmentTriggerHandler  implements TFSC_TriggerDispatcher.Handler {

 public static boolean alreadyProcessed = false;
    public  Set<Id> CaseIds = new Set<Id>();
    public  List<CaseComment> CaseCommentlst = new List<CaseComment>();

    public void handle(){
        system.debug('+++ TFSC_UCAttachmentTriggerHandler - alreadyProcessed: ' + alreadyProcessed);
        if (!alreadyProcessed ) {
            execute(trigger.new);
        }
    }
    

    public void execute(List<Attachment> AttachmentList) {
          
            alreadyProcessed = true;
            Id DueDaterecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Due Date Change Request').getRecordTypeId();
            Id SupportRequestrecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Support Request').getRecordTypeId();
           //Go through the attachments and filter Case related attachments
            for (Attachment Att : AttachmentList) {

                Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
                Map<String, Schema.DescribeSObjectResult> descMap=new Map<String,
                Schema.DescribeSObjectResult>();
                for(Schema.SObjectType sot : schemaMap.values())
                {
                    Schema.DescribeSObjectResult descRes=sot.getDescribe();
                    String kp=descRes.getKeyPrefix();
                    descMap.put(kp, descRes);
                }
                String prefix = String.valueOf(att.ParentId).substring(0, 3);
                Schema.DescribeSObjectResult descObj=descMap.get(prefix);
                System.debug('## Name = ' + descObj.getName());
                if(descObj.getName() == 'Case')
                {
                    System.debug('**** ParentId:'+String.valueOf(att.ParentId));
                        if(String.valueOf(att.ParentId)!= '')
                        {
                        CaseIds.add(att.ParentId);
                        }
                }
            
            }
            // Check if the Case belongs to particular RT and then create Case Comment
            for(Case Caselst : [SELECT Id, RecordtypeId FROM Case WHERE Id IN :CaseIds] ){

                if(Caselst.RecordtypeId==DueDaterecordTypeId || CaseLst.RecordtypeId == SupportRequestrecordTypeId)
                {
                    CaseCommentlst.add(new CaseComment(ParentId = CaseLst.Id, CommentBody='File Attached by Customer'));
                }

            }

            if(CaseCommentLst.size()>0)
            {
                Database.DMLOptions dlo = new Database.DMLOptions();
                dlo.EmailHeader.triggerUserEmail = true;
                database.insert(CaseCommentLst, dlo);

            }


    }
}