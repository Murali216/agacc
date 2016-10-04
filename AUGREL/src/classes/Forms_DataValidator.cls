/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DataValidator
Version...............: 1.0
Created by............: Charitha_Seelam,Kaavya_Kanna,Pranav_Prasun,Geetha_muthukuru
Created Date..........: 10/02/2015 
Last Modified by......: Charitha_Seelam
Last Modified Date....: 10/26/2015 
Description...........: This Class is a Data Validator class which validate the request(FormRequest,FormRequestLineItem) and response(DocumentRequest and DocumentReqLineItem) Obj field values.


Change Request History:

Modified By      Date          Comments

Charitha S      29/10/2015      Added argument 'Type' to generateValResult() method to differentiate
                                whether validationResult has to be generated for Request or Response.
                                
Charitha S      09/11/2015      Changed ValidateDocumentData method Logic. Instead of comparing Name of FormField
                                 & DocREq Object, comparing with Target_field__c & Document_Request__C field API Names.
                                 
Charitha S      10/11/2015      Changed ValidateDocumentData method signature and logic.Expecting List Of
                                documentRequestLineItems as an argument & validating accordingly.
                                
Charitha S      11/11/2015      Added constructor which has formNumber as parameter & which will execute a
                                a query to retrieve all the configured fields for the sent form.
                                
Charitha S      12/03/2015      Added code to check if any input attributes for services are missing from   the request in ValidateData method.
##########################################################################################
 */

public class Forms_DataValidator{

    public static Map<String, Schema.SObjectType> schemaMap;
    public Forms_Validation_Result__c validationResult{get;set;}
    public List<Form_Field_Junction__c> configuredFieldsList{get;set;}
    public String strErrorMessage{get;set;}
    public String strMissingFields{get;set;}
    public String strInvalidFields{get;set;}
    Public Boolean isMissing=false;
    public Boolean isInvalid=false;
    
    public Forms_DataValidator(String formNumber)
    {
        getconfiguredFieldsList(formNumber);   
    }
    static
    {
        schemaMap = Schema.getGlobalDescribe();     
    }

