/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DataSelector
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 10/6/2015 
Last Modified by......: Thenmozhi
Last Modified Date....: 10/26/2015 
Description...........: This class has been written for quering metadata .it is used to collect external and internal data


Change Request History:
Charitha S  12/03/2015  Added Form_Field__r.Is_Service_Input__c field in the query in getConfiguredFields method.
##########################################################################################
 */
public class Forms_DataSelector{

	private static List<Form_Field_Junction__c> configuredFields = null;
	private static List<Form_Field_Junction__c> lineItemFields = new List<Form_Field_Junction__c>();
    private static List<Form_Field_Junction__c> serviceInfo = new List<Form_Field_Junction__c> ();   
    private static List<Form_Field__c> fieldsForValidation = new List<Form_Field__c>();
    private static Form__c formInfo = null;
    static List <Forms_LogicConfiguration__c> logicConfig = null;
    

	/*
      Method Name: getFieldsForValidation
      Method Signature/Inputs:String formID
      Method Return Type/outputs: List<Form_Field__c>
      Method Description:This method is used to Querying Form metadata from Form_Field__c 
	 */
	public static List<Form_Field__c> getFieldsForValidation(String formID){

		DateTime startDate = system.now();
        if(fieldsForValidation==null || fieldsFOrValidation.size()==0){
		if(String.isNotBlank(formID)){
			for(Form_Field_Junction__c fieldJunction : [SELECT id,Name,Form__r.id,Form_Field__r.id,
			                                            Form_Field__r.Service_Level__c,
			                                            Form_Field__r.Form_Service__c,Form_Field__r.Source_Field__c,
			                                            Form_Field__r.Data_Type__c,
			                                            Form_Field__r.Source_Object__c,Form_Field__r.Source_System__c,
			                                            Form_Field__r.Target_Field__c,Form__r.Name,Form__r.Copy_per_FAC__c,
			                                            Form__r.Document_Request_Record_Type__c,Form__r.Form_Number__c,
			                                            Form__r.Form_Type__c, Form_Field__r.Desired_Property__c FROM 
			                                            Form_Field_Junction__c WHERE Form__r.Form_Number__c =: formID]){

				fieldsForValidation.add(fieldJunction.Form_Field__r);
			}
		}
        }
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getFieldsForValidation');
		return fieldsForValidation;  
	}

	/*
      Method Name: getServiceList
      Method Signature/Inputs:String formID
      Method Return Type/outputs: List<Form_Field_Junction__c>
      Method Description:This Method for calling services based on service List From object - Identify service name
	 */
	public List<Form_Field_Junction__c> getServiceList(String formId){
		DateTime startDate = system.now();
        if(serviceInfo==null || serviceInfo.size()==0){
			serviceInfo = new List<Form_Field_Junction__c> ();    
            if(String.isNotBlank(formId)){
                serviceInfo = [SELECT Form_Field__r.Service_Level__c,
                               Form_Field__r.Form_Service__c, 
                               Form_Field__r.Form_Service__r.Name,Form_Field__r.Form_Service__r.MultiNode__c, Form_Field__r.Source_System__c, 
                               Form_Field__r.DependantService__c, Form_Field__r.DependantService__r.Name, Form_Field__r.Desired_Property__c,
                               Form_Field__r.Target_Field__c,Form_Field__r.Line_item_field__c,Form_Field__r.Line_item_type__c FROM Form_Field_Junction__c 
                               WHERE Form__r.Form_Number__c =: formId 
                               AND Form_Field__r.Form_Service__c != NULL ORDER BY Form_Field__r.Service_Level__c ASC];
            }
        }
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getServiceList');
		return serviceInfo;
	}
	/*
      Method Name: getConfiguredFields
      Method Signature/Inputs:String formID
      Method Return Type/outputs: List<Form_Field_Junction__c>
      Method Description:This Method is used to query data from Form_Field_Junction__c
	 */
	public static List<Form_Field_Junction__c> getConfiguredFields(String formId){
		if(configuredFields == null || configuredFields.size() == 0){
			configuredFields = new  List<Form_Field_Junction__c>();

			configuredFields = [SELECT Form__c, Required__c, Form_Field__c, Form_Field__r.name, Form_Field__r.Data_Type__c, Form_Field__r.Display_Name__c,
			                    Form_Field__r.Service_Level__c, Form_Field__r.Form_Service__c, Form_Field__r.Forms_QueryConfig__c, 
			                    Form_Field__r.Source_System__c,Form_Field__r.Is_Service_Input__c, Form_Field__r.Target_Field__c,Form_Field__r.Line_item_field__c,
			                    Form_Field__r.Line_item_type__c, Form_Field__r.WS_DestinationNode__c, Form_Field__r.WS_Sequence__c, Form_Field__r.Desired_Property__c 
			                    FROM Form_Field_Junction__c WHERE Form__r.Form_Number__c =: formId order by Form_Field__r.WS_Sequence__c];
		}    
		return configuredFields; 
	}
	/*
      Method Name : getInternalFieldsList
      Method Signature/Inputs : String formID
      Method Return Type/outputs : List<Form_Field_Junction__c
      Method Description : This Method is used to querying SFDC data from Form_Field_Junction__c based on source system field
	 */
	public List<Form_Field_Junction__c> getInternalFieldsList(String formId){
		return getFieldsList(formId,'SFDC');
	}
    
