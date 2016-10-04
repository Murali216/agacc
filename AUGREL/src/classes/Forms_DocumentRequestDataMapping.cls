/*
#################################################################################################################
Project Name         : TFS Forms Implementation
File                 : Forms_DocumentRequestDataMapping
Version              : <1.0>
Created by           : Infosys Offshore team
Created Date         : 12/10/2015 
Last Modified by     : <NAME>
Last Modified Date   : <MM/DD/YYYY >
Description          : This class will map the response values to Document request object.
                        Validates the response.
                        Builds the XML using FormsServiceConfig obj.

Change Request History:

Modified By      Date              Comments

Sridhar G      23/10/2015        Added Data type check and mapping fields to Document Request Object
                                 Added Static block for reading document requst fields data type 
                      
Sridhar G      27/10/2015        Added Data type check and mapping fields to Document Request line item Obejct

Charitha S     12/11/2015        Changed mappingResponseToDocReq method. this method is only responsible to map the sent reponseMap to DocReqObj
                                 and set to Forms_DocumentDataHolder.code changes & method signature in validateResponseData method which is 
                                 invoked from Forms_RequestProcessor for validation Reponse Data. Added new method generateDmsXML which is invoked from 
                                 Forms_RequestProcessor if validation is success.
                                 
Geetha M       18/11/2015        Changed the query in order to obtain service level fields as suggested by Hanumantha
###################################################################################################################
*/


public class Forms_DocumentRequestDataMapping{

  Document_Request__c docReqObj = new Document_Request__c();  
  public static List<FormServiceConfig__c> docReqMappingList = new List <FormServiceConfig__c>();
  public static Map<string,string> docReqMap = new Map<string,string>();
  public static Set<String> docReqSet = new Set<String>();
  Map<string, string> dataTypeMap = new map<string, string>(); 
   Set<String> logicSet = new  Set<String>(); 
 /* public static String type = null;
  public static Map<String, Schema.SObjectType> schemaMap = null;
  public static Schema.SObjectType docReqSchema = null;
  public static Map<String, Schema.SObjectField> fieldMap = null;
 
  static
  {
    type= Forms_Constant.DOCUMENTREQUEST;
    schemaMap = Schema.getGlobalDescribe();
    DocReqSchema = schemaMap.get(type);
    fieldMap = DocReqSchema.getDescribe().fields.getMap();
  }*/
  /* added for testing */
  public static String docReqXML='';  

