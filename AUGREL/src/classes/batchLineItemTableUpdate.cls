global class batchLineItemTableUpdate implements Database.Batchable<sObject>
{

    Set<ID> allValidArticleRecordID = new Set<ID>(); 
    
    global batchLineItemTableUpdate() {       
    }
    
    global batchLineItemTableUpdate( Set<ID> allValidArticleRecordID1) {
    allValidArticleRecordID = allValidArticleRecordID1; 
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
   
    {   
        String query = 'SELECT ID, is_Broken__c, Title__c,Original_Article_URL__c FROM LinkValidation__c ';
        return Database.getQueryLocator(query);      // returns AccountId and UserOrGroupId for queries below.  

    }
    global void execute(Database.BatchableContext BC, List<LinkValidation__c> scope)
    {
       
      
         
         List<LinkValidation__c> deleteTrulyBrokenLineItemWithIsBrokenTrue =  new List<LinkValidation__c>();     
         List<LinkValidation__c> updateNotTrulyBrokenLineItemWithIsBrokenTrue =  new List<LinkValidation__c>();     
                
        for(LinkValidation__c lv : scope ) {  
            List<String> articleVersionID= lv.Original_Article_URL__c.split('my.salesforce.com/');
            String articleVerID = articleVersionID[1]; 
            if(lv.is_Broken__c == false) { 
                       if(!allValidArticleRecordID.contains(articleVerID)) {                        
                    lv.is_broken__c = true;                     
                    deleteTrulyBrokenLineItemWithIsBrokenTrue.add(lv); 
                   }   
             }else if(lv.is_Broken__c == true) {
                     if(!allValidArticleRecordID.contains(articleVerID)) {
                   deleteTrulyBrokenLineItemWithIsBrokenTrue.add(lv);                              
                   } else {
                     lv.is_Broken__c = false;
                   updateNotTrulyBrokenLineItemWithIsBrokenTrue.add(lv);                   
                   }           
              }                     
        }   
            delete deleteTrulyBrokenLineItemWithIsBrokenTrue ;
           update updateNotTrulyBrokenLineItemWithIsBrokenTrue;
    }    
       
    global void finish(Database.BatchableContext BC)
    {
       
    }
}