public with sharing class UC_NewRelatedActivityController {

     
    // jhicks 1/25/16
    // Copied the UC_NewCaseController.  Removed any unnecessary code, but kept the high level
    // sObject variables (eg "newCase", "savedCase") so that we could use the same VF markup for both objects.
      
    private String activityType {get; Set;} 
    public Financial_Account__c   FA  {get; set;}
    public Financial_Account_Customer__c   FAC  {get; set;}
    
    public TFS_Activity__c newCase {get; set;}
    public TFS_Activity__c savedCase {get; set;}
    public string   selectedContact  {get; set;}
    public boolean showContactName {get; set;}
    public string relationshipName {get; set;}
    public boolean customerCorrespondence {get; set;}
    private boolean updateRelationship = false;     // determines if relationship should get updated.  set to true after initialization processes
    
    public boolean saveSuccessful {get; set;}
    public boolean pageIsVisible {get; set;}
    public boolean isActivity {get; set;}
    public List<selectOption> contacts {get; set;}
    private Financial_Account_Customer__c primaryBorrower = new Financial_Account_Customer__c();
    private Financial_Account_Customer__c coBorrower = new Financial_Account_Customer__c();
    // case fields
    public Map<String, List<Schema.FieldSetMember>> fieldSetMap;
    public List<Schema.FieldSetMember> fields {get; set;}
    
    // fa fields
    public Map<String, List<Schema.FieldSetMember>> faFieldSetMap;
    public List<Schema.FieldSetMember> faFields {get; set;}
    public string accountStatus  {get; set;}
    
    // fac fields
    public Map<String, List<Schema.FieldSetMember>> facFieldSetMap;
    public List<Schema.FieldSetMember> facFields {get; set;}
    public boolean facReadOnly {get; set;}
    
    
    public string sessionInfo {get; set;}
    public string action {get; set;}
    public string ServiceChannel{get; set;}
    public string   tempServiceChannel  {get; set;} 
    private string originalRecordType;
    private Case parentCase;
    
      
    public UC_NewRelatedActivityController(apexPages.standardController controller) {
        
        // CASE is the standard controller
        
        string caseId = controller.getId();
        parentCase = [select Id, financial_account__c, financial_account_customer__c,financial_account_customer__r.financial_account_customer__c, caseNumber, action__c, category__c, service_request_type__c,
                             service_type__c,status, service_recipient__c, contact_name__c, relationship_name__c from Case 
                      where id = :caseId];

            string FAId = parentCase.financial_account__c;
            FA = [select Id,name, recordTypeId, recordType.name, code_edit_message__c, type_code_description__c,
                   make__c, dealership__r.name from Financial_Account__c where Id = : FAId limit 1 ];
                   
        system.debug(fa);
        system.debug(parentCase);
        if(parentcase.service_type__c =='Customer Correspondence' || parentcase.service_type__c =='Action Request')
        {
        ServiceChannel=parentCase.service_type__c;
        tempServiceChannel =parentCase.service_type__c;
        }   
        init();
        
    }
    
    public void init() {
        facReadOnly = true;
        saveSuccessful = false;
        pageIsVisible = true;
        customerCorrespondence = false;

        try {
            primaryBorrower = [select Id,Customer_Full_Name__c,Home_Phone_Garage__c  from Financial_Account_Customer__c  where Financial_Account__c =  : fa.Id 
            and Customer_Role_Type__c = '0-Primary Borrower' and Borrower_Status__c = 'Active' limit 1];
        }
        catch(exception e){}
        
        try {coBorrower = [select Id,Customer_Full_Name__c,Home_Phone_Garage__c  from Financial_Account_Customer__c where Financial_Account__c =  : fa.Id 
            and  Customer_Role_Type__c = '6-Co-Borrower' and Borrower_Status__c = 'Active'  limit 1];
        }
        catch(exception e){}
        
        newCase();
    }
    

      
    
    public void getFields() {
    }   
    

    private void newCase() {
        
        string recordType = 'TFS Activity';
 
        Schema.DescribeSObjectResult obj = Schema.SObjectType.TFS_Activity__c;   
        Map<String,Schema.RecordTypeInfo>caseActivityTypeMap = obj.getRecordTypeInfosByName();
        
        newCase = new TFS_Activity__c(Financial_Account__c = FA.Id, recordTypeId= caseActivityTypeMap.get(recordType).getRecordTypeId(), 
             action__c = parentCase.action__c, category__c = parentCase.category__c, topic__c = parentCase.service_request_type__c,
                 case__c = parentCase.Id, financial_account_customer__c = ParentCase.financial_account_customer__c,
                 Financial_Account_Customer_ID__c = ParentCase.financial_account_customer__r.financial_account_customer__c,
                 status__c = ParentCase.status,  
                 contact_name__c = parentCase.contact_name__c, relationship_name__c = parentCase.relationship_name__c);

          //W-000215 Added Interaction Type - modified jhicks 1/28
  
        // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
  
        try {
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             newCase.ani__c = ti.ani__c;
             newCase.conn_Id__c = ti.conn_id__c;
             if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             newCase.Service_Type__c= ti.Interaction_Type__c;
        }
        catch(exception e){}
  
        originalRecordType = recordType;
        showContactName = false;
        populateContacts();  
        getFields();  
        system.debug(newCase);    
    }

    public void checkRecordType() {}
    
    public void cancelCase() {
        fields = new List<Schema.FieldSetMember> (); 
        newCase();
    }    
      
    // after case is saved & console is refreshed, reset this to false for next case
    public void resetSaveSuccessful() {
        saveSuccessful = false;
    }
    
    public void populateContacts () {
            contacts = new List<selectOption>();
            
            for (Financial_Account_Customer__c fac : [Select Id, Name, Customer_Role_Type__c From Financial_Account_Customer__c 
                where Financial_Account__c = :FA.Id and (Customer_Role_Type__c = '0-Primary Borrower' or Customer_Role_Type__c = '6-Co-Borrower')
                and Borrower_Status__c = 'Active'
                order by Customer_Role_Type__c]) {
                contacts.add(new selectOption(fac.Customer_Role_Type__c.substring(2), fac.Name));
            }
            
            // W-000195 - add additional contacts           
            contacts.add(new selectOption('Non-Signing Spouse', 'Non-Signing Spouse'));
            contacts.add(new selectOption('Third Party', 'Third Party'));
            contacts.add(new selectOption('Dealer', 'Dealer'));
            contacts.add(new selectOption('Bank/Insurance', 'Bank/Insurance'));
            contacts.add(new selectOption('TFS Team Member', 'TFS Team Member'));
            
            
            selectedContact = parentCase.service_recipient__c;
            setShowContact();
             system.debug('++++ selectedContact: ' + selectedContact);
 
 
    }  
  public void setShowContact() {
    
      system.debug('+++selectedContact: ' + selectedContact);
            
      if(selectedContact == 'Primary Borrower') {
         newCase.Financial_Account_Customer__c = primaryBorrower.Id;
         newCase.contact_name__c = primaryBorrower.Customer_Full_Name__c;
         showContactName = false;
         relationshipName = '';
         newCase.relationship_name__c = '';
      }
      
      else if (selectedContact == 'Co-Borrower') {
         newCase.Financial_Account_Customer__c = coBorrower.Id;
         newCase.contact_name__c = coBorrower.Customer_Full_Name__c;
         showContactName = false;
         relationshipName = '';
         newCase.relationship_name__c = '';
        
      } 
      else {
         newCase.Financial_Account_Customer__c = primaryBorrower.Id;
         //newCase.contact_name__c = null;
         showContactName = true;   
         relationshipName = '';
         if (updateRelationship)  {   //Contact has changed so clear out the relationship name and contact name
                 newCase.relationship_name__c = '';
                 newCase.contact_name__c = '';
         }
         if (selectedContact == 'Third Party')
            relationshipName = 'Relationship' ;
         else if (selectedContact == 'Dealer')  
            relationshipName = 'Dealer Name' ;   
         else if(selectedContact == 'Bank/Insurance')  
            relationshipName = 'Bank/Ins Name' ; 
         else if(selectedContact == 'TFS Team Member') 
            showContactName = false;   
              
        
      }
       
      system.debug('++++ contact name set: ' +  newCase.contact_name__c);
      system.debug('+++ showContactName: ' + showContactName);
      newCase.service_recipient__c = selectedContact;
      system.debug('+++newCase.service_recipient: : ' +  newCase.service_recipient__c);
      
      system.debug('++++ newCae after setShowContact(): ' + newCase);
      updateRelationship = true;
   }
    
    
   public void clearMessage() {}
   
   private void setDefaults() {
       //if (this.customerCorrespondence)  // in case no interation record
           // newCase.Service_Type__c = 'Customer Correspondence';
   }
    public void ServiceChannel() {
      if(ServiceChannel!=tempServiceChannel){
      if(ServiceChannel=='Customer Correspondence'){
            newCase.Service_Type__c='Customer Correspondence';
        }else if(ServiceChannel=='Action Request'){
            newCase.Service_Type__c='Action Request';
        }
        
       
       }else{
            ServiceChannel=null;
            newCase.Service_Type__c=null;
       }
        tempServiceChannel=newCase.Service_Type__c;
    }
   public PageReference createCase() {
        system.debug('**********   CREATE CASE ***************');
        setDefaults();
         // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
        //W-000215 Added Interaction Type
        try {
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             if(ti!=null){
                 newCase.ani__c = ti.ani__c;
                 newCase.conn_Id__c = ti.conn_id__c;
                 if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             //if (this.customerCorrespondence){
                // newCase.Service_Type__c = 'Customer Correspondence';
                 //}   else{
             
                  newCase.Service_Type__c = ti.Interaction_Type__c;
             // }
          }
        }
        catch(exception e){newCase.Service_Type__c = ServiceChannel;}
     
        // insert the case
         
        savePoint sp = Database.setSavepoint();
         ServiceChannel=null;
        tempServiceChannel=null;
        if(newcase.service_type__c==null)
        {
            newcase.service_type__c='Action Request';
        }
        TFS_Activity__c caseBeforeInsert = newCase.clone(false, true);   // in case there is an error in FAC update. this is deep clone.
        system.debug('+++ caseBeforeInsert1: ' + caseBeforeInsert);
            
        if ( insertCase()) {
             savedCase = newCase;
             newCase();
             
        }
        else {
            
            Database.rollback(sp);
            system.debug('+++ caseBeforeInsert2: ' + caseBeforeInsert);
            newCase = caseBeforeInsert;
            system.debug('+++ Case Restored: ' + newCase);
        }
  
        return null;
    }     
    
    
    public boolean insertCase() {
          
        try {
            
            System.debug('**** the inserted Case: '+newCase);
           if (newCase.contact_name__c == null && selectedContact != 'TFS Team Member')
                throw new DMLException('Please enter a value for Contact Name.');
            insert newCase; 
 
           SaveSuccessful = true; 
           return true;  

        } catch(System.Exception ex){
           string message = ex.getMessage().replace('First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
           message = message.replace(': []','');
  
            system.debug('exception: ' + ex);
            system.debug('message: ' + message);          
          // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
            apexPages.addMessages(ex);
            system.debug('apexPages.message: ' +new ApexPages.Message(ApexPages.Severity.ERROR, message) );

             SaveSuccessful = false;
            
            system.debug('+++ Save Successful: ' + SaveSuccessful);
            return false;
        } 
    } 

}