  /*
    Method Name: mappingResponseToDocReq
    Method Signature/Inputs: responseDataMap from forms_requestProcessor, Forms_DocumentDataHolder class instance.
    Method Return Type/outputs: ResponseDataMap values will be assigned to DocumentRequest obj and documnetRequestLineitem object.
    Method Description: This method is called from Forms_requestProcessor class, where this method checks if the 
                        Datatype format is correct and gives the output in the objects.
  */
  public Forms_documentDataHolder mappingResponseToDocReq(map<String,string> responseDataMap, Forms_DocumentDataHolder documentData,
                                                            List<Form_Field_Junction__c> serviceList )
  {
    Forms_Utils.gettingAllMetaDataFields(Forms_Constant.DOCUMENTREQUEST);
    Map<String,String> docReqLineItemMap = new Map<STring,String>();
    Datetime startDate=system.now();
    Set<String> serviceIdSet = new Set<String>();
    docReqObj = documentData.getDocumentRequest();
    
     system.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::Document Request::'+json.serialize(docReqObj));
      
    try
      { 
             
       System.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq()::docReqMap====>'+json.serialize(docReqMap));
       System.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq()::responseDataMap====>'+json.serialize(responseDataMap));
       System.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq()::responseDataMap====>'+json.serialize(responseDataMap.keyset()));
          
       /*integer serviceDocReqFieldCount = 0;
       Set<String> desiredFields = new Set<String>();
       for(Form_Field_Junction__c formFieldJunc : serviceList){
            
            if((formFieldJunc.Form_Field__r.Desired_Property__c!=null) && (formFieldJunc.Form_Field__r.Desired_Property__c.trim().length()>0)){
               desiredFields.add(formFieldJunc.Form_Field__r.Desired_Property__c);
            }    
           if(formFieldJunc.Form_Field__r.Target_Field__c !=null && formFieldJunc.Form_Field__r.Target_Field__c.trim().length()>0){
               serviceDocReqFieldCount++;
           }
           
        }
          System.debug('desiredfields'+desiredFields.size()+'::'+desiredFields+'::'+serviceList.size()+'::'+serviceDocReqFieldCount);
       */
      
     docReqMappingList = [SELECT FormService__r.name,FormService__r.MultiNode__c,Id,name,ReferenceAttribute__c,Link_to_Document_Request_Object__c,Link_to_DocumentRequestLineItem_Object__c from FormServiceConfig__c where (AttributeType__c =:Forms_Constant.RESPONSE) and ReferenceAttribute__c in :responseDataMap.keyset()];
     
     /* adding by manga  */
     List<Forms_QueryConfig__c> queryConfig =  [SELECT Field_APIName__c, Filter_Field__c, Object_APIName__c,ReferenceAttribute__c,DataType__c,Document_Object_Field__c FROM Forms_QueryConfig__c WHERE Document_Object_Field__c IN :responseDataMap.keyset()];
     Set<String> configSet = new Set<String>();
     for(Forms_QueryConfig__c queConfig:queryConfig){
        configSet.add(queConfig.Document_Object_Field__c);      
     }
      /* adding by manga  */
      
      /* Addeded by Balaji Jadav */
      /*List<Forms_LogicConfiguration__c> logicConfig = [Select Referecen_Attribute__c,value__c,
      Document_Object__c from  Forms_LogicConfiguration__c WHERE Document_Object__c IN : responseDataMap.keyset()];
       
      for (Forms_LogicConfiguration__c logiccon:logicConfig){
          logicSet.add(logiccon.Document_Object__c);
      }*/
         /* data mapping to document requst object matching desired field in form field object and reference attribute in form service configuration */
          
          List<Form_Field_Junction__c> formFields = Forms_DataSelector.getConfiguredFields(responseDataMap.get('formnumber'));
          for(Form_Field_Junction__c field: formFields) {
              String ffRef = field.Form_Field__r.Desired_Property__c;
              if(ffRef!=null && ffRef.trim().length()>0){
                  String value = responseDataMap.get(ffRef);
                  docReqMap.put(ffRef,field.Form_Field__r.Target_Field__c);
                  docReqSet.add(ffRef);    
              }
              
          }
      
      /* Addeded By Balaji Jadav */
     
        for(FormServiceConfig__c formServConf : docReqMappingList) {
            if(formServConf.Link_to_Document_Request_Object__c != null) {
                
                docReqMap.put(formServConf.ReferenceAttribute__c,formServConf.Link_to_Document_Request_Object__c);
                docReqSet.add(formServConf.ReferenceAttribute__c);
                
            }else if(formServConf.Link_to_DocumentRequestLineItem_Object__c != null && formServConf.FormService__r.MultiNode__c){
                //populating below map for multinode form services.
                docReqLineItemMap.put(formServConf.ReferenceAttribute__c,formServConf.Link_to_DocumentRequestLineItem_Object__c);
            }        
        }
     
        system.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq():: docReqSet:'+docReqSet); 
        system.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq():: docReqMap:'+docReqMap.size()+'::'+json.serialize(docReqMap));
        
        for(String resSingleKey : responseDataMap.keyset())
        {   
            if(docReqSet.contains(resSingleKey))
            {
                
              String apiNameDR = docReqMap.get(resSingleKey);
              system.debug('Forms_DocumentRequestDataMapping :: mappingResponseToDocReq():: apiNameDR:'+apiNameDR);
             // Schema.DisplayType fielddataType = fieldMap.get(apiNameDR).getDescribe().getType();
              Schema.DisplayType fielddataType = Forms_Utils.fieldMap.get(apiNameDR).getDescribe().getType();
              String fieldAPIName = Forms_Utils.fieldMap.get(apiNameDR).getDescribe().getName();
             // System.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::<--fieldAPIName---->'+fieldAPIName+'<==fielddataType===>'+fielddataType + '<=== data===>'+responseDataMap.get(resSingleKey));  
                String responseData = responseDataMap.get(resSingleKey);
                if(responseData!=null && responseData.trim().length() > 0){
                if(fielddataType == Schema.DisplayType.Double){
                   
                    if(responseData.indexOf('.')==-1){
                        docReqObj.put(apiNameDR,Integer.valueOf(responseDataMap.get(resSingleKey)));
                    }else{
                       docReqObj.put(apiNameDR,Double.valueOf(responseDataMap.get(resSingleKey)));
                    }    
                }
                else if(fielddataType == Schema.DisplayType.DATE){
                  docReqObj.put(apiNameDR,date.valueOf(responseDataMap.get(resSingleKey)));
                }
                else if(fielddataType == Schema.DisplayType.DATETIME){
                  docReqObj.put(apiNameDR,DATETIME.valueOf(responseDataMap.get(resSingleKey)));
                }
                else if(fielddataType == Schema.DisplayType.boolean){
                  docReqObj.put(apiNameDR,boolean.valueOf(responseDataMap.get(resSingleKey)));
                }
                else{
                  docReqObj.put(apiNameDR,(responseDataMap.get(resSingleKey)));
                }
                }               
                system.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::Valuesobj==>'+ docReqObj); 
                
        }
        /* Added by manga for testing */
        else{
              if(configSet.contains(resSingleKey)){
          
                  Schema.DisplayType fieldconfigdataType =Forms_Utils.fieldMap.get(resSingleKey).getDescribe().getType();
                  String fieldCnfgAPIName = Forms_Utils.fieldMap.get(resSingleKey).getDescribe().getName();
                  System.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::<--fieldAPIName---->'+fieldCnfgAPIName+'<==fielddataType===>'+fieldconfigdataType + '<=== data===>'+responseDataMap.get(resSingleKey));
                  String responseData = responseDataMap.get(resSingleKey);
                  if(fieldconfigdataType  == Schema.DisplayType.Double){
                      if(responseData.indexOf('.')==-1)
                        docReqObj.put(resSingleKey,Integer.valueOf(responseData));
                     else
                       docReqObj.put(resSingleKey,Double.valueOf(responseData ));
                  }
                  else if(fieldconfigdataType  == Schema.DisplayType.DATE)
                      docReqObj.put(resSingleKey,date.valueOf(responseData));
                  else if(fieldconfigdataType  == Schema.DisplayType.DATETIME)
                      docReqObj.put(resSingleKey,DATETIME.valueOf(responseData));
                  else if(fieldconfigdataType  == Schema.DisplayType.boolean)
                      docReqObj.put(resSingleKey,boolean.valueOf(responseData ));
                  else
                  docReqObj.put(resSingleKey,responseData); 
                   
              }  
        }
     }
       
      documentData.setDocumentRequest(docReqObj);     
    //map Response to DocumentRequestLineItems object.
    if(docReqLineItemMap!=null && docReqLineItemMap.size()>0)
      mapResponseToDocReqLineItem(responsedataMap,docReqLineItemMap,documentData);
      
      system.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::Document Request::'+json.serialize(docReqObj));
      Forms_Utils.executionTime(startDate,system.now(),'Forms_DocumentRequestDataMapping','mappingResponseToDocReq');
     
  }
  catch(Exception e)
  {
    System.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::Forms_documentReqMApping : '+e.getStackTraceString());
    System.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq::Forms_documentReqMApping : '+e.getmessage());
  }
    return documentData;      
 } 

