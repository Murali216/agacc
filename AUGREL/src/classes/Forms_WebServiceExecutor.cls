/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_WebServiceExecutor> 
Version...............: <1.0>
Created by............: <Muthu>
Created Date..........: <10/6/2015 
Last Modified by......: <Thenmozhi>
Last Modified Date....: <10/26/2015 >
Description...........: <This class has been written for executes web services based on the seqence and captures response as key value pairs>


Change Request History:
charitha s  12/01/2015    changing the dataType Map<String,String> to void for executeWebServices method.
Charitha S  12/16/2015    Added three static member variables which can be used in Forms_RequestProcessor 
                          to insert forms_responseData.
##########################################################################################
 */
public class Forms_WebServiceExecutor { 

    public static Map<String,String> futureServiceNameReqMap = new Map<String,String>();
    public static Map<String, String> futureServiceNameRespMap = new Map<String, String>();
    public static Map<String, String> futureServiceNameSysMap = new Map<String, String>();
    public Map<String, String> serviceNameRequestMap = new Map<String, String>();
    public Map<String, String> serviceNameResponseMap = new Map<String, String>();
    public Map<String, String> serviceNameSystemMap = new Map<String, String>();
    public Map<String,String> responseDataMap = new Map<String,String>();
    /*
    Method Name: executeWebServices
    Method Signature: Map<String,String> inputMap, List<Form_Field_Junction__c> servicesInfo
    Method Return type: void
    Method Description: This method will execute the needed services to fetch data from external
        system and returns the response map.
     */
    public void executeWebServices(Map<String,String> inputMap, List<Form_Field_Junction__c> servicesInfo){
        Datetime startDate=system.now();        
        system.debug('Forms_WebServiceExecutor::executeWebServices::inputMap::'+json.serialize(inputMap));
        
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        Map<String, List<Form_Field_Junction__c>> externalSystemFieldsMap = new Map<String, List<Form_Field_Junction__c>>();
        //Map<String, Form_Field__c> dependantServiceMap = new Map<String, Form_Field__c>();
        Map<String, List<FormServiceConfig__c>> sourceSystemServiceConfigMap = new Map<String, List<FormServiceConfig__c>>();
        List<String> serviceIdList = new List<String>();
        Map<String, Map<String, List<FormServiceConfig__c>>> serviceResponseConfigMap = new Map<String, Map<String, List<FormServiceConfig__c>>>();        
        Map<String, Map<String, List<FormServiceConfig__c>>> serviceRequestConfigMap = new Map<String, Map<String, List<FormServiceConfig__c>>>();                
        Map<String, String> serviceNameIdMap = new Map<String, String>();
        
        List<String> serviceNamesList = new List<String>();
        List<FormServiceConfig__c> serviceConfigList = new List<FormServiceConfig__c>();
        Map<String,Attachment> serviceIdAttachmentMap = new Map<String,Attachment>();
        Map<String, Map<String, String>> serviceResponseMap = new Map<String, Map<String, String>>();
        Map<String, String> endPointMap = new Map<String, String>();        
        Map<String, Set<String>> sourceSystemServiceMap = new Map<String, Set<String>>();
        Map<String, String> tempSourceAndServiceMap = new Map<String, String>();
        List<String> xmlStringList = new List<String>();
        String endPoint = '';
        String inputXMLString = '';
        String xmlString = '';
        String method = '';
        HttpResponse response = new HttpResponse();
        String key = '';
        String tempServiceKey = '';
        String serviceOrder = '';
        

        /*
            Iterate the ServiceInfo list which we get as input parameter and 
            format the Map like key as Source system and value as 
            list of form fields
            Ex: externalSystemFieldsMap['ALFA'] = List<Form Field Junction>
         */
        try{
            for(Form_Field_Junction__c formFieldJunction: servicesInfo){
                key = formFieldJunction.Form_Field__r.Source_System__c;
                tempServiceKey = formFieldJunction.Form_Field__r.Source_System__c +':'+ formFieldJunction.Form_Field__r.Service_Level__c +':'+ formFieldJunction.Form_Field__r.Form_Service__r.Name;
                serviceOrder = (formFieldJunction.Form_Field__r.Service_Level__c != null?formFieldJunction.Form_Field__r.Service_Level__c : '0');
                formFieldsList.add(formFieldJunction.Form_Field__r);
                if(sourceSystemServiceMap.containsKey(formFieldJunction.Form_Field__r.Source_System__c)){
                    if(!tempSourceAndServiceMap.containsKey(tempServiceKey)){
                        sourceSystemServiceMap.get(formFieldJunction.Form_Field__r.Source_System__c).add(formFieldJunction.Form_Field__r.Form_Service__r.Name.toLowerCase());
                        tempSourceAndServiceMap.put(tempServiceKey, '');
                    }
                } else {
                    sourceSystemServiceMap.put(formFieldJunction.Form_Field__r.Source_System__c, new Set<String>{formFieldJunction.Form_Field__r.Form_Service__r.Name.toLowerCase()});
                    tempSourceAndServiceMap.put(tempServiceKey, '');
                }
            }
            serviceConfigList = new Forms_DataSelector().getServiceConfigList(formFieldsList); 
            

            /*
                 Iterating ServiceConfigList to construct map with 
                 key as Service Provider and value ad list of serviceconfigs
                 Ex: sourceSystemServiceConfigMap['ALFA'] = List<Request Service config> 
                 and
                 constructing serviceResponseConfigMap to identify list of 
                 response service configs.
                 Ex: serviceResponseConfigMap[Service Name] = List<Response Service Config>       
             */

            for(FormServiceConfig__c serviceConfig: serviceConfigList){
                key = serviceConfig.FormService__r.ServiceProvider__c;
                if(serviceConfig.FormService__c != NULL && serviceConfig.FormService__r.Name != null && serviceConfig.AttributeType__c == 'Request'){
                    if(sourceSystemServiceConfigMap.containsKey(key)){
                        sourceSystemServiceConfigMap.get(key).add(serviceConfig);
                    } else {
                        sourceSystemServiceConfigMap.put(key, new List<FormServiceConfig__c>{serviceConfig});
                    }     
                    if(!serviceNameIdMap.containsKey(serviceConfig.FormService__r.Name.toLowerCase())){
                        serviceNameIdMap.put(serviceConfig.FormService__r.Name.toLowerCase(), serviceConfig.FormService__r.Id);   
                    }
                    if(serviceRequestConfigMap.containsKey(key)){
                        if(serviceRequestConfigMap.get(key).containsKey(serviceConfig.FormService__r.Name.toLowerCase())){
                            serviceRequestConfigMap.get(key).get(serviceConfig.FormService__r.Name.toLowerCase()).add(serviceConfig);                     
                        } else {
                            serviceRequestConfigMap.get(key).put(serviceConfig.FormService__r.Name.toLowerCase(), new List<FormServiceConfig__c>{serviceConfig});
                        }
                    } else {
                        serviceRequestConfigMap.put(key, new Map<String, List<FormServiceConfig__c>>{serviceConfig.FormService__r.Name.toLowerCase() => new List<FormServiceConfig__c>{serviceConfig}});
                    }
                    //Pranav - removed hard coded value and included RESPONSE from Froms_constant class
                } else if(serviceConfig.FormService__c != NULL && serviceConfig.FormService__r.Name != null && serviceConfig.AttributeType__c == Forms_Constant.RESPONSE){
                    if(serviceResponseConfigMap.containsKey(key)){
                        if(serviceResponseConfigMap.get(key).containsKey(serviceConfig.FormService__r.Name.toLowerCase())){
                            serviceResponseConfigMap.get(key).get(serviceConfig.FormService__r.Name.toLowerCase()).add(serviceConfig);                     
                        } else {
                            serviceResponseConfigMap.get(key).put(serviceConfig.FormService__r.Name.toLowerCase(), new List<FormServiceConfig__c>{serviceConfig});
                        }
                    } else {
                        serviceResponseConfigMap.put(key, new Map<String, List<FormServiceConfig__c>>{serviceConfig.FormService__r.Name.toLowerCase() => new List<FormServiceConfig__c>{serviceConfig}});
                    }
                } 
                serviceIdList.add(serviceConfig.FormService__r.Id); 
                serviceNamesList.add(serviceConfig.FormService__r.Name);  
            }

            system.debug('Forms_WebServiceExecutor::executeWebServices::Service Id List:::'+json.serialize(serviceIdList));
            //Map<String,Attachment> serviceIdAttachmentMap=new Forms_XMLBuilder().getAttachments(serviceIdList);
            serviceIdAttachmentMap = new Forms_DataSelector().getAttachments(serviceIdList);
            endPointMap = new Forms_DataSelector().getEndPointUrls(serviceNamesList);
            List<FromServices__c> services = new Forms_DataSelector().getServicesInfo(serviceIdList);
            // add additional service name if same service needs to run multiple times
            String multiServices='';
            for(FromServices__c formService: services){
                if(formService.MultiNode__c==true){
                   multiServices = multiServices+formService.name+',';
                }
            }
            multiServices = multiServices.toLowerCase();
            system.debug('Forms_WebServiceExecutor::executeWebServices::multiServices '+multiServices);

            /*
                 1.Iterating sourceSystemServiceConfigMap to call the 
                 external system one by one.
                 2.Getting Services to be called based on the Source System
                 3.We have Service Id as Key and Request xml template as value in 
                 serviceIdAttachmentMap.
                     3.1) Get the XML from attachment and pass it to generateXML
                         method to generate xml request.
                 4.We have method to return dummy response, it will return the xml.
                     In realtime we will do callout and get response.
                 5. Parsing the responsexml and converting it to Map
                 6. Adding response value to inputMap which we recieved as input.
                    Then Sending it back to Requestor.
             */
           // System.debug('source system service map'+sourceSystemServiceMap);
            for(String sourceSystem : sourceSystemServiceMap.keySet()){
                Set<String> serviceList = sourceSystemServiceMap.get(sourceSystem);
                system.debug('Forms_WebServiceExecutor::executeWebServices::Services in Order '+json.serialize(serviceList));
                for(String serviceName : serviceList){
                    system.debug('Forms_WebServiceExecutor::executeWebServices::Service Name is '+serviceName);
                    endPoint = '';
                    
                    if(serviceName != null && endPointMap.containsKey(serviceName.toLowerCase()) && endPointMap.get(serviceName.toLowerCase()) != null){
                        endPoint = endPointMap.get(serviceName.toLowerCase());
                    }
                    if(endPoint != ''){
                        inputXMLString = '';
                        if(serviceName != null && serviceNameIdMap.containsKey(serviceName) && serviceIdAttachmentMap.containsKey(serviceNameIdMap.get(serviceName))){
                            inputXMLString = serviceIdAttachmentMap.get(serviceNameIdMap.get(serviceName)).Body.toString();
                        }
                        system.debug(':::inputXMLString:::'+inputXMLString);
                        xmlString = '';                        
                        if(inputXMLString != '' && serviceRequestConfigMap.containsKey(sourceSystem) && serviceRequestConfigMap.get(sourceSystem).containsKey(serviceName)){
                            //system.debug('::One::');
                            system.debug(inputXMLString+':'+ inputMap+':'+ responseDataMap+':'+ serviceRequestConfigMap.get(sourceSystem).get(serviceName));
                            // if there is a need to run service for multiple times in a loop do some extract activity to break string and pass only first one
                            system.debug('multi service'+multiServices+':'+serviceName);
                            if(multiServices.indexOf(serviceName)!=-1){
                                //System.debug('service information'+serviceRequestConfigMap.get(sourceSystem).get(serviceName));
                                List<FormServiceConfig__c> formServiceConfig = serviceRequestConfigMap.get(sourceSystem).get(serviceName);
                                xmlStringList = Forms_XMLBuilder.generateXML(inputXMLString, inputMap, responseDataMap, serviceRequestConfigMap.get(sourceSystem).get(serviceName),true);
                            }else{
                               xmlString = Forms_XMLBuilder.generateXML(inputXMLString, inputMap, responseDataMap, serviceRequestConfigMap.get(sourceSystem).get(serviceName));
                            }

                        }
                        method = 'POST';
                        String calloutType = Forms_Constant.DEVELOPMENT;
                        if(String.isNotBlank(endPoint) && !endPoint.contains('salesforce.com')){
                            calloutType = Forms_Constant.LIVE; 
                            //Remove before Deploy
                         
                       }
                        System.debug('end point'+endPoint+':'+calloutType);    
                        //RequestType requestTypes = RequestType.DEVELOPMENT;
                        serviceNameRequestMap.put(serviceName, xmlString);
                        serviceNameSystemMap.put(serviceName, sourceSystem);
                        response = null;
                        // system.debug('::response::'+response);
                        System.debug('Forms_WebServiceExecutor::executeWebServices::Service Name::::'+serviceName+'::request xml'+xmlString);
                        if(multiServices.indexOf(serviceName)!=-1){
                            for(String reqXml : xmlStringList){
                                response = new Forms_CalloutHandler().makeCallout(endPoint, method, reqXml, calloutType);
                                validateResponseXML(response, sourceSystem,serviceName, serviceResponseConfigMap,inputMap,true);    
                            }
                        }
                         else{
                            response = new Forms_CalloutHandler().makeCallout(endPoint, method, xmlString, calloutType);
                            validateResponseXML(response,sourceSystem,serviceName, serviceResponseConfigMap,inputMap,false);
                        }
                        system.debug('Forms_WebServiceExecutor::executeWebServices::Service Name::::'+serviceName+'::StatusCode'+response);
                               
                    }
                }
            }
        }
         catch(Exception e){     
            system.debug('Forms_WebServiceExecutor::executeWebServices::executeWebServices Exception::'+e.getMessage()+':::'+e.getStackTraceString()+':::'+e.getLineNumber()+':::'+e.getCause());
            If(e instanceOf Forms_ServiceException){
                Throw e;
            }else{
                Throw new Forms_InternalException();
            }
        } 
        Forms_Utils.executionTime(startDate,system.now(),'Forms_WebServiceExecutor','executeWebServices');


    }  
    