    /* Method Name: validateData
    Method Signature/Inputs: instance of FormRequest object, List of Form Request Line items.
    Method Return Type/outputs: instance of Form Validation Result object. 
    Method Description: This method is to validate FormRequest Data which is sent by ALFA and invoked by Forms_Requestprocessor service.
    */
    public Forms_Validation_Result__c validateData(Form_Request__c  formRequest, List<Form_Request_Line_Item__c> attributes)
    {
        System.debug('Forms_DataValidator::validateData::Form Requst'+formRequest+'::Form Request Line Item'+attributes);
        DateTime startDate = system.now();   
        Map<String, Schema.SObjectField> formReqMap;               
        validationResult = new Forms_Validation_Result__c();
        validationResult.status__c = Forms_Constant.SUCCESS;
        Boolean isServiceInput;
        strErrorMessage = Forms_Fetch_CustomSetting.fetchErrorMessage('Invalid Input');     
        
        try
        { 
            //If FormRequest is null return validationResult with ErrorMsg.
            if((formRequest == null) || (formRequest.form_Number__c == null)){       
                System.debug('Forms_DataValidator::validateData:: formRequest is null'); 
                generateValResult(Forms_constant.REQUEST);        
                return validationResult;            
            }
            //if FormRequest is not null and Form Related attributes are null return validationResult with errorMsg     
            if(attributes == null) {
                
               attributes = new List<Form_Request_Line_Item__c>(); 
               Form_Request_Line_Item__c liDummy = new Form_Request_Line_Item__c();
               liDummy.FormAttributeKey__c='tmpkey####';
		       liDummy.FormAttributeValue__c = '1111';
		       attributes.add(liDummy);
            }   
            
            System.debug('after attributes'+attributes);
            if(attributes == null || attributes.size() == 0) {
                generateValResult(Forms_constant.REQUEST);
                System.debug('empty attributes');
                return validationResult;            
            }
            
            formReqMap = getFields(Forms_constant.FORMREQUEST);       
            System.debug('Forms_DataValidator::validateData::Configured Fields are'+configuredFieldsList);            
            for(Form_Field_Junction__c junction:configuredFieldsList)
            {
                String fieldName = junction.Form_Field__r.name;
                isServiceInput = false;
                String fieldValue; 
                String sourceSystem = String.valueOf(formRequest.SourceSystem__c);
                if(formReqMap.containsKey(fieldName))
                {                   
                    fieldValue = string.valueof(formRequest.get(fieldName));
                    isAttributeValid(junction,fieldValue);
                    System.debug('Forms_DataValidator::validateData::Configured Field Name-'+fieldName+'and Field value-'+fieldValue+'Details::'+isMissing+isInvalid); 
                } 
                else 
                { 
                    
                    for(Form_Request_Line_Item__c lineitem : attributes)
                    {   
                        if((lineitem.FormAttributeKey__c).equalsIgnoreCase(fieldName))
                        {
                            fieldValue = lineitem.FormAttributeValue__c;
                            if(formRequest.SourceSystem__c.equalsIgnoreCase(Forms_Constant.ALFA) && (fieldName.equalsIgnoreCase(Forms_Constant.BILLINGADDRESSNUMBER) || 
                            fieldName.equalsIgnoreCase(Forms_Constant.THIRDPARTYNUMBER)))
                            junction.Required__c=true;
                            isAttributeValid(junction,fieldValue);
                            System.debug('Forms_DataValidator::validateData::Configured Line Item Field Name-'+fieldName+'and Field value-'+fieldValue+'Details::'+isMissing+isInvalid);
                            isServiceInput = true;
                            break;
                        }
                                                 
                    }
                    //Added the below code to check if any input attributes for services are missing from the request.
                    if(junction.Form_Field__r.Is_Service_Input__c && !isServiceInput)
                    {    if(formRequest.SourceSystem__c.equalsIgnoreCase(Forms_Constant.ALFA) && (fieldName.equalsIgnoreCase(Forms_Constant.BILLINGADDRESSNUMBER) || 
                            fieldName.equalsIgnoreCase(Forms_Constant.THIRDPARTYNUMBER)))
                            junction.Required__c=true;
                            isAttributeValid(junction,null);
                    }
                     
                        
                }

            }
            if(isMissing || isInvalid){
                generateValResult(Forms_constant.REQUEST);               
            }
        }   
        catch(Exception e)
        {
            System.debug('Forms_DataValidator::validateData::Exception strErrorMessage-'+e.getMessage());
            Throw new Forms_InternalException();
        } 
        System.debug('Forms_DataValidator::validateData::validationResult-'+validationResult);
        Forms_Utils.executionTime(startDate,system.now(),'Forms_DataValidator','validateData');
        return validationResult;
    }

