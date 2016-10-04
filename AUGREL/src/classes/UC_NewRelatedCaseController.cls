public with sharing class UC_NewRelatedCaseController {

    
    // the test method for this class is in faHighlightPanelTest
    
    private String serviceRequestType {get; Set;}
    public Financial_Account__c   FA  {get; set;}
    public Financial_Account_Customer__c   FAC  {get; set;}
    public Case newCase {get; set;}
    public Case savedCase {get; set;}
    public string   selectedContact  {get; set;}
    public boolean saveSuccessful {get; set;}
    public boolean pageIsVisible {get; set;}
    public boolean isActivity {get; set;}
    public boolean showContactName {get; set;}
    public boolean showSendToAddress {get; set;}
    public List<selectOption> contacts {get; set;}
    private Financial_Account_Customer__c primaryBorrower = new Financial_Account_Customer__c();
    private Financial_Account_Customer__c coBorrower = new Financial_Account_Customer__c();
    private UC_NewCase_SendTo AddUpdate;
    private Case parentCase;
    // case fields
    public Map<String, List<Schema.FieldSetMember>> fieldSetMap;
    public List<Schema.FieldSetMember> fields {get; set;}
    
    // fa fields
    public Map<String, List<Schema.FieldSetMember>> faFieldSetMap;
    public List<Schema.FieldSetMember> faFields {get; set;}
    public string accountStatus  {get; set;}
    public Boolean facReadOnly {get; set;}
      
    // fac fields
    public Map<String, List<Schema.FieldSetMember>> facFieldSetMap;
    public List<Schema.FieldSetMember> facFields {get; set;}
    
    // Unbound fields
    public List<UnBoundField> unboundF {get; Set;}
    
    public string sessionInfo {get; set;}
    private string action;
    private string originalRecordType;
    public List<selectOption> escalationOptions {get; set;}
    public string selectedEscalation {get; set;}
    public string relationshipName {get; set;}
    public string ServiceChannel{get; set;}
    public string   tempServiceChannel  {get; set;}
    public string   InitialServiceChannel  {get; set;}

    public UC_NewRelatedCaseController(apexPages.standardController controller) {
        
        //Standard Controller is Case
        string caseId = controller.getId();
        parentCase = [select Id, financial_account__c, financial_account_customer__c, caseNumber, action__c, category__c, service_request_type__c,service_type__c from Case 
                      where id = :caseId];

            string FAId = parentCase.financial_account__c;
            FA = [select Id,name, recordTypeId, recordType.name, code_edit_message__c, type_code_description__c,
                   make__c, dealership__r.name from Financial_Account__c where Id = : FAId limit 1 ];
                   
        if(parentcase.service_type__c =='Customer Correspondence' || parentcase.service_type__c =='Action Request')
        {
        ServiceChannel=parentCase.service_type__c;
        tempServiceChannel =parentCase.service_type__c;
        InitialServiceChannel =parentCase.service_type__c;
    }

        init();
        
        system.debug('********************** END OF init*********************');
        
        // need to create a temporary case so that Action picklist will display
        Schema.DescribeSObjectResult obj = Schema.SObjectType.Case; 
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        string recordTypeId = caseRecordTypeMap.get('UC - Request Information').getRecordTypeId();
        system.debug('**** recordtypeid: ' + recordTypeId);
        
        newCase = new Case(recordTypeId= recordTypeId);


        system.debug(newCase);
        system.debug(fa);
        system.debug(parentCase);
        system.debug('********************** END OF CONSTRUCTOR*********************');
    }
    
    public void init() {
    
        saveSuccessful = false;
        pageIsVisible = true;
        isActivity = false;
        showSendToAddress = false;

        try {
            primaryBorrower = [select Id,Customer_Full_Name__c  from Financial_Account_Customer__c  where Financial_Account__c =  : fa.Id 
            and Customer_Role_Type__c = '0-Primary Borrower' and Borrower_Status__c = 'Active' limit 1];
        }
        catch(exception e){}
        
        try {coBorrower = [select Id,Customer_Full_Name__c  from Financial_Account_Customer__c where Financial_Account__c =  : fa.Id 
            and  Customer_Role_Type__c = '6-Co-Borrower' and Borrower_Status__c = 'Active'  limit 1];
        }
        catch(exception e){}
     
        // get Case fieldsets
        fieldSetMap = new Map<String, List<Schema.FieldSetMember>>();
        for(Schema.FieldSet fs : Schema.SObjectType.Case.fieldSets.getMap().values()){
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
        catch(exception e) {accountStatus = null; }
        
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
   
 
     public void updateAction() {
        system.debug('************* arrived at updateAction() *********************');
        this.action = newCase.Action__c;
        newCase();     // will overwrite old new case and create a new one
    }
     
    public void getFields() {
        // if there has already been fields assigned
        // the values of the previous field set need to be nulled out to prevent validations
        // from miss firing
        if(fields!=null && fieldSetMap.get(ServiceRequestType)!=null){
            if(fields.size()>1){
                for(Schema.FieldSetMember thisField: fieldSetMap.get(ServiceRequestType)){
                    System.debug('**** currently updating field: '+thisField.getFieldPath());
                    newCase.put(thisField.getFieldPath(),null);
                }
            }                   
        }
        
        // get fields from fieldsets to be displayed on the publisher
        // some Categories have multiple field sets so we have to resolve those
        // check the ACT if there should be any screen elements displayed
        serviceRequestType = newCase.Service_Request_Type__c;
        showSendToAddress = false;
        if (newCase.action__c == 'Log Complaint' && newCase.Service_Request_Type__c == 'Payments') // resolve dup.
            serviceRequestType =  'Payments - Complaints';  
        else if (newCase.action__c == 'Request Information' && newCase.Service_Request_Type__c == 'Payoff Quote' && FA.recordType.Name == 'Lease') 
            serviceRequestType =  'Payoff Quote - Lease';           
        else if (newCase.action__c == 'Request Information' && newCase.Service_Request_Type__c == 'Payoff Quote' && FA.recordType.Name == 'Retail') 
            serviceRequestType =  'Payoff Quote - Retail';                
        else if (newCase.action__c == 'Start Process' && newCase.Category__c == 'Title'){
                        // jhicks 2/10/16 W-000580 - set flag to run assignment rules
            newCase.RunRules__c = true;
            if(newCase.Service_Request_Type__c == 'Lien Release' || newCase.Service_Request_Type__c == 'PIF Returned Mail'){
                showSendToAddress = true;
                newCase.Send_To__c = 'Customer';
                SendToUpdate();
            }
            
            if(newCase.Service_Request_Type__c == 'Follow Up' || newCase.Service_Request_Type__c == 'Discrepant' ||
                        newCase.Service_Request_Type__c == 'Duplicate Request' || newCase.Service_Request_Type__c == 'Lease Terminations' ||
                        newCase.Service_Request_Type__c == 'PIF Release' || newCase.Service_Request_Type__c == 'PIF ELT Rejects' ||
                        newCase.Service_Request_Type__c == 'PIF Returned Mail' || newCase.Service_Request_Type__c == 'Retrieve Title' ||
                        newCase.Service_Request_Type__c == 'Repo/R&R' || newCase.Service_Request_Type__c == 'TOE/TOL'){
                newCase.Service_Type__c='Customer Correspondence';               
            }
        }    
        System.debug('*** current value of showSendToAddress:' +showSendToAddress);
        try {
                fields = fieldSetMap.get(serviceRequestType);
        }
        catch(exception e) { fields = new List<Schema.FieldSetMember> (); }
        
        
        // Adding unbound fields allows the user to prefill text into the description
        unboundF = new LIST<UnboundField>();
        for(UC_Unbound_Field_List__c thisUnbound: [select Display_Label__c 
                        FROM UC_Unbound_Field_List__c 
                        WHERE action__c =: newCase.action__c AND category__c =: newCase.Category__c AND topic__c =: newCase.Service_Request_Type__c
                        ORDER BY SortOrder__c]){
            System.debug('**** attempting to add: '+thisUnbound.Display_Label__c);
            unboundF.add(new UnboundField(thisUnbound));
        }
        
 
 
        // For FA, sometimes we need to know if a Lease or Retail account.  So query first.

        system.debug('++++ field set: ' + serviceRequestType );
 
        
        try {
            // Correct topics which need to be split between Lease and Retail
            if (newCase.action__c == 'Start Process' && newCase.Service_Request_Type__c == 'Early Termination/Voluntary Surrender' && FA.recordType.Name == 'Lease') 
                serviceRequestType =  'Early Termination';          
            else if (newCase.action__c == 'Start Process' && newCase.Service_Request_Type__c == 'Early Termination/Voluntary Surrender' && FA.recordType.Name == 'Retail') 
                serviceRequestType =  'Voluntary Surrender';
            
            faFields = faFieldSetMap.get(serviceRequestType);
        }
        catch(exception e) {
            faFields = new List<Schema.FieldSetMember> (); 
        }
        
        if (faFields == null)
            faFields = new List<Schema.FieldSetMember> (); 
        
        // the FA needs to be queried.  Fieldset may have different fields. 
        string query = 'SELECT ';
        for(Schema.FieldSetMember f : faFields) {
            query += f.getFieldPath() + ', ';
        }
        string faId = fa.Id;
        if (newCase.Service_Request_Type__c == 'Payoff Quote')
            query += 'Id , recordTypeId, recordType.name, code_edit_message__c, type_code_description__c  from Financial_Account__c where Id = :faId';
        else
            query += 'Id, recordTypeId, recordType.name  from Financial_Account__c where Id = :faId';
            
        system.debug('++++++ FA Query: ' +query); 
                

        FA = database.query(query);
        system.debug('++++++ FA : ' +fa);
        // Need to eliminate Fees field if FA Type Code Description != Actuarial
        if (newCase.Service_Request_Type__c == 'Due Date Change')
            if (fa.type_code_description__c != 'Actuarial' && fields != null) {
                for (integer i = 0; i < fields.size(); i++) {
                    if (fields[i].getFieldPath() == 'Fees__c') {
                        fields.remove(i);
                        break;
                    }
                }
            }
        /* End FA Fields */
        system.debug('+++ FA Fields: ' + faFields);
 
 
 
        /*  FAC Fields - if any */
        // If Contact is not the primary or coborrower, no FAC fields will be shown
        system.debug('++++++ value of newCase.Service_Request_Type__c: ' +newCase.Service_Request_Type__c);
        system.debug('++++++ value of showContactName: ' +showContactName);
        if (showContactName == true || (newCase.Service_Request_Type__c !='Return Mail' && newCase.Service_Request_Type__c !='Direct Sales'))  // not the primary or co
            facFields = new List<Schema.FieldSetMember> (); 
        else {  
            // set readonly or not
            if(newCase.Service_Request_Type__c == 'Direct Sales'){
                facReadOnly = true;
            }else if(newCase.Service_Request_Type__c == 'Return Mail'){
                facReadOnly = false;
            }else{
                facReadOnly = false;
            }
            // Contact is primary or co
            try {
                facFields = facFieldSetMap.get(serviceRequestType).clone();     
            }
            catch(exception e) {
                facFields = new List<Schema.FieldSetMember> (); 
            }
            
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
                    }else if(facFields[i].getFieldPath() == 'Servicing_Email__c'){
                        // for Direct Sales we need to be able to set the value of Alternate email and make it edible to the user.
                        System.debug('*** assigning the Service Email: ');
                        try{            
                            if(newCase.Alternate_Email__c == null){
                                newCase.Alternate_Email__c = FAC.Servicing_Email__c;    
                            }       
                        }
                        catch (System.Exception ex){
                            // ignore errors for this feature as it can be managed by the user if field is not populated
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
          
        }
        /* End FAC Fields */
       
         if (newCase.Category__c == 'Communications' && newCase.Service_Request_Type__c == 'Return Mail')
             newCase.Service_Type__c = 'Customer Correspondence';
         if (newCase.Category__c == 'Lease End' && newCase.Service_Request_Type__c == 'Left Message')
             newCase.Service_Type__c = 'Outbound Call';
              
    }   

       
    // after case is saved & console is refreshed, reset this to false for next case
    public void resetSaveSuccessful() {
        saveSuccessful = false;
    }
        
  
    
    // 3/17/2016
    private string setRecordType() {
         string recordType;
        if (this.action == 'Request Information')
            recordType = 'UC - Request Information';
        else if (this.action == 'Request Documentation')
            recordType = 'UC - Request Documentation';
        else if (this.action == 'Start Process')
            recordType = 'UC - Start Process';
        else if (this.action == 'Log Complaint')
            recordType = 'UC - Log Complaint';
        else 
            recordType = 'UC - Edit Profile';
        
        return recordType;
    }
          
        
    private void newCase() {
        
        string recordType = setRecordType();
        
        Schema.DescribeSObjectResult obj = Schema.SObjectType.Case;   
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        newCase = new Case(Financial_Account__c = FA.Id, recordTypeId= caseRecordTypeMap.get(recordType).getRecordTypeId(), status='New', action__c = this.action,
             Number_of_LME_s__c = '1', ParentId = parentCase.Id, financial_account_customer__c = ParentCase.financial_account_customer__c,
            
            //        Service_Type__c='Inbound Call', Number_of_LME_s__c = '1', ParentId = parentCase.Id, financial_account_customer__c = ParentCase.financial_account_customer__c,
                    Requesting_location__c='CSC');
   
        // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
  
        try {
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             newCase.ani__c = ti.ani__c;
             newCase.connId__c = ti.conn_id__c;
             if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             newCase.Service_Type__c= ti.Interaction_Type__c;
        }
        catch(exception e){
            if(ServiceChannel==null)
            {
                //ServiceChannel = 'Action Request';
            }

        }
                    
        originalRecordType = recordType;
        showContactName = false;
        populateContacts();  
        populateEscalationOptions();
        getFields();
         
    }
    
    public void populateEscalationOptions() {
        escalationOptions = new List<selectOption>();
        escalationOptions.add(new selectOption('', '--None--'));
        escalationOptions.add(new selectOption('Escalate To', 'Escalate To'));
        escalationOptions.add(new selectOption('Transfer To', 'Transfer To'));
        selectedEscalation = '';
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
            
           // system.debug('++++ contact select options: ' + contacts);
            
            selectedContact = 'Primary Borrower';
            setShowContact();
 
    }
 
    public void checkRecordType() {
        
        // reset to default recordType
        newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(setRecordType()).getRecordTypeId();
        
        if (newCase.Category__c == 'Title')
            if(newCase.Action__c == 'Start Process' && newCase.Service_Request_Type__c == 'PIF Release'){
                newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Title Release').getRecordTypeId();
            }else{
                newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Title Process').getRecordTypeId();              
            }
        else if (newCase.Category__c == 'Contract Modifications')
            newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Contract Modifications').getRecordTypeId();
        else if (newCase.Category__c == 'Payments' && newCase.Action__c == 'Start Process')
            newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Payment Process').getRecordTypeId();
         //else
         // newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(originalRecordType).getRecordTypeId();
         system.debug('++++ record type changed to: ' + newCase.recordTypeId);
         
    }
    
    public void cancelCase() {
        fields = new List<Schema.FieldSetMember> (); 
        newCase();
    }    
    
   public void setObjectType() {}
   
   public void setEscalationType() {
    system.debug('+++ selectedEscalation: ' + selectedEscalation);
        if (selectedEscalation == 'Escalated To')
            newCase.Transfer_To__c = null;
        else if (selectedEscalation == 'Transfer To')
                newCase.Escalated_To__c = null;
        else {
            newCase.Transfer_To__c = null;
            newCase.Escalated_To__c = null;
        }
   }
   
    public void clearMessage() {}
    
   public void setShowContact() {
            
      if(selectedContact == 'Primary Borrower') {
         newCase.Financial_Account_Customer__c = primaryBorrower.Id;
         newCase.contact_name__c = primaryBorrower.Customer_Full_Name__c;
         showContactName = false;
         relationshipName = '';
      }
      
      else if (selectedContact == 'Co-Borrower') {
         newCase.Financial_Account_Customer__c = coBorrower.Id;
         newCase.contact_name__c = coBorrower.Customer_Full_Name__c;
         showContactName = false;
         relationshipName = '';
        
      }
      else {
         newCase.Financial_Account_Customer__c = primaryBorrower.Id;
         newCase.contact_name__c = null;
         showContactName = true;   
         relationshipName = '';
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
      
      // Changing the Contact on an FAC update, requires that the FAC be requeried
      if (newCase.Service_Request_Type__c == 'Return Mail') {
        getFields();
      }
   }
   
   private void setDefaults() {
           
    
        //ServiceChannel=parentCase.service_type__c;
        if (newCase.action__c == 'Request Information' || newCase.action__c == 'Request Documentation'    ||
            (newCase.action__c == 'Start Process' && newCase.Service_Request_Type__c == 'Make a Payment'))
            {
                newCase.status = 'Resolved';
            }
        
        // For certain Topics, copy FA Fields to Case
        try {
            string faTopicsForCopy = 'Late Charge Waiver|Due Date Change|AutoCheque Cancellation';
            if ( faTopicsForCopy.containsIgnoreCase(newCase.Service_Request_Type__c)) {
                for(Schema.FieldSetMember f : faFields) {
                    newCase.put(f.getFieldPath(), FA.get(f.getFieldPath()));
                }   
            }
        }
        catch(exception e) {}
        
        // For Payoff Quote and Early Termination/Voluntary Surrender, copy FA Fields to case, unfortunately the field names don't match
        // so we have to hard code the field names
        if ((newCase.Service_Request_Type__c == 'Payoff Quote' || newCase.Service_Request_Type__c == 'Early Termination/Voluntary Surrender') && fa.recordType.name == 'Lease') {
            newCase.good_thru_date__c = fa.payoff_good_thru_date__c;
            newCase.Gross_Payoff__c   = fa.Payoff_Amount_Gross__c;
            newCase.Purchase_Opt__c   = fa.Purchase_Option_Amount__c;
            newCase.Residual_Value__c = fa.Lease_Residual_End_of_Term_Amount__c;
            newCase.Account_Status__c = accountStatus;
            newCase.Process_Date__c = fa.effective_date__c;
        }
    
        if ((newCase.Service_Request_Type__c == 'Payoff Quote' || newCase.Service_Request_Type__c == 'Early Termination/Voluntary Surrender') && fa.recordType.name == 'Retail') {
            newCase.good_thru_date__c = fa.payoff_good_thru_date__c;
            newCase.Per_Diem__c       = fa.Charge_PerDiem_Total__c;
            newCase.Net_Payoff__c     = fa.Payoff_Amount_net__c;
            newCase.Account_Status__c = accountStatus;
            newCase.Process_Date__c = fa.effective_date__c;
        }
 
        // repeating this process in case the interaction record was not available at the opening of the page
        // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
  
        try {
            system.debug('****Start TempInteraction 2nd time');
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             newCase.ani__c = ti.ani__c;
             newCase.connId__c = ti.conn_id__c;
             if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             //858if (newCase.Service_Type__c != 'Customer Correspondence') // skip for certain case types
             newCase.Service_Type__c= ti.Interaction_Type__c;
             system.debug('****End TempInteraction 2nd time '+Ti);
        }
        catch(exception e)
        {
            newCase.Service_Type__c = ServiceChannel;
        }
      
   } 
   
   public void ServiceChannel() {
   
   system.debug('*************  ServiceChannel Val **************'+ServiceChannel);
      system.debug('********* tempServiceChannel **************'+tempServiceChannel);
      system.debug('************* Newcase Value ************'+newCase.Service_Type__c);
      
      if(ServiceChannel!=tempServiceChannel){
      if(ServiceChannel=='Customer Correspondence'){
            newCase.Service_Type__c='Customer Correspondence';
        }else if(ServiceChannel=='Action Request'){
            newCase.Service_Type__c='Action Request';
        }
     
        
       //W-858
       }else{
            ServiceChannel=null;
            newCase.Service_Type__c=null;
       }
        tempServiceChannel=newCase.Service_Type__c;
    }
    
    public void SendToUpdate(){
        AddUpdate = new UC_NewCase_SendTo(newCase, primaryBorrower, coBorrower, FA);
        AddUpdate.FillAddress();
    }
   
   public PageReference createCase() {
    
    system.debug('*************  ServiceChannel Val Before **************'+ServiceChannel);
      system.debug('********* tempServiceChannel Before **************'+tempServiceChannel);
      system.debug('************* Newcase Value Before ************'+newCase.Service_Type__c);
      
        setDefaults();
        
        system.debug('*************  ServiceChannel Val AFTER **************'+ServiceChannel);
      system.debug('********* tempServiceChannel AFTER **************'+tempServiceChannel);
      system.debug('************* Newcase Value AFTER ************'+newCase.Service_Type__c);
        // check for unbound fields and update discription
        if(unboundF !=null){
            String sUnboundFields = '';
            for(UnboundField uf:unboundF){
                if(uf.UserInputValue != '') sUnboundFields = sUnboundFields + '\n' + uf.thisUF.Display_Label__c + ': ' + uf.UserInputValue;
            }
            newCase.Description = newCase.Description + sUnboundFields;
        }
        
        // for titles set the record type
        if (newCase.Category__c == 'Title'){
            if(newCase.Action__c == 'Start Process' && newCase.Service_Request_Type__c == 'PIF Release'){
                newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Title Release').getRecordTypeId();
            }else{
                newCase.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('UC - Title Process').getRecordTypeId();              
            }
        }
   
        // get interaction info
        string faId = FA.Id;
        faId = faId.substring(0,15);
        //W-000215 Added Interaction Type
        try {
             tempinteraction__c ti = [select Interaction_Type__c, ani__c, conn_id__c from tempinteraction__c 
                                        where name = :faId and createdById = :userInfo.getUserId() limit 1];
             newCase.ani__c = ti.ani__c;
             newCase.connId__c = ti.conn_id__c;
             if(ti.Interaction_Type__c=='undefined' && ti.ani__c==null)
             {
             ti.interaction_Type__c = 'Outbound Call';
             }
             //if(newCase.Service_Type__c !='Customer Correspondence' && ti.Interaction_Type__C!=null)
             if(ti.Interaction_Type__C!=null)
             {
             newCase.Service_Type__c= ti.Interaction_Type__c;
             }
        }
        catch(exception e)
        {
            newCase.Service_Type__c = ServiceChannel;
        }
     
        // insert the case
         
        savePoint sp = Database.setSavepoint();
         InitialServiceChannel=ServiceChannel;
         if(newcase.service_type__c==null)
        {
            newcase.service_type__c='Action Request';
        }
        //tempServiceChannel=null;
        Case caseBeforeInsert = newCase.clone(false, true);   // in case there is an error in FAC update. this is deep clone.
        system.debug('+++ caseBeforeInsert1: ' + caseBeforeInsert);

            
        if ( insertCase()) {
             savedCase = newCase;
             newCase();
             if(parentcase.service_type__c =='Customer Correspondence' || parentcase.service_type__c =='Action Request')
        {
             ServiceChannel=parentCase.service_type__c;
        }     
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
           if (newCase.contact_name__c == null && selectedContact != 'TFS Team Member')
                throw new DMLException('Please enter a value for Contact Name.');
            
            
            System.debug('**** the inserted Case: '+newCase);
            insert newCase; 
           
           
           System.debug('++++ newCase after save: ' + newCase);  
           system.debug('++++ Saved Case: ' + savedCase);
           system.debug('+++ Topic / showContactName: ' + newCase.Service_Request_Type__c + ' / ' + showContactName);
            
            // update FAC if necessary
            if (newCase.Service_Request_Type__c == 'Return Mail' && showContactName == false) {
                // need to update the Case # here
           // Get Case Id and place in Custom Setting to be used in Customer Profile Edit process
               General_Settings__c gs = General_Settings__c.getInstance(userInfo.getUserId());
               gs.TempCaseId__c = newCase.Id + ';' + newCase.service_type__c;
               upsert gs;
                system.debug('+++ Custom Setting before FAC Update: ' + gs);
                system.debug('+++ updating fac ' + fac);
                update FAC;
                system.debug('+++ updated fac: ' + fac);
                gs.TempCaseId__c = null;
                upsert gs;
                system.debug('+++ Custom Setting after FAC Update: ' + gs);
            }  
              
           SaveSuccessful = true; 
           return true;  

        } catch(System.Exception ex){
           string message = ex.getMessage().replace('First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
           message = message.replace(': []','');
  
            system.debug('exception: ' + ex);
            system.debug('message: ' + message);          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
            system.debug('apexPages.message: ' +new ApexPages.Message(ApexPages.Severity.ERROR, message) );

             SaveSuccessful = false;
            
            system.debug('+++ Save Successful: ' + SaveSuccessful);
            return false;
        }
    } 
    
    public class UnboundField{
        public UC_Unbound_Field_List__c thisUF {get; set;}
        public String UserInputValue {get; Set;}
        
        public UnboundField(UC_Unbound_Field_List__c uf){
            thisUF = uf;
            UserInputValue = '';
        }
    }
}