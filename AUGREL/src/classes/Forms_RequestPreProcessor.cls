public class Forms_RequestPreProcessor{


	/*  ALFA passes account number, reschedule sequence number, quotation number as part of entity key. This method manages it and assigns to relevant fields
	 **/

	public List<Form_Request_Line_Item__c> manageFormRequest(Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes){
 		String thirdPartyNumber ='';
        String billingAddressNumber='';

		List<Form_Request_Line_Item__c> formAttributesTemp = new List<Form_Request_Line_Item__c>();
		if(formRequest==null || formRequest.Form_Number__c==null || formRequest.Form_Number__c.trim().length()==0){
			String errorMessage = Forms_Fetch_CustomSetting.fetchErrorMessage('Invalid Input')+'\r\n'+Forms_Fetch_CustomSetting.fetchErrorMessage('Missing Fields')+' Form Number';
			throw new Forms_ValidationException(errorMessage);
		}
		if(formAttributes==null || formAttributes.size()==0){
			throw new Forms_ValidationException(Forms_Fetch_CustomSetting.fetchErrorMessage('Invalid Input'));
		}
		formAttributesTemp = formAttributes.clone();
		Form__c formInfo =  Forms_DataSelector.getFormInformation(formRequest.form_number__c.trim());  
		String entityKey = ''; 
		for(Form_Request_Line_Item__c formAttribute: formAttributes){
			if(formAttribute.FormAttributeKey__c.equalsIgnoreCase(Forms_Constant.ENTITYKEY)){
				entityKey = formAttribute.FormAttributeValue__c;
				
			}
			 if(formAttribute.FormAttributeKey__c.equalsIgnoreCase('thirdpartynumber')){
        thirdPartyNumber = formAttribute.FormAttributeValue__c;
      }
            if(formAttribute.FormAttributeKey__c.equalsIgnoreCase('billingaddressnumber')){
        billingaddressnumber = formAttribute.FormAttributeValue__c;
      }
          
		}
		if(entityKey==null || entityKey.trim().length()==0){
			return formAttributesTemp;
		}
		if(formInfo.Entity_Key__c.equalsIgnoreCase(Forms_Constant.SCHEDULEIDENTIFIER)){
			String[] keys = entityKey.split('/');
			if(keys.size()==0){
				return formAttributesTemp;
			}
			if(formRequest.Account_Number__c==null || formRequest.Account_Number__c.trim().length()==0) {
				formRequest.Account_Number__c = keys[0];
			}
		}else if(formInfo.Entity_Key__c.equalsIgnoreCase(Forms_Constant.QUOTATIONIDENTIFIER)){
			String[] keys = entityKey.split('/');
			if(keys.size()==0){
				return formAttributesTemp;
			}
			if(formRequest.Account_Number__c==null || formRequest.Account_Number__c.trim().length()==0) {
				formRequest.Account_Number__c = keys[0];
			}    
			if(keys.size()>2){
				Form_Request_Line_Item__c quotationNumber = new Form_Request_Line_Item__c();
				quotationNumber.FormAttributeKey__c=Forms_Constant.QUOTATIONNUMBER;
				quotationNumber.FormAttributeValue__c=keys[2];
				formAttributesTemp.add(quotationNumber);
			}
		}
		boolean agreementNumberExists = false;
		if(formAttributes!=null && formAttributes.size()>0){
			for(Form_Request_Line_Item__c formAttribute: formAttributes){
				if(formAttribute.FormAttributeKey__c.equalsIgnoreCase(Forms_Constant.AGREEMENTNUMBER)){
					agreementNumberExists = true;
					break;
				}
			}
		}

		if(!agreementNumberExists && (formRequest.Account_Number__c!=null && formRequest.Account_Number__c.trim().length()>0)){
			System.debug('Forms_RequestPreProcessor:: manageFormRequest:: agreement not exists');
			Form_Request_Line_Item__c agreementNumber = new Form_Request_Line_Item__c();
			agreementNumber.FormAttributeKey__c = Forms_Constant.AGREEMENTNUMBER;
			agreementNumber.FormAttributeValue__c = formRequest.Account_Number__c;

			Form_Request_Line_Item__c scheduleNumber = new Form_Request_Line_Item__c();
			scheduleNumber.FormAttributeKey__c = Forms_Constant.SCHEDULENUMBER;
			scheduleNumber.FormAttributeValue__c = Forms_Constant.SCHEDULENUMBER_VALUE;

			formAttributesTemp.add(agreementNumber);
			formAttributesTemp.add(scheduleNumber);

		}
		
		 if(thirdPartyNumber!=null && thirdPartyNumber.trim().length()>0){
            
            Form_Request_Line_Item__c thirdParty = new Form_Request_Line_Item__c();
      thirdParty.FormAttributeKey__c = Forms_Constant.THIRDPARTYNUMBER;
      thirdParty.FormAttributeValue__c = thirdPartyNumber;

      Form_Request_Line_Item__c billingAddress = new Form_Request_Line_Item__c();
      billingAddress.FormAttributeKey__c = Forms_Constant.BILLINGADDRESSNUMBER;
      billingAddress.FormAttributeValue__c = billingAddressNumber;

      formAttributesTemp.add(thirdParty);
      formAttributesTemp.add(billingAddress);
        }
		System.debug('Forms_RequestPreProcessor:: manageFormRequest:: AccountNumber'+formRequest.Account_Number__c);
		System.debug('Forms_RequestPreProcessor:: manageFormRequest:: entitykey'+formInfo.Entity_Key__c);
		return formAttributesTemp; 
	}
	
	public static String buildingQuery(String ObjectName,String filterId,String filterField,Map<String, Schema.SObjectField> fieldMap){
		String query;
		String commaSepratedFields = '';

		for(String fieldName : fieldMap.keyset()){
			if(commaSepratedFields == null || commaSepratedFields == ''){
				commaSepratedFields = fieldName;
			}else{
				commaSepratedFields = commaSepratedFields + ', ' + fieldName;
			}
		}
		query = 'select ' + commaSepratedFields + ' from '+ ObjectName +' Where '+filterId+'='+'\''+filterField+'\'' ;	


		return query;	
	}



}