    /* Method Name: validateDocumentData
    Method Signature/Inputs: instance of document Request object, List of document Request Line items.
    Method Return Type/outputs: instance of Form Validation Result object. 
    Method Description: This method is to validate documentRequest and documentReqLIneItems Object which is output data for Adobe.
    */
    public Forms_Validation_Result__c validateDocumentData(Document_Request__c documentRequest, List<Document_Request_Line_Item__c> attributes)
    {         
        DateTime startDate = system.now();
        System.debug('Forms_DataValidator::validateDocumentData::start Date Time-'+startDate);      

        Map<String, Schema.SObjectField> docReqMap;
        Map<String, Schema.SObjectField> docReqLineMap;       
        validationResult = new Forms_Validation_Result__c();
        validationResult.status__c = Forms_Constant.SUCCESS;            
        strErrorMessage = Forms_Fetch_CustomSetting.fetchErrorMessage('Insufficient Data'); 
        isMissing = false;            
        isInvalid = false;
        try
        {
            //If sent parameters are null returning validationResult as Failure without any Further processing
            if(documentRequest == null || attributes == null) {  
                System.debug('Forms_DataValidator::validateDocumentData::Document request is null'); 
                generateValResult(Forms_constant.RESPONSE);
                return validationResult;
            }   
            docReqMap = getFields(Forms_constant.DOCUMENTREQUEST);
            docReqLineMap = getFields(Forms_constant.DOCUMENTREQUESTLINEITEM);           
            System.debug('Forms_DataValidator::validateDocumentData::Document Request configuredFieldsList:' +configuredFieldsList); 
            for(Form_Field_Junction__c junction : configuredFieldsList)
            {
                String fieldName = junction.Form_Field__r.Target_Field__c;
                String fieldValue;                
                if(docReqMap.containsKey(fieldName) && !junction.Form_Field__r.Line_Item_Field__c)
                {
                    fieldValue = string.valueof(documentRequest.get(fieldName)); 
                    //Validating For Mandatory Values and Data check as per the dataType.
                    isAttributeValid(junction,fieldValue);
                   System.debug('Forms_DataValidator::validateDocumentData::Document Request field name-'+fieldName+'and Field value-'+fieldValue+'Details::'+isMissing+isInvalid);                                                              
                } 
                else{
                    for(Document_Request_Line_Item__c lineitem: attributes)
                    {   String junctiontype = junction.Form_Field__r.Line_item_type__c;
                        String lineItemtype = String.valueOf(lineitem.type__c);
                        if(docReqLineMap.containsKey(fieldName) && lineItemtype.equalsIgnoreCase(junctiontype))
                        {   System.debug('Forms_DataValidator::validateDocumentData::lineitem'+lineitem);                           
                            fieldValue = string.valueof(lineitem.get(fieldName));
                            isAttributeValid(junction,fieldValue);
                            System.debug('Forms_DataValidator::validateDocumentData::Document Request Line Item field name-'+fieldName+'and Field value-'+fieldValue+'Details::'+isMissing+isInvalid); 
                        }                        
                    }       
                }
                 
            }
            if(isMissing || isInvalid){
                generateValResult(Forms_constant.RESPONSE);
            }
            System.debug('Forms_DataValidator::validateDocumentData::ValidationResult'+validationResult);            
        }
        catch(Exception e)
        {
            System.debug('Forms_DataValidator::validateDocumentData::Exception strErrorMessage-'+e.getMessage());
            Throw new Forms_InternalException();
        } 
        Forms_Utils.executionTime(startDate,system.now(),'Forms_DataValidator','validateDocumentData');
        return validationResult;
    }

