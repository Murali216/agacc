/**
    * Attachment Trigger  - Trigger on attachment
    * @author: Abhishek Ballabh
    * @version: 1.0
*/
trigger TFSC_AttachmentTrigger on Attachment (before insert, before update) {

    new TFSC_TriggerDispatcher()
        .bind(TFSC_TriggerDispatcher.Evt.beforeinsert, new TFSC_UCAttachmentTriggerHandler())
        .bind(TFSC_TriggerDispatcher.Evt.beforeupdate, new TFSC_UCAttachmentTriggerHandler())
        
        .manage();

}