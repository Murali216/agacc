/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_RequestProcesser
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 9/24/2015 
Last Modified by......: Gunjan Singh
Last Modified Date....: 11/17/2015 
Description...........: This Webservice class has been written for taking Inputs for Form Request and Form Request line Item from SOAP UI and calling Data Aggregation Engine.
Last Modified by......: Manga Karumuri
Last Modified Date....: 10/02/2015 
Description...........: Commented the code as it was already handled in Forms_DataValidator Class and added a condition to avoid null exception

Change Request History:
Charitha S      12/11/2015   Added code in processInternalFormRequest method to invoke reponseData validation and if 
                             validation success invoking method for DMS Xml generation.
Manga Karumuri  16/11/2015   Added formRequest.Form_Number__c!=null condition to avoid the null pointer exception.
Thenmozhi       16/11/2015   Added code for querying the lookup data.   
Pranav          16/11/2015   Added code for handling the service and system exceptions.   
Manga Karumuri  16/11/2015   Added code for converting Account Number from 10 digits to 17 digits. 
Manga Karumuri  18/11/2015   Added code for status failure in Catch Blocks  
Manga Karumuri  20/11/2015   Added trim() to form number to remove spaces,commented form type and target system as these are retrieving from Salesforce itself 
Charitha S      01/12/2015   changed the datatype from MAp<String,String> to void for executeWebServices() method in Forms_WebServiceExecutor class.
                             only invoking the executeWebServices() method without expecting any return type.
Manga Karumuri  02/12/2015   ExternalSystemcode defaulting to DLR if it comes as NULL from Form Request. 
Manga Karumuri  07/12/2015   Moved the logic of conversion of account number to Data Aggregator Helper 
Manga Karumuri  15/12/2015   Added the logic of retriving adobe status code from custom setting.
Charitha S      16/12/2015   Added code to invoke webserviceHelper for inserting Forms_ResponseData.
                     
##########################################################################################
*/