    /* Method Name: isAttributeValid
    Method Signature/Inputs: instance of form Field Junction object, fieldValue(String)
    Method Return Type/outputs: NULL
    Method Description: This Method is invoked from both request validation and Response Validation.
                        It will do basic null and Empty Validation for the Mandatory fields skipping Optional.And validates the Data with the configured DataType.
    */
    public void isAttributeValid(Form_Field_Junction__c junction,String fieldValue)
    {   
        String dataType = junction.Form_Field__r.Data_Type__c;
        Boolean required = junction.Required__c; 
        String fieldName = junction.Form_Field__r.Target_Field__c;
        String displayName = junction.Form_Field__r.Display_name__c;
        if(required == true && !isNotNull(fieldValue))
        {            
            System.debug('Forms_DataValidator::isAttributeValid:: Form field Name-'+displayName+' is null');
            if(!isMissing)
            {
                strMissingFields = Forms_Fetch_CustomSetting.fetchErrorMessage('Missing Fields')+displayName;
            }else{
                if(strMissingFields.indexOf(displayName) == -1)
                strMissingFields = strMissingFields+' , '+displayName;
            }
            isMissing = true;                                                  
        }   
        else{
            if(isNotNull(fieldValue) && !validateField(dataType,fieldValue))
            {  
                System.debug('Validate field'+validateField(dataType,fieldValue));
                System.debug('Forms_DataValidator::isAttributeValid:Form field Name:'+fieldName+' is not a valid type'+dataType);
                if(!isInvalid) {
                    strInvalidFields = Forms_Fetch_CustomSetting.fetchErrorMessage('Invalid Datatype')+displayName;
                }else{
                    if(strInvalidFields.indexOf(displayName) == -1)
                    strInvalidFields = strInvalidFields+' , '+displayName;
                }
                isInvalid = true;                                
            }         

        }
    }

  
    /* Method Name: generateValResult
    Method Signature/Inputs: type (String)
    Method Return Type/outputs: NULL
    Method Description: This method will populate validationResult object for Error scenario and returns it. 
    */
    public void generateValResult(String type)
    {
        String errorCode;
        String errorDesc;
        
        if(isMissing){
            strErrorMessage = strErrorMessage+'\r\n'+strMissingFields;
        }
        if(isInvalid){
            strErrorMessage = strErrorMessage+'\r\n'+strInvalidFields;             
        }
        System.debug('Forms_DataValidator::generateValResult::Document Datamessage  '+strErrorMessage );
        
        if(type.equalsIgnoreCase(Forms_constant.REQUEST))
        {
            errorCode = Forms_Fetch_CustomSetting.fetchErrorCode('Invalid Input');
            errorDesc = Forms_Fetch_CustomSetting.fetchErrorDescription('Invalid Input');
        }
        else if(type.equalsIgnoreCase(Forms_constant.RESPONSE))
        {
            errorCode = Forms_Fetch_CustomSetting.fetchErrorCode('Insufficient Data');
            errorDesc = Forms_Fetch_CustomSetting.fetchErrorDescription('Insufficient Data');
        }
        
        validationResult.Status__c = Forms_constant.FAILURE;
        validationResult.ErrorMessage__c = strErrorMessage;            
        validationResult.Error_Code__c = errorCode;  
        validationResult.Error_Description__c = errorDesc;
        validationResult.Url__c = '';     
        
    }

    /* Method Name: validateField
    Method Signature/Inputs: datatype(String), inputField(String)
    Method Return Type/outputs: Boolean
    Method Description: This method validates input field value for the configured data type. 
    */
    public Boolean validateField(String dataType, String inputField){       
        Boolean isValid = true;
        try{
            if(!dataType.equalsIgnoreCase(Forms_Constant.CHECKBOX)){            
            Forms_ValidationHelper.Forms_BaseValidator validator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_'+dataType+'Validator')).newInstance();
            Forms_ValidationHelper vldHelper = new Forms_ValidationHelper(validator);
            isValid = vldHelper.isValid(inputField);
            }
        }catch(Exception e)
        {
            System.debug('Forms_DataValidator::validateDocumentData::Exception strErrorMessage'+e.getMessage());
            Throw new Forms_InternalException();
        } 
        return isvalid;
    }

    /* Method Name: getFields
    Method Signature/Inputs: requestType(String)
    Method Return Type/outputs: Map<String,Schema.SObjectField>
    Method Description: this method is to retrieve all the schema field names and field properties. 
    */
    public Map<String, Schema.SObjectField> getFields(String requestType){   
        return schemaMap.get(requestType).getDescribe().fields.getMap();      
    }

    /* Method Name: isNotNull
    Method Signature/Inputs: attribute (String)
    Method Return Type/outputs: Boolean
    Method Description: This method checks for null for the sent attribute
    */
    public Boolean isNotNull(String attribute){
        return (attribute != null && attribute.trim().length() > 0);   
    }

    /* Method Name: getconfiguredFieldsList
    Method Signature/Inputs: type (String)
    Method Return Type/outputs: NULL
    Method Description: This Method Invoked to retrieve Configured fields in SFDC for a requested Form 
    */
    public void getconfiguredFieldsList(String formNumber) {
        
        configuredFieldsList = Forms_DataSelector.getConfiguredFields(formNumber);
        //configuredFieldsList = [SELECT Form__c,Required__c,Form_Field__c,Form_Field__r.Target_Field__c, Form_Field__r.Data_Type__c, Form_Field__r.name from Form_Field_Junction__c WHERE form__r.form_number__c=:formNumber];       
    }

}