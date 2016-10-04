trigger TFSC_ActivityTrigger on TFS_Activity__c (before insert, before update, after insert) {
String bulkLoadIndicator;
String ByPass;
    
    try{
          ByPass='False';
          bulkLoadIndicator = Label.Bulk_Load_In_Progress;
                if(UserInfo.GetName().contains('Integration User'))
                {
                
                If(bulkLoadIndicator =='False')
                {
                ByPass ='True';
                System.Debug('Integration User Found 789');
                }  
                }       
            }       
        
        catch(Exception e){
            ByPass = 'False';
        }
        if(Bypass.toUpperCase() != 'TRUE'){
        system.debug('Trigger Fires on Activity 123');
    new TFSC_TriggerDispatcher()
        .bind(TFSC_TriggerDispatcher.Evt.beforeinsert, new TFSC_ActivityTriggerHandler())
        .bind(TFSC_TriggerDispatcher.Evt.beforeupdate, new TFSC_ActivityTriggerHandler())
        .bind(TFSC_TriggerDispatcher.Evt.afterinsert, new TFSC_ActivityTriggerAfterHandler())
        .manage(); 
        }
}