global Class Forms_RequestProcesser{
    /*
      Method Name:processFormRequest
      Method Signature/Inputs:Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes
      Method Return Type/outputs: Forms_Validation_Result__c
      Method Description: This method is for external call
    */
    webservice static   Forms_Validation_Result__c processFormRequest(Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes){
        String result = '';
        List<Form_Request_Line_Item__c> tmpFormAttributes = null;
        Forms_Validation_Result__c valRes = new Forms_Validation_Result__c();
        valRes.Status__c='SUCCESS';
        try{
            system.debug('Pre Processor');
            tmpFormAttributes = new Forms_RequestPreProcessor().manageFormRequest(formRequest, formAttributes);
            system.debug('Before  Request Processor');
           
            valRes = new Forms_RequestProcesser().processInternalFormRequest(formRequest, tmpFormAttributes); 
            system.debug('After result');
            
        }catch(Exception e)   {
           System.debug('Form Request Process:: exception'+e);
           if(e instanceOf Forms_ValidationException){
                
            	if(formRequest==null || formRequest.Form_Number__c==null || formRequest.Form_Number__c.trim().length()==0)
            	valRes.Error_Description__c = e.getMessage();
            	else  
            	valRes.Error_Description__c = '';
            	valRes.Status__c = Forms_Constant.FAILURE;
                valRes.Error_Code__c = Forms_Fetch_CustomSetting.fetchErrorCode('System Exception');                 
            }
           
        }
        return valRes;
    } 

     
    /*
      Method Name:processInternalFormRequest
      Method Signature/Inputs:Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes
      Method Return Type/outputs: Forms_Validation_Result__c
      Method Description: This method is for internal call(Salesforce)
      */ 
     Public Forms_Validation_Result__c processInternalFormRequest(Form_Request__c formRequest, List<Form_Request_Line_Item__c> tmpFormAttributes) {
        Forms_Validation_Result__c frmValRes = new Forms_Validation_Result__c();
        Forms_DataValidator dataValidator;
        String returnMessage ='';
             
        try{
            
           if(formRequest == null){
               throw new Forms_InternalException();
            }
            if(formRequest.CreationDate__c == null){
                    formRequest.CreationDate__c = date.today();
                    system.debug('Forms_RequestProcesser::processInternalFormRequest ::  Value of CreationDate in FormRequest is:' + formRequest.CreationDate__c);
            }
            dataValidator = new Forms_DataValidator(formRequest.form_number__c.trim());
            system.debug('Forms_RequestProcesser::processInternalFormRequest::formRequest is :: ' + formRequest);                         
            
            frmValRes = dataValidator.validateData(formRequest,tmpFormAttributes);
            String status = frmValRes.Status__c;  
            //Using constant from Forms_Constants class
            if(status != null && status.equals(Forms_constant.FAILURE)){
                system.debug('Forms_RequestProcesser::processInternalFormRequest::Values in formRequest' + formRequest);
                system.debug('Forms_RequestProcesser::processInternalFormRequest:: Validation Status'+ status+ 'ErrorList is -' + frmValRes);
                //throw new Forms_ValidationException();
                return frmValRes;
            }


            Map<String,String> dataMap = createFormDataForExchange(formRequest, tmpFormAttributes);
            
            Document_Request__c docRequestObj = new Document_Request__c();
            Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
            documentData.setDocumentRequest(docRequestObj);
            
            //mapping RecipientAddress info to DocRequest Object. 
            Forms_RecipientAddressMapping recipientMapping = new Forms_RecipientAddressMapping();
            recipientMapping.mappingRecipientToDocReq(dataMap,documentData);
            
            List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList(formRequest.Form_Number__c.trim());  
            System.debug('Forms_RequestProcesser :: processInternalFormRequest :: Servicelist retreived' + serviceList);
               //calling executeWebServices method.
            system.debug('Forms_RequestProcesser :: processInternalFormRequest :: Servicelist after DataAggregator call' + dataMap);           
            new Forms_WebServiceExecutor().executeWebServices(dataMap, serviceList);
            if(dataMap.get('accountnumber')==null ){
                dataMap.put('accountnumber', dataMap.get('agreementNumber'));
            }
            system.debug('Forms_RequestProcesser :: processInternalFormRequest :: response map size is = '+dataMap.size()+'Forms_RequestProcesser :: processInternalFormRequest ::  dataMap values:+++'+ dataMap);
            
            Map<String,String> lookupData = new Forms_DataAggregator().queryForLookupData(formRequest.Form_Number__c.trim(), dataMap);
            system.debug('++++in Forms_RequestProcessor lookupData++++'+lookupData);
             Map<String,String> logicData = new Forms_DataAggregator().aggregateLogicDate(dataMap,lookupData, documentData);
            system.debug('++++in Forms_RequestProcessor logicdata++++'+logicData);
            for(String mapKey : logicData.keySet()){
                dataMap.put(mapKey, logicData.get(mapKey));
            } 
            system.debug('++++in Forms_RequestProcessor after logicdata++++'+JSON.serialize(dataMap));         
                       
            Forms_DocumentRequestDataMapping frmDocReqData = new Forms_DocumentRequestDataMapping();  
            //documentData = frmDocReqData.mappingResponseToDocReq(dataMap,documentData);  
            documentData = frmDocReqData.mappingResponseToDocReq(dataMap,documentData,serviceList); 
             system.debug('Forms_RequestProcesser :: processInternalFormRequest :: DocumentRequestDataMapping '+documentData );
            new Forms_DataAggregator().aggregateFormData(Forms_DataSelector.getFormInformation(formRequest.Form_Number__c.trim()),formRequest,documentData, dataMap); 
            //validating Response Data 
            
            frmValRes = frmDocReqData.validateResponseData(dataValidator,documentData);
            if(frmValRes != null && frmValRes.Status__c == Forms_Constant.FAILURE){
                return frmValRes;
            }
            
            //if validation is success generating XML
            
            frmDocReqData.generateDmsXML(documentData);
            returnMessage=Forms_DocumentRequestDataMapping.docReqXML; 
            frmValRes.Status__c=Forms_Constant.SUCCESS;
            frmValRes.Description__c=returnMessage;
            
           Set<String> stCode = new Set<String>();  
            for(Forms_StatusCodes__c cd:Forms_Fetch_CustomSetting.fetchstatusCode()){
              stCode.add(cd.Name);    
            }
           
           HttpResponse adobeResponse = new Forms_CalloutHandler().makeAdobeCallout(Forms_DocumentRequestDataMapping.docReqXML);
            
            system.debug(':: adobeResponse  ::'+adobeResponse.getBody());
          if(adobeResponse != null && (stCode.contains(String.valueof(adobeResponse.getStatusCode())))){
                Document_Request__c documentRequest = documentData.getDocumentRequest();
                List<Document_Request_Line_Item__c> documentRequestLineItemsList = documentData.getLineItems();
                if(documentRequest != null){
                   insert documentRequest;
                    if(documentRequest.Id != null && documentRequestLineItemsList.size() > 0){
                        for(Document_Request_Line_Item__c documentRequestLineItem :documentRequestLineItemsList){
                            documentRequestLineItem.Document_Request__c = documentRequest.Id;
                        }
                        insert documentRequestLineItemsList;
                    }
                }
            }  
            
            //invoking webservicehelper to insert responseData.
            Forms_WebServiceHelper.createServiceResponse(dataMap,Forms_WebServiceExecutor.futureServiceNameReqMap,
                                                            Forms_WebServiceExecutor.futureServiceNameRespMap,
                                                            Forms_WebServiceExecutor.futureServiceNameSysMap);
        }catch(Exception e){ 
            system.debug(e);
            system.debug('Forms_RequestProcesser :: processInternalFormRequest::Exception:'+ e.getMessage()+':::'+e.getStackTraceString()+':::'+e.getLineNumber()+':::'+e.getCause());         
            If(e instanceOf Forms_ServiceException){
                //Service Exception
                frmValRes.Error_Code__c = Forms_Fetch_CustomSetting.fetchErrorCode('ServiceFailure');
                frmValRes.ErrorMessage__c = Forms_Fetch_CustomSetting.fetchErrorMessage('ServiceFailure');
                frmValRes.Error_Description__c = Forms_Fetch_CustomSetting.fetchErrorMessage('ServiceFailure');
                frmValRes.Status__c = Forms_Constant.FAILURE;
            }
            else if(e instanceOf Forms_ValidationException){
                //System Exception               
                frmValRes.Error_Description__c = Forms_Fetch_CustomSetting.fetchErrorMessage('System Exception');                             
                frmValRes.ErrorMessage__c = e.getMessage();
                frmValRes.Status__c = Forms_Constant.FAILURE;
                frmValRes.Error_Code__c = Forms_Fetch_CustomSetting.fetchErrorCode('System Exception');                
            }
            //throw new Forms_ValidationException(frmValRes.ErrorMessage__c);
        }
        system.debug('Forms_RequestProcesser::processInternalFormRequest::formValidationResult is  ' + frmValRes);
         
        return frmValRes;
    }

     /*
      Method Name:createFormDataForExchange
      Method Signature/Inputs:Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes
      Method Return Type/outputs: Map<String, String>
      Method Description: Stores form request data as key value pairs
    */
    public Map<String, String> createFormDataForExchange(Form_Request__c formRequest, List<Form_Request_Line_Item__c> formAttributes)  {
        Map<String,String> dataMap = new Map<String,String>();
        try{
            List<Form__c> dispatchFields = [SELECT certifiedmail__c,legalEnvelop__c,Document_Type__c,NumberOfCopies__c,returnEnvelopRequired__c FROM Form__c WHERE Form_Number__c =: formRequest.Form_Number__c.trim()];
            formRequest.Account_Number__c = formRequest.Account_Number__c;
            system.debug('Forms_RequestProcesser::createFormDataForExchange::Converted Account number: ' + formRequest.Account_Number__c);
            dataMap.put(Forms_Constant.ACCOUNTNUMBER, formRequest.Account_Number__c);
            dataMap.put(Forms_Constant.FORMNUMBER, formRequest.Form_Number__c.trim());
            //commented as this field are coming from SFDC only 
            //dataMap.put(Forms_Constant.FORMTYPE, formRequest.Form_Type__c);
            dataMap.put(Forms_Constant.DISPATCHNAME, formRequest.Dispatch_Name__c);
            dataMap.put(Forms_Constant.SOURCESYSTEM, formRequest.SourceSystem__c);
            dataMap.put(Forms_Constant.CREATIONDATE, String.valueOf(formRequest.CreationDate__c));
            dataMap.put(Forms_Constant.DEVICENAME,formRequest.Device_Name__c);
           // dataMap.put(Forms_Constant.RECIPIENT,formRequest.Recipient__c);
            dataMap.put(Forms_Constant.REQUESTID,formRequest.RequestID__c);
            dataMap.put(Forms_Constant.RECIPIENTID,formRequest.Recipient__c);
            dataMap.put(Forms_Constant.ASSETMISCTYPE,Forms_Constant.ASSETMISCLICPL);
            dataMap.put(Forms_Constant.THIRDMISCTYPE,Forms_Constant.THIRDMISCBKFL);
            
            //commented as this field are coming from SFDC only
            //dataMap.put(Forms_Constant.TARGETSYSTEM,formRequest.Target_System__c);
 
            if(dispatchFields != null && dispatchFields.size() > 0)
            {
                dataMap.put(Forms_Constant.ISCERTIFIEDMAIL,string.valueof(dispatchFields[0].certifiedmail__c ));
                dataMap.put(Forms_Constant.ISLEGALEnvelope,string.valueof(dispatchFields[0].legalEnvelop__c ));
                dataMap.put(Forms_Constant.NUMBEROFCOPIES,string.valueof(dispatchFields[0].NumberOfCopies__c ));
                dataMap.put(Forms_Constant.DOCUMENTTYPE,string.valueof(dispatchFields[0].Document_Type__c ));
                dataMap.put(Forms_Constant.ISRETURNENVELOPEREQUIRED,string.valueof(dispatchFields[0].returnEnvelopRequired__c) );
            }
            if(formAttributes != null && formAttributes.size() > 0){                
                
                for(Form_Request_Line_Item__c formAttribute : formAttributes){
                   dataMap.put(formAttribute.FormAttributeKey__c,formAttribute.FormAttributeValue__c); 
                }
            }       
           
            
  
        }catch(Exception e){
            system.debug('Forms_RequestProcesser::createFormDataForExchange::Exception:'+ e.getMessage());
        } 
        return dataMap;
    } 
    
    
}