  /*
    Method Name: mapResponseToDocReqLineItem
    Method Signature/Inputs: responseDataMap , docReqLineItemMap, Forms_DocumentDataHolder class instance.
    Method Return Type/outputs: void
    Method Description: This method will check any multinode services are configured for form, if exists creates lineitems for
    each lineitemType with multi values retrieved from service and sets all lineitems to documentData.
  */
  public void mapResponseToDocReqLineItem(map<String,String> responsedataMap,Map<String,String> docReqLineItemMap, Forms_DocumentDataHolder documentData){
    
        Map<String, Map<String, List<String>>> lineItemsMap = new Map<String, Map<String, List<String>>>();
        Map<String, List<String>> multiNodeMap = new Map<String, List<String>>();
        Map<String, Integer> lineItemsCount = new Map<String,Integer>();
        List<Document_Request_Line_Item__c> docReqLineItemsList =  documentData.getLineItems(); 
        
        //get FormFieldJunction for multinode services  
        List<Form_Field_Junction__c> lineItems = Forms_DataSelector.getMultiServicesJunctions(responseDataMap,docReqLineItemMap);
        system.debug('@lineItems'+lineItems);                        
        for(Form_Field_Junction__c junction : lineItems){
           
            //for each multinode lineItem type creating map<lineItemType,map<Link_To_Document_Request_LineItem,List<values>>>>
            STring lineItemType = junction.Form_Field__r.Line_item_type__c;
            Integer count = 0 ;
            if(!lineItemsMap.containsKey(lineItemType))
            multiNodeMap = new Map<String,List<String>>();
            for(String lineItemKey : docReqLineItemMap.keySet())
            {
                if(junction.form_field__r.target_Field__c.equalsIgnoreCase(docReqLineItemMap.get(lineItemKey))){
                String responseData = responseDataMap.get(lineItemKey);
                if(responseData!=null && responseData.trim().length() > 0){ 
                String[] splitKey = responseData.split(',');
                count = splitKey.size();
                multiNodeMap.put(docReqLineItemMap.get(lineItemKey),splitKey);
                    }
                }
            }
            lineItemsMap.put(lineItemType,multiNodeMap);
            if(!lineItemsCount.containsKey(lineItemType) && count>0)
            lineItemsCount.put(lineItemType,count);
        }
        //populating lineItems for multiNode Serviceconfig response.
        for(String type : lineItemsMap.keySet()){  
            for(Integer i=0;i<lineItemsCount.get(type);i++){        
                Document_Request_Line_Item__c docReqLineItem= new Document_Request_Line_Item__c();
                docReqLineItem.Type__c = type;
                for(String apiName :lineItemsMap.get(type).keySet()){
                    docReqLineItem.put(apiName,lineItemsMap.get(type).get(apiName).get(i));
                }
                 
            docReqLineItemsList.add(docReqLineItem);
            }           
        }
        System.debug('Forms_DocumentRequestDataMapping::mapResponseToDocReqLineItem:: docReqLineItems size: '+docReqLineItemsList.size());
    documentData.setLineItems(docReqLineItemsList);
  }
/*
    Method Name: validateResponseData
    Method Signature/Inputs: Forms_DataValidator dataValidator,Forms_DocumentDataHolder documentData
    Method Return Type/outputs: Result, if the class passes it will be sent to next method for output generation, 
                                if it fails it will retrun Forms_Validation_Result__c object.
    Method Description: This method is called from forms_requestProcessor class, it is to Validate if the data in the Objects 
                        is in right format and retruns the Forms_Validation_Result__c  object if it fails.
*/
 Public Forms_Validation_Result__c validateResponseData(Forms_DataValidator dataValidator,Forms_DocumentDataHolder documentData) 
  {     
    Datetime startDate=system.now();     
    system.debug('Forms_DocumentRequestDataMapping::validateResponseData::Validate method documentData.getLineItems():'+documentData.getLineItems());
    Forms_Validation_Result__c result = dataValidator.validateDocumentData(documentData.getDocumentRequest(),documentData.getLineItems());   
    system.debug('Forms_DocumentRequestDataMapping::validateResponseData::Validate method check:'+result);
    Forms_Utils.executionTime(startDate,system.now(),'Forms_DocumentRequestDataMapping','validateResponseData');
    return result;  
  }

  
/*
    Method Name: generateDmsXML
    Method Signature/Inputs: Forms_DocumentDataHolder documentData
    Method Return Type/outputs: This method will generate XML.
    Method Description: This method is called from forms_requestProcessor class, it is to generate Final XML
*/
  public void generateDmsXML(Forms_DocumentDataHolder documentData)
    {
    
        FORMS_WS_GenerateDocument.XMLNode docReq=FORMS_WS_GenerateDocument.buildFormFieldMap(String.valueOf(documentData.getDocumentRequest().formId__c),documentData.getDocumentRequest(),documentData.getLineItems());
        Forms_DocumentRequestDataMapping.docReqXML= docReq.getXMLString();  
        System.debug('Forms_DocumentRequestDataMapping::mappingResponseToDocReq()::XMLString'+Forms_DocumentRequestDataMapping.docReqXML);
    
    
}
}