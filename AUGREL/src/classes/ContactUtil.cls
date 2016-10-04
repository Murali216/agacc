public class ContactUtil {
	
	private static Map<String,Service_Request_Field_Map__c> srCustomSettingMapForContact;
	//private static User currentUserCache;
	
	public static void createContactRelatedUCActivity(Contact oldContact, Contact newContact, 
								Case parentCase, Financial_Account__c fa, 
								Financial_Account_Customer__c fac){
		if(oldContact == null || newContact == null || parentCase == null || fa == null || fac == null){
			System.debug('There was a problem with input on the Activity');
			return;
		}
		
		//Check if the any of the contact related fields have changed
		// get UC Contact fieldsets
        Map<String, List<Schema.FieldSetMember>>contactfieldSetMap = new Map<String, List<Schema.FieldSetMember>>();
        for(Schema.FieldSet fs : Schema.SObjectType.Contact.fieldSets.getMap().values()){
            if (fs.getName().startsWith('UC_')) {
                 contactfieldSetMap.put(fs.getLabel(),fs.getFields());
            } 
        }
        List<Schema.FieldSetMember> contactfields = new List<Schema.FieldSetMember> ();
		
		try{		
    		contactFields = contactFieldSetMap.get(parentCase.Service_Request_Type__c);
    	}catch(exception e) {
    		System.debug('Error when getting UC service request type field set, createContactRelatedUCActivity()');
        }	        
        if (contactFields == null){
            contactFields = new List<Schema.FieldSetMember> ();
        }
        
        System.debug('>>> createContactRelatedUCActivity - contactFields : ' + contactFields);
        
        boolean hasContactFieldChanged = false;
        Set<String> fieldPathForFieldsThatChanged = new Set<String>();
        for(Schema.FieldSetMember f : contactFields) {
            if(contactFieldHasChanged(oldContact, newContact, f.getFieldPath())){
            	hasContactFieldChanged = true;
            	fieldPathForFieldsThatChanged.add(f.getFieldPath());
            	System.debug('>>> createContactRelatedUCActivity ' + f.getFieldPath() + ' field on Contact has changed');
            }
        }
        
        System.debug('hasContactFieldChanged : ' + hasContactFieldChanged);       
		if(hasContactFieldChanged){
			// We are creating specifically Activity related to Parent Case, so inheriting attributes from parent Case.
			// When designing generic solution, would need to refactor to include the generic object creation from 
			// Custom setting (similar to TFSC_FinancialActEditCaseCreateHandler)						
	        
	        TFS_Activity__c newActivity = new TFS_Activity__c(
	        	AccountId__c = fac.Account__c,
	        	Financial_Account__c = fa.Id, 
	        	Financial_Account_Customer__c = fac.Id,
	            action__c = parentCase.action__c, 
	            category__c = parentCase.category__c, 
	            topic__c = parentCase.service_request_type__c,
	            Service_type__c= parentCase.service_Type__c ,
	            Service_Request_User_Group__c = parentCase.Service_Request_User_Group__c,
	            case__c = parentCase.Id, 
	            status__c = 'Closed', 
	            ani__c = ParentCase.ani__c, 
	            conn_Id__c = ParentCase.connId__c
	            );
	        
	        /*
	        *********** Getting it from parent case for now until it is needed to be generic
	        
	        User currentUser = getCurrentUserCache();
		    if( !TFSC_Utils.isNullOrEmpty(currentUser.Service_Request_User_Group__c) ) {
		        newActivity.put('Service_Request_User_Group__c', currentUser.Service_Request_User_Group__c);
		    }
		    if( !TFSC_Utils.isNullOrEmpty(currentUser.Service_Request_Service_Type__c) ) {
		        newActivity.put('Service_Type__c', currentUser.Service_Request_Service_Type__c);
		    }
		    */
		    
		    Account acct = [select id, IsPersonAccount, PersonContactId from Account where id =:fac.Account__c];
		    if(acct != null && acct.IsPersonAccount && acct.PersonContactId != null) {
		        newActivity.put('ContactId__c', acct.PersonContactId);
		    }    
	       
			if(fac.Account__r.isPersonAccount) {
            	newActivity.put('SR_Last_Name_Business_Name__c', fac.Account__r.LastName);
            	newActivity.put('SR_First_Name__c',  fac.Account__r.FirstName);
	        }else{
	            newActivity.put('SR_Last_Name_Business_Name__c', fac.Account__r.Name);
	        }
	        if(fac.Borrower_Position__c == 'Primary') {
           		newActivity.put('Service_Recipient__c', 'Primary Borrower');
        	}else{
            	newActivity.put('Service_Recipient__c', 'Co-Borrower');
        	}        
        	if(fac.Financial_Account_Customer__c != null) {
            	newActivity.put('Financial_Account_Customer_ID__c', fac.Financial_Account_Customer__c);
        	}
            
	       	System.debug('>>> createContactRelatedUCActivity newActivity on initial setup' + newActivity);
	                 
	        Map<String, Service_Request_Field_Map__c> contactSRCS = getSRCustomSettingsForContact();
	        Service_Request_Field_Map__c aContactSRCustomSetting = null;
	        String contactSourceField = null;
	        String activityDesc = null;
	        
	        System.debug('>>> createContactRelatedUCActivity contactSRCS' + contactSRCS);
	        
	        //Loop through field that have changed, to set the updated value on Activity from Contact
	        for(Schema.FieldSetMember f : contactfields) {
	        	contactSourceField = f.getFieldPath();
	        	aContactSRCustomSetting = contactSRCS.get(contactSourceField);
	        	
	        	System.debug('>>> createContactRelatedUCActivity contactSourceField : ' + contactSourceField + '   aContactSRCustomSetting' + aContactSRCustomSetting);
	        	
	        	if(aContactSRCustomSetting != null){
	        		newActivity.put(aContactSRCustomSetting.Target_Field_Old__c, oldContact.get(contactSourceField));
	        		newActivity.put(aContactSRCustomSetting.Target_Field__c, newContact.get(contactSourceField));
	        		
	        		//Set recordTypeId if not already set
	        		if(newActivity.recordTypeId == null){//Should be only once
	        			Id rtId = TFSC_Utils.getRecordTypeIdFromDeveloperNameAndsObjectName(aContactSRCustomSetting.Record_Type__c, aContactSRCustomSetting.Target_Object__c );
	        			System.debug('>>> createContactRelatedUCActivity - newActivity.recordTypeId : ' + rtId);
		        		newActivity.recordTypeId = rtId;
		        		
		        		if( !TFSC_Utils.isNullOrEmpty(aContactSRCustomSetting.Address_Type__c) ) {
                            newActivity.put('Address_Type__c', aContactSRCustomSetting.Address_Type__c);
                        }                        
		        		if(!TFSC_Utils.isNullOrEmpty(aContactSRCustomSetting.Type__c)){
			        		newActivity.put('Service_Request_Type__c', aContactSRCustomSetting.Type__c);
			        		newActivity.put('Type__c', aContactSRCustomSetting.Type__c);
		        		}		        		
		        		if( !TFSC_Utils.isNullOrEmpty(aContactSRCustomSetting.Service_Request_Category__c) ) {
			                newActivity.put('Service_Request_Category__c', aContactSRCustomSetting.Service_Request_Category__c);
			            }			            
			            if( !TFSC_Utils.isNullOrEmpty(aContactSRCustomSetting.Service_Result__c) ) {
			                newActivity.put('Service_Result__c', aContactSRCustomSetting.Service_Result__c);
			            }
	        		}
	        		
	        		//Include description additions only for fields that changed
	        		if(fieldPathForFieldsThatChanged.contains(f.getFieldPath())){
		        		activityDesc = String.valueOf(newActivity.get('Description__c'));
				        if( TFSC_Utils.isNullOrEmpty(activityDesc) || activityDesc == 'null' ) {
				            activityDesc = 'Information updated for:';
				        }
				        
				        activityDesc += ' "' + f.getLabel() + '" - Former: ';
				        activityDesc += String.valueOf( oldContact.get(contactSourceField) );
				        activityDesc += ', New: ';
				        activityDesc += String.valueOf( newContact.get(contactSourceField) );
				        activityDesc += ';';
				        
				        newActivity.put('Description__c', activityDesc);
	        		}
			        
			        System.debug('>>> createContactRelatedUCActivity activityDesc : ' + activityDesc);
	        	}else{
	        		System.debug('>>> createContactRelatedUCActivity There is a problem building Map for CS for Contact : ' + contactSourceField);
	        	}	           
	        }
	        
	        System.debug('>>> createContactRelatedUCActivity - newActivity : ' + newActivity);
	        //Insert that activity
	        try{
		        insert newActivity;
	        }catch (Exception e){
	        	System.debug('>>> createContactRelatedUCActivity - DML Exception happened when inserting activity : ' + newActivity + ' >>> This is the exception ' + e);
	        }
	        System.debug('>>> createContactRelatedUCActivity - newActivity is created');
		}		
	}
	
	/*
		Compare if the specified field value has changed between old and new Contact object
	 */
    private static Boolean contactFieldHasChanged(Contact oldContact, Contact newContact, String fieldName) {        
        try {
            if( oldContact.get(fieldName) == null){
            	if(newContact.get(fieldName) == null){
            		return false;
            	}else{
            		return true;
            	}
            }else if(newContact.get(fieldName) == null){
            	return true;
            }else{
            	if(oldContact.get(fieldName) == newContact.get(fieldName)) {
         		   return false;
        		}else{
        			return true;
        		}
            }
            
            return false;            
        }catch (Exception e) {
            return false;
        }
    }
    
    /*
    	Method to get Service Request Custom Settings for Contact
    */
    private static Map<String, Service_Request_Field_Map__c> getSRCustomSettingsForContact(){
    	if(srCustomSettingMapForContact == null) {                
            List<Service_Request_Field_Map__c> srCustomSettingsForContact = [select Name, Source_Field__c, Source_Object__c, 
                                               Target_Field__c, Target_Object__c, Target_Field_Old__c,
                                               Record_Type__c, Type__c, Group__c, Conversion_Type__c,
                                               Address_Type__c, Service_Request_Category__c, Service_Result__c,
                                               Consent_Validation__c
                                              from Service_Request_Field_Map__c
                                              where Source_Object__c = 'Contact'
                                              and Target_Object__c <> null];
                                              
            System.debug('>>> createContactRelatedUCActivity - srCustomSettingsForContact - ' + srCustomSettingsForContact);
              
            srCustomSettingMapForContact =   new Map<String, Service_Request_Field_Map__c>();                             
			for(Service_Request_Field_Map__c aCustomSetting : srCustomSettingsForContact){
				if(aCustomSetting.Source_Field__c != null){
					srCustomSettingMapForContact.put(aCustomSetting.Source_Field__c, aCustomSetting);
				}
			} 
			System.debug('>>> createContactRelatedUCActivity - srCustomSettingMapForContact - ' + srCustomSettingMapForContact);                                    
        }
       
        return srCustomSettingMapForContact;
    }
    
    /*
    private static getCurrentUserCache(){
    	if(this.currentUserCache == null) {
                this.currentUserCache = [select id, Service_Request_User_Group__c, Service_Request_Service_Type__c 
                                         from user where id = :UserInfo.getUserId()];
        }
        return this.currentUserCache;
    }
    */
}