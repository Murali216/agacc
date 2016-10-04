/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_WebServiceHelper
Version...............: 1.0
Created by............: Muthuraj
Created Date..........: 10/27/2015> 
Last Modified by......: Muthuraj
Last Modified Date....: 10/27/2015 >
Description...........: This class is made to implement helper methods to be 
                        used in Forms_WebServiceExecutor class.

Change Request History:
Charitha S  12/16/2015      Removed @future annotation for the method createServiceResponsea.
##########################################################################################
 */
public class Forms_WebServiceHelper{
    
    /*
    Method Name: createServiceResponse
    Method Signature: Map<String, String> inputMap,
                        Map<String, String> serviceNameRequestMap,
                        Map<String, String> serviceNameResponseMap,
                        Map<String, String> serviceNameSystemMap
    Method Return type: void
    Method Description: This method creates Forms_ResponseData record for each services with
        request and response xml as attachment.
    */
    
    public static void createServiceResponse(Map<String, String> inputMap,
            Map<String, String> serviceNameRequestMap,
            Map<String, String> serviceNameResponseMap,
            Map<String, String> serviceNameSystemMap){
            
            List<Forms_ResponseData__c> formsResponseDataObjectList = new List<Forms_ResponseData__c>();
            List<Attachment> attachmentObjectList = new List<Attachment>();
            Attachment attachmentObject = new Attachment();
            String formServiceName = '';
            
            for(String serviceName : serviceNameRequestMap.keySet()){
                Forms_ResponseData__c responseDataObject = new Forms_ResponseData__c(
                        RequestID__c = (inputMap.containsKey('requestid')? inputMap.get('requestid') : 'NA'), 
                        Requesting_System__c = (serviceNameSystemMap.containsKey(serviceName)? serviceNameSystemMap.get(serviceName) : 'NA'),                     
                        Service_Name__c = serviceName,
                        Source_System__c = (inputMap.containsKey('sourcesystem')? inputMap.get('sourcesystem') : 'NA')                    
                        );            
                formsResponseDataObjectList.add(responseDataObject);           
            }
            if(formsResponseDataObjectList.size() > 0){
                insert formsResponseDataObjectList;
            }
            for(Forms_ResponseData__c responseDataObject :formsResponseDataObjectList){
                formServiceName = responseDataObject.Service_Name__c;
                attachmentObject = new Attachment();
                if(String.isNotBlank(responseDataObject.Id)){
                    attachmentObject.ParentId = responseDataObject.Id;
                    attachmentObject.Body = (serviceNameRequestMap.containsKey(formServiceName) && 
                            serviceNameRequestMap.get(formServiceName) != null? Blob.valueOf(serviceNameRequestMap.get(formServiceName)) : null); 
                    attachmentObject.Name = 'request.xml';
                }
                if(attachmentObject.Body != null)
                attachmentObjectList.add(attachmentObject);

                attachmentObject = new Attachment();
                if(String.isNotBlank(responseDataObject.Id)){
                    attachmentObject.ParentId = responseDataObject.Id;
                    attachmentObject.Body = (serviceNameResponseMap.containsKey(formServiceName) && 
                            serviceNameResponseMap.get(formServiceName) != null? Blob.valueOf(serviceNameResponseMap.get(formServiceName)) : null);
                    attachmentObject.Name = 'response.xml';
                }
                if(attachmentObject.Body != null)
                attachmentObjectList.add(attachmentObject);             
            }
            if(attachmentObjectList.size() > 0){
                /*for(Attachment att : attachmentObjectList){
                system.debug('::Attachment::'+att);
            }*/
                insert attachmentObjectList;
            } 
    }


}