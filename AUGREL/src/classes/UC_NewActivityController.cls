public with sharing class UC_NewActivityController {

    
    // jhicks 1/25/16
    // Copied the UC_NewCaseController.  Removed any unnecessary code, but kept the high level
    // sObject variables (eg "newCase", "savedCase") so that we could use the same VF markup for both objects.
      
    private String activityType {get; Set;}
    public Financial_Account__c   FA  {get; set;}
    public Financial_Account_Customer__c   FAC  {get; set;}
    
    public TFS_Activity__c newCase {get; set;}
    public TFS_Activity__c savedCase {get; set;}
    public string   selectedContact  {get; set;}
    
    public boolean saveSuccessful {get; set;}
    public boolean pageIsVisible {get; set;}
    public boolean isActivity {get; set;}
    public boolean showContactName {get; set;}
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
    private string action;
    private string originalRecordType;
    private Case parentCase;
    public string ServiceChannel{get; set;}
    public string InitialServiceChannel{get; set;}
    public string   tempServiceChannel  {get; set;} 
    
     
    public UC_NewActivityController(apexPages.standardController controller) {
        
        string objName = controller.getRecord().getSObjectType().getDescribe().getName();
        
        if (objName == 'Financial_Account__c') {
            FA = [select Id,name, recordTypeId, recordType.name, code_edit_message__c, type_code_description__c,
                   make__c, dealership__c, dealership__r.Account_number__c from Financial_Account__c where Id = : controller.getId() limit 1 ];
                   system.debug('++++ ObjName = ' + objName);
                    system.debug(fa);
        }
           
        init();
        
    }
    
    public void init() {
        facReadOnly = true;
        saveSuccessful = false;
        pageIsVisible = true;

        try {
            primaryBorrower = [select Id,Customer_Full_Name__c,Home_Phone_Garage__c,financial_Account_Customer__c  from Financial_Account_Customer__c  where Financial_Account__c =  : fa.Id 
            and Customer_Role_Type__c = '0-Primary Borrower' and Borrower_Status__c = 'Active' limit 1];
        }
        catch(exception e){}
        
        try {coBorrower = [select Id,Customer_Full_Name__c,Home_Phone_Garage__c,financial_Account_Customer__c  from Financial_Account_Customer__c where Financial_Account__c =  : fa.Id 
            and  Customer_Role_Type__c = '6-Co-Borrower' and Borrower_Status__c = 'Active'  limit 1];
        }
        catch(exception e){}
     
        // get Activity fieldsets
        fieldSetMap = new Map<String, List<Schema.FieldSetMember>>();
        for(Schema.FieldSet fs : Schema.SObjectType.TFS_Activity__c.fieldSets.getMap().values()){
            if (fs.getName().startsWith('UC_')) {
                 fieldSetMap.put(fs.getLabel(),fs.getFields());
            } 
        } 
        fields = new List<Schema.FieldSetMember> (); 
        
        // get FA fieldsets
        faFieldSetMap = new Map<String, List<Schema.FieldSetMember>>();
        for(Schema.FieldSet fs : Schema.SObjectType.Financial_Account__c.fieldSets.getMap().values()){
            if (fs.getName().startsWith('UC_')) {
                 faFieldSetMap.put(fs.getLabel(),fs.getFields());
            } 
        } 
        faFields = new List<Schema.FieldSetMember> (); 
        try {
            accountStatus = UC_Account_Status__c.getInstance(fa.code_edit_message__c).salesforce_message__c ;   
        }
        catch(exception e) {accountStatus = null;}
        system.debug('++++ account status: ' + fa.code_edit_message__c + ' / ' + accountStatus);

        // get FAC fieldsets
        facfieldSetMap = new Map<String, List<Schema.FieldSetMember>>();
        for(Schema.FieldSet fs : Schema.SObjectType.Financial_Account_Customer__c.fieldSets.getMap().values()){
            if (fs.getName().startsWith('UC_')) {
                 facfieldSetMap.put(fs.getLabel(),fs.getFields());
            } 
        } 
        facfields = new List<Schema.FieldSetMember> (); 
    }
    
    public void getFields() {
        // get fields from fieldsets to be displayed on the publisher
      
        activityType = newCase.Topic__c;
        try {
                fields = fieldSetMap.get(activityType);
        }
        catch(exception e) {fields = new List<Schema.FieldSetMember> (); }
        
        system.debug('++++ field set: ' + activityType );
 
        
        try {
            faFields = faFieldSetMap.get(activityType);
        }
        catch(exception e) { faFields = new List<Schema.FieldSetMember> (); }
        
        if (faFields == null)
            faFields = new List<Schema.FieldSetMember> (); 
        
        // the FA needs to be queried.  Fieldset may have different fields. 
        string query = 'SELECT ';
        for(Schema.FieldSetMember f : faFields) {
            query += f.getFieldPath() + ', ';
        }
        string faId = fa.Id;
        query += 'Id, recordTypeId, recordType.name, make__c, dealership__r.Account_number__c from Financial_Account__c where Id = :faId';
            
        system.debug('++++++ FA Query: ' +query); 
                

        FA = database.query(query);
        system.debug('++++++ FA : ' +fa);

        /* End FA Fields */
        system.debug('+++ FA Fields: ' + faFields);
 
 
        /*  FAC Fields - if any */
        
        /* There are no FAC fields for Activity publisher.  Commenting out code to improve coverage 
        // If Contact is not the primary or coborrower, no FAC fields will be shown

           // Contact is primary or co
            try {
                facFields = facFieldSetMap.get(activityType).clone();     
            }
            catch(exception e) { facFields = new List<Schema.FieldSetMember> (); }
            
            if (facFields == null)
                facFields = new List<Schema.FieldSetMember> (); 
            
            // the FA needs to be queried.  Fieldset may have different fields. 
            
    
            query = 'SELECT ';
            for(Schema.FieldSetMember f : facFields) {
                query += f.getFieldPath() + ', ';
            }
            string facId = newCase.Financial_Account_Customer__c;
            query += 'Id from Financial_Account_Customer__c where Id = :facId';
    
            system.debug('++++++ FAC Query: ' +query); 
                    
            try{
                FAC = database.query(query);
                system.debug('++++++ FAC : ' +fac);
                
                for (integer i=0; i < facFields.size(); i++ ) {
                    System.debug('*** checking on field: ' + facFields[i].getFieldPath());
                    // Now remove Billing Address fields if they are null.
                    // User is not allowed to add new billing addresses
                    if (facFields[i].getFieldPath().startsWithIgnoreCase('Billing') || facFields[i].getFieldPath().containsIgnoreCase('BillTo')){
                        if (FAC.Mailing_Street_BillTo__c == null && FAC.Mailing_City_BillTo__c == null && FAC.Mailing_State_BillTo__c == null &&
                                    FAC.Mailing_PostalCode_BillTo__c == null) {
                            facFields.remove(i);
                            i--;
                        }
                    } 
                }
            }catch (System.Exception ex){
               string message = ex.getMessage().replace('First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
               message = message.replace(': []','');
      
                system.debug('message: ' + message);          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
                SaveSuccessful = false;
            }
          
        
           End FAC Fields */
       
    }   
    
    public void CallToAction() {

        this.action = 'Call to Action';
        newCase();
    }
      
    private void newCase() {
        
        string recordType = 'Lead Activity';
 
        Schema.DescribeSObjectResult obj = Schema.SObjectType.TFS_Activity__c;   
        Map<String,Schema.RecordTypeInfo>caseActivityTypeMap = obj.getRecordTypeInfosByName();
        
                     // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
        
        string serviceType = 'Inbound Call';
        tempinteraction__c ti = new tempinteraction__c();
        try {
             ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
              if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             serviceType = ti.Interaction_Type__c ;
        }
        catch(exception e){}   // NO RECORD FOUND
        
        system.debug('**** Service Channel: ' + serviceType);
   
        newCase = new TFS_Activity__c(Financial_Account__c = FA.Id, recordTypeId= caseActivityTypeMap.get(recordType).getRecordTypeId(), action__c = this.action,
                    Service_Type__c=serviceType, make__c = fa.make__c,Dealership__c = fa.dealership__c );

          //W-000215 Added Interaction Type - modified jhicks 1/28
  
  
        originalRecordType = recordType;
        showContactName = false;
        populateContacts();  
        getFields();      
    }
    
    public void populateContacts () {
            contacts = new List<selectOption>();
            
            for (Financial_Account_Customer__c fac : [Select Id, Name, Customer_Role_Type__c From Financial_Account_Customer__c 
                where Financial_Account__c = :FA.Id and (Customer_Role_Type__c = '0-Primary Borrower' or Customer_Role_Type__c = '6-Co-Borrower')
                and Borrower_Status__c = 'Active'
                order by Customer_Role_Type__c]) {
                contacts.add(new selectOption(fac.Customer_Role_Type__c.substring(2), fac.Name));
            }
  
           // system.debug('++++ contact select options: ' + contacts);
            
            selectedContact = 'Primary Borrower';
            setShowContact();

    }
 

    public void checkRecordType() {}
    
    public void cancelCase() {
        fields = new List<Schema.FieldSetMember> (); 
        newCase();
    }    
    
   
   public void clearMessage() {}
   
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
    
   public void setShowContact() {
            
      if(selectedContact == 'Primary Borrower') {
         newCase.Financial_Account_Customer__c = primaryBorrower.Id;
         newCase.Financial_Account_Customer_ID__c = primaryBorrower.financial_Account_Customer__c;
         newCase.Preferred_Contact__c = primaryBorrower.Home_Phone_Garage__c;
         showContactName = false;
      }
      
      else if (selectedContact == 'Co-Borrower') {
         newCase.Financial_Account_Customer__c = coBorrower.Id;
         newCase.Financial_Account_Customer_ID__c = coBorrower.financial_Account_Customer__c;
         newCase.Preferred_Contact__c = coBorrower.Home_Phone_Garage__c;
         showContactName = false;
        
      }
      newCase.service_recipient__c = selectedContact;
   }
   
   private void setDefaults() {
     // copy Dealer Name to text fields
  
     newCase.dealer__c = fa.dealership__r.Account_number__c;
   }
     
    // after case is saved & console is refreshed, reset this to false for next case
    public void resetSaveSuccessful() {
        saveSuccessful = false;
    }
    
   public PageReference createCase() {
   
   iF(ServiceChannel==null){
            newCase.Service_Type__c='Action Request';
     }    
        setDefaults();
        // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
        //W-000215 Added Interaction Type
        try {
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             newCase.ani__c = ti.ani__c;
             newCase.conn_Id__c = ti.conn_id__c;
             if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
            // if (newCase.Service_Type__c != 'Customer Correspondence') // skip for certain case types
                  newCase.Service_Type__c= ti.Interaction_Type__c;
          
        }
        catch(exception e){}
     
        // insert the case
        InitialServiceChannel=ServiceChannel;
         
        savePoint sp = Database.setSavepoint();
         
        TFS_Activity__c caseBeforeInsert = newCase.clone(false, true);   // in case there is an error in FAC update. this is deep clone.
        system.debug('+++ caseBeforeInsert1: ' + caseBeforeInsert);
            
        if ( insertCase()) {
             savedCase = newCase;
             newCase();
             ServiceChannel=null;
           tempServiceChannel=null;
             
        }
        else {
            
            Database.rollback(sp);
            system.debug('+++ caseBeforeInsert2: ' + caseBeforeInsert);
            newCase = caseBeforeInsert;
            system.debug('+++ Case Restored: ' + newCase);
            ServiceChannel=InitialServiceChannel;
        }
  
        return null;
    }     
    
    
    public boolean insertCase() {
          
        try {
            System.debug('**** the inserted Case: '+newCase);
            insert newCase; 
           
            // update FAC if necessary
            
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