    /*
     * Retieves the form fields requires logical operation
     */
      
    public static List<Form_Field_Junction__c> getFieldsList(String formId, String systemName){
		DateTime startDate = system.now();
		List<Form_Field_Junction__c> formFieldJunctionList = new  List<Form_Field_Junction__c> ();
		if(String.isNotBlank(formId)){
			formFieldJunctionList = [SELECT Form_Field__r.Service_Level__c,Form_Field__r.Form_Service__c, 
			                         Form_Field__r.Forms_QueryConfig__c, Form_Field__r.Forms_Logic_Config__c,
			                         Form_Field__r.Source_System__c, Form_Field__r.Source_Object__c, Form_Field__r.Source_Field__c,
			                         Form_Field__r.Target_Field__c FROM Form_Field_Junction__c 
			                         WHERE Form__r.Form_Number__c=:formId AND Form_Field__r.Source_System__c = :systemName ];
		}
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getInternalFieldsList');
		return formFieldJunctionList;
	}
    
    

	/*
      Method Name: getServiceConfigList
      Method Signature/Inputs:List<Form_Field__c> fields
      Method Return Type/outputs: List<FormServiceConfig__c>
      Method Description:This Method is used to querying FormServiceConfig__c data based on the input field .it will return list of services
	 */
	public List<FormServiceConfig__c> getServiceConfigList(List<Form_Field__c> fields){    
		DateTime startDate=system.now();
		List <FormServiceConfig__c> formServiceConfig= new List<FormServiceConfig__c>();
		Set<String> setServicename = new Set<String>();
		Set<String> setTargetField = new Set<String>();
		if(fields.size() > 0){
			for(Form_Field__c formField :fields ){
				setServicename.add(formField.Form_Service__r.Name);
				if(formField.Target_Field__c!=null)
				setTargetField.add(formField.Target_Field__c);
			}
			
			system.debug('::setTargetField'+setTargetField);
			if(setServicename.size() > 0){
				for(FormServiceConfig__c formServiceConfg : [SELECT id, Name, AttributeType__c, FormService__c,
				                                             ParentNode__c, ChildNode__c, ReferenceAttribute__c,
				                                             Type__c, Key__c, AttributeKey__c, AttributeValue__c,
				                                             IsAttribute__c, IsMultipleAttribute__c, Multiple_Elements_Node__c,  
				                                             FormService__r.ServiceProvider__c, FormService__r.Name,Seperator__c,
				                                             allFields__c,ElementAttributeKey__c,ElementAttributeValue__c, FormService__r.MultiNode__c, 
				                                             Link_to_Document_Request_Object__c FROM FormServiceConfig__c WHERE FormService__r.Name IN : setServicename ]){
					formServiceConfig.add(formServiceConfg);
				}
			}
		}
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getServiceConfigList');
		return formServiceConfig;
	}
    
    /*Returns service information*/
    
