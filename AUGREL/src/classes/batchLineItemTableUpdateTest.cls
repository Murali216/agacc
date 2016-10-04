@istest
private class batchLineItemTableUpdateTest  {
    
    
    static testmethod void testMethod1() {
    
        List<LinkValidation__c> lvalUpdate = new  List<LinkValidation__c> ();
        List<LinkValidation__c> lval = new List<LinkValidation__c>();
      
       // Insert line ietm record 
       for (Integer i=0;i<100;i++) {
           LinkValidation__c l = new LinkValidation__c(              
               Title__c='Handle Louisiana Voluntary Repossession for CSR and Late Stage new 1',
               Version_Number__c=1,
               is_broken__c =false,
               Article_Type_Label__c='How_To_A__ka',
               Link__c='http://stellent/intradoc/groups/bopp/documents/boppform/bopp-f6014.pdf',
               // use an invalid article
               Original_Article_URL__c='https://tfs.my.salesforce.com/ka119000000ClvAAAS'
               );
           lval.add(l);
       }
       insert lval;
      system.debug('%%%%lval'+lval);
     // Delete truly broken line item
       if(lval.size()>0) { 
           for (Integer i=0;i<5;i++) {
           LinkValidation__c l = new LinkValidation__c(              
               ID=lval[i].id,
               is_Broken__c =true);               
           lvalUpdate.add(l);
        }
      }
       system.debug('%%%%lvalUpdate'+lvalUpdate);
       
       update lvalUpdate;
     
       
       Set<ID> allrecordID = new Set<ID>();
       Test.startTest();
       batchLineItemTableUpdate c = new batchLineItemTableUpdate(); 
       batchLineItemTableUpdate c1 = new batchLineItemTableUpdate(allrecordID);      
       Database.executeBatch(c);       
       Test.stopTest();
    }
   
   }