    public void  validateResponseXML(HttpResponse response, String sourceSystem,String serviceName, Map<String, Map<String, List<FormServiceConfig__c>>> serviceResponseConfigMap, Map<String, String> inputMap,boolean isMulti){
        String responseXML = '';
        Map<String, String> tempResponseMap = new Map<String, String>();
        if(response != null && response.getStatusCode() == 200){
                            responseXML = response.getBody();
                            system.debug('Forms_WebServiceExecutor:: Live Response:::'+responseXML);
                            /****REMOVE before deploy******/
                            /*if(responseXML.contains('soapenv:Fault')){
                            system.debug('::Fault Found:::');
                            calloutType = Forms_Constant.DEVELOPMENT;
                            endPoint = 'https://salesforce.com/'+serviceName;
                            response = new Forms_CalloutHandler().makeCallout(endPoint, method, xmlString, calloutType);
                            if(response != null && response.getStatusCode() == 200){
                                responseXML = response.getBody();
                            } else {
                                //throw new Forms_ServiceException();
                            }
                            system.debug('Forms_WebServiceExecutor::executeWebServices::Service Name:Callout Type:'+calloutType+':::'+serviceName+'::StatusCode'+response.getStatusCode());
                        }*/
                            /***********/
                        }

                        system.debug('Forms_WebServiceExecutor::executeWebServices::Service Name:: response xml'+responseXML);  
                        System.debug('service response condig map'+serviceResponseConfigMap);
                        if(responseXML != '' && serviceResponseConfigMap.containsKey(sourceSystem) && serviceResponseConfigMap.get(sourceSystem).containsKey(serviceName)){
                                                    
                            tempResponseMap = Forms_XMLBuilder.parseXML(responseXML, serviceResponseConfigMap.get(sourceSystem).get(serviceName));
                            for(String responseKey : tempResponseMap.keySet()){
                                responseDataMap.put(responseKey, tempResponseMap.get(responseKey));
                                if(isMulti)
                                 inputMap.put(responseKey, tempResponseMap.get(responseKey));
                                else if(!inputMap.containsKey(responseKey))
                                {
                                    inputMap.put(responseKey, tempResponseMap.get(responseKey));
                                }
                            }
                            serviceNameResponseMap.put(serviceName, responseXML);                          
                        
            futureServiceNameReqMap = serviceNameRequestMap;
            futureServiceNameRespMap = serviceNameResponseMap;
            futureServiceNameSysMap = serviceNameSystemMap;

    }
    }

}