    public List<FromServices__c> getServicesInfo(List<String> serviceIdList){
        List<FromServices__c> servicesInfo = [SELECT NAME, DESCRIPTION__C, MULTINODE__C,	SERVICEPROVIDER__C FROM FROMSERVICES__C WHERE ID IN :serviceIdList];
        
        return servicesInfo;
    }
	/*
      Method Name: getAttachments
      Method Signature/Inputs:List<String> serviceIdList
      Method Return Type/outputs: Map<String,Attachment> mappingData
      Method Description:This Method is used to querying Attachment data based on the List of input serviceid 
	 */
	public Map<String,Attachment> getAttachments(List<String> serviceIdList){
		DateTime startDate = system.now();
		String[] fileLines = new String[]{};
		Map<String,Attachment> mappingData = new Map<String,Attachment>();
		List<Attachment> listOfAttachment = new List<Attachment>();
		if(serviceIdList.size() > 0){
			listOfAttachment = [SELECT id,Name,Body,parentId,ContentType FROM Attachment 
			                    WHERE Name =:Forms_Constant.REQUEST_NAME AND ParentId IN : serviceIdList];
			if(listOfAttachment.size() > 0){
				for(Attachment attach: listOfAttachment){
					mappingData.put(attach.parentId,attach);
				}
			}
		}
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getAttachments');
		return mappingData;
	}
	/*
      Method Name: getQueryConfigRecords
      Method Signature/Inputs:List<Id> queryConfigIdList
      Method Return Type/outputs: Map<String,Forms_QueryConfig__c>
      Method Description:This Method is used to querying Forms_QueryConfig__c data based on List<Id> queryConfigIdList .use this method to collect SFDC data  
	 */
	public Map<String,Forms_QueryConfig__c> getQueryConfigRecords(List<Id> queryConfigIdList)
	{
		DateTime startDate = system.now();
		Map<String, Forms_QueryConfig__c> objectConfig = new Map<String,Forms_QueryConfig__c>();
		if(queryConfigIdList.size() > 0){
			for(Forms_QueryConfig__c queryConfig : [SELECT Id,Field_APIName__c,Object_ApiName__c,ReferenceAttribute__c FROM Forms_QueryConfig__c 
			                                        WHERE Id IN : queryConfigIdList])
			{
				objectConfig.put(queryConfig.Id, queryConfig);
			}
		}
		Forms_Utils.executionTime(startDate,system.now(),'Forms_DataSelector','getQueryConfigRecords');
		return objectConfig;
	} 
	/*
      Method Name: getEndPointUrls
      Method Signature/Inputs:List<String> serviceNamesList
      Method Return Type/outputs: Map<String, String>
      Method Description:This Method is used to querying data from Forms_EndPointConfig__c to get service path details.
	 */   
	public Map<String, String> getEndPointUrls(List<String> serviceNamesList){
		Map<String, String> endPointMap = new Map<String, String>();
		if(serviceNamesList.size() > 0){
			for(Forms_EndPointConfig__c endPoint : [SELECT Service_Name__c, EndPointURL__c, ServiceURL__c FROM Forms_EndPointConfig__c WHERE Service_Name__c IN : serviceNamesList]){          
				endPointMap.put(endPoint.Service_Name__c.toLowerCase(), endPoint.EndPointURL__c+endPoint.ServiceURL__c);
			}
		}
		return endPointMap;
	}
	/*
      Method Name: getFormInformation
      Method Signature/Inputs:String formNumber
      Method Return Type/outputs: form
      Method Description:This Method is used to querying data from Form__c to get form informations.
	 */
	public static Form__c  getFormInformation(String formNumber){

        if(formInfo==null){
            formInfo = [SELECT certifiedmail__c,Document_Type__c,
		                Form_Type__c,legalEnvelop__c,NumberOfCopies__c,returnEnvelopRequired__c, Entity_Key__c 
		                FROM Form__c WHERE Form_Number__c =: formNumber];
        }
		return formInfo;

	}

	/*
      Method Name: getAdobeServiceEndPoint
      Method Signature/Inputs:
      Method Return Type/outputs: Adobe Endpoint 
      Method Description:This Method is used to get Adobe Service End Point for DMS.
	 */

	public static String getAdobeServiceEndPoint(){
		String AdobeValue;
		Forms_EndPointConfig__c adobe = Forms_EndPointConfig__c.getValues('AdobeService');
		system.debug('ADOBE SERVICE'+ adobe);
		if(adobe != null && adobe.ServiceURL__c != null && adobe.EndPointURL__c != null){
			AdobeValue =  adobe.EndPointURL__c + adobe.ServiceURL__c;
		}
		return AdobeValue;
	}
    
    /*
        Retrieve configuration items related to form
	 */
    public static List<Forms_LogicConfiguration__c> getLogicConfiguration(List<id> logicConfigList){
        if(logicConfig==null || logicConfig.size()==0){
           logicConfig= [SELECT Document_Object__c,failValue__c,Logic_Condition__c,Operator__c,
                                Referecen_Attribute__c,referenceValue__c,successValue__c,value__c,expression__c 
                         FROM Forms_LogicConfiguration__c
                         WHERE Id IN : logicConfigList];
                
        }
        return logicConfig;
    }
  
    
/* Retrieving recipient Address info based on Acc Num and UCID.
    
    */
    public static List<Financial_Account_Customer__c> getSFDCRecipientInfo(Map<String,String> inputMap){
    	List<Financial_Account_Customer__c> recipientInfo = [select Name,Mailing_Street_BillTo__c,Address_Special_BillTo__c,Mailing_City_BillTo__c,Mailing_State_BillTo__c,Mailing_PostalCode_BillTo__c,Account__r.name,Account__r.Flag_Deceased__pc from Financial_Account_Customer__c
         where Universal_Customer_Id__c=:  inputMap.get(Forms_Constant.RECIPIENTID) and Financial_Account_Number__c =: inputMap.get(Forms_Constant.ACCOUNTNUMBER)];
    return 	recipientInfo;
    
    }
    
    /* Retrieving Line Items for MultiNode checked Services.
    
    */
    public static List<Form_Field_Junction__c> getMultiServicesJunctions(Map<String,String> responseDataMap,Map<String,String> docReqLineItemMap){
    	List<Form_Field_Junction__c> lineItems = [SELECT Form__c, Required__c, Form_Field__c, Form_Field__r.Form_Service__r.multiNode__c, 
                                Form_Field__r.Target_Field__c,Form_Field__r.Line_item_field__c,
                                Form_Field__r.Line_item_type__c FROM Form_Field_Junction__c WHERE Form__r.Form_Number__c =: responseDataMap.get(Forms_Constant.FORMNUMBER)
                                and Form_Field__r.Target_Field__c IN : docReqLineItemMap.values() order by Form_Field__r.Line_item_type__c];
    return 	lineItems;
    
    }

}