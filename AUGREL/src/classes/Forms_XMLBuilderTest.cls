/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_XMLBuilderTest> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <11/28/2015> 
Last Modified by......: <Muthu>
Last Modified Date....: <11/28/2015 >
Description...........: <This test class has been written for covering generating request XML and parse response XML into Map to send requester system>

Change Request History:
muthu        28/11/2015   updated test class for multiple node code coverage 
Thenmozhi    30/11/2015   adding comments in header and methods
##########################################################################################
 */
@isTest
private class Forms_XMLBuilderTest{
    /*
      Method Name: createrecords
      Method Signature/Inputs:String formNumber
      Method Return Type/outputs: insertForm
      Method Description:This method is used to insert records in form based on form id
    */
    static void createrecords(String formNumber){
        Form__c form = Forms_TestDataUtil.insertForm(formNumber);
        Forms_TestDataUtil.insertFormFieldsForRequest();
        Forms_TestDataUtil.insertFormFieldsForALFAandSFDC();
        
    }
    /*
      Method Name: generateXMLTest
      Method Signature/Inputs:createrecords
      Method Return Type/outputs: dataMap
      Method Description:This method is used to cover test data for generateXML Success Scenario
     */
    static testMethod void generateXMLTest(){
        createrecords('5000');
        Map<String, String > inputMap = new Map<String, String>();
        inputMap.put('formid', '5000');
        inputMap.put('assetidentifier', '5000');
        List<String> serviceNameList = new List<String>();
        List<String> serviceIdList = new List<String>();
        List<Form_Field__c> formFieldList = new List<Form_Field__c>();
        List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList('5000');
        Map<String, String> attachmentMap = new Map<String, String>();
        Map<String, List<FormServiceConfig__c>> serviceConfigMap = new Map<String, List<FormServiceConfig__c>>();
        Map<String, String> dataMap = new Map<String, String>();
        dataMap.put('v1:make','2015');
        for(Form_Field_Junction__c formFieldJunction : serviceList){
            serviceNameList.add(formFieldJunction.Form_Field__r.Form_Service__r.Name);
            serviceIdList.add(formFieldJunction.Form_Field__r.Form_Service__r.Id);
            formFieldList.add(formFieldJunction.Form_Field__r);
        }
        for(FormServiceConfig__c formServiceConfig : new Forms_DataSelector().getServiceConfigList(formFieldList)){
            if(formServiceConfig.AttributeType__c == 'Request'){
                if(serviceConfigMap.containsKey(formServiceConfig.FormService__r.Id)){
                    serviceConfigMap.get(formServiceConfig.FormService__r.Id).add(formServiceConfig);
                } else {
                    serviceConfigMap.put(formServiceConfig.FormService__r.Id, new List<FormServiceConfig__c>{formServiceConfig});
                }
            }
        }
        for(Attachment att : [SELECT Id, Body, ParentId FROM Attachment 
            WHERE ParentId IN :serviceIdList AND Name = 'request.xml' ]){
            attachmentMap.put(att.ParentId, att.Body.toString());
        }
        for(String formServiceId : serviceIdList){
            Forms_XMLBuilder.generateXML(attachmentMap.get(formServiceId), inputMap, dataMap, serviceConfigMap.get(formServiceId));
        }
        //Forms_XMLBuilderTest.generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList);
        
    }
    /*
      Method Name: generateXMLTestForEmptyXML
      Method Signature/Inputs:
      Method Return Type/outputs: 
      Method Description:This method is used to test EMPTY XML data
    */
    static testMethod void generateXMLTestForEmptyXML(){
        String inputXML;
        Map<String, String> inputMap = new Map<String, String>();
        Map<String, String> dataMap = new Map<String, String>();
        List<FormServiceConfig__c> serviceConfigList = new List<FormServiceConfig__c>();
        Forms_XMLBuilder.generateXML(inputXML, inputMap, dataMap, serviceConfigList);
    }
     /*
      Method Name: generateXMLTestForEmptyXML
      Method Signature/Inputs:
      Method Return Type/outputs: 
      Method Description:This method is used to test EMPTY InputMap
      */
    static testMethod void generateXMLTestForEmptyInputMap(){
        String inputXML = '<request></request>';
        Map<String, String> inputMap = new Map<String, String>();
        Map<String, String> dataMap = new Map<String, String>();
        List<FormServiceConfig__c> serviceConfigList = new List<FormServiceConfig__c>();
        Forms_XMLBuilder.generateXML(inputXML, inputMap, dataMap, serviceConfigList);
    }
    /*
      Method Name: generateXMLTestForEmptyDataMap
      Method Signature/Inputs:
      Method Return Type/outputs: 
      Method Description:This method is used to test EMPTY DataMap
      */
    static testMethod void generateXMLTestForEmptyDataMap(){
        String inputXML = '<request></request>';
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('formnumber', '5000');
        Map<String, String> dataMap = new Map<String, String>();
        List<FormServiceConfig__c> serviceConfigList = new List<FormServiceConfig__c>();
        Forms_XMLBuilder.generateXML(inputXML, inputMap, dataMap, serviceConfigList);
    }
    /*
      Method Name: generateXMLTestForEmptyServiceConfig
      Method Signature/Inputs:
      Method Return Type/outputs: 
      Method Description:This method is used to generateXML Test For Empty ServiceConfig
      */
    static testMethod void generateXMLTestForEmptyServiceConfig(){
        String inputXML = '<request></request>';
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('formnumber', '5000');
        Map<String, String> dataMap = new Map<String, String>();
        dataMap.put('make','2015');
        List<FormServiceConfig__c> serviceConfigList = new List<FormServiceConfig__c>();
        Forms_XMLBuilder.generateXML(inputXML, inputMap, dataMap, serviceConfigList);
    }
    
    /*
      Method Name: parseXMLTest
      Method Signature/Inputs:createrecords
      Method Return Type/outputs: responseXMLMap
      Method Description:This method is used to parseXMLTest for response map
      */
    static testMethod void parseXMLTest(){
        
        createrecords('5000');
        Map<String, String > inputMap = new Map<String, String>();
        inputMap.put('formNumber', '5000');
        inputMap.put('assetidentifier', '5000');
        List<String> serviceNameList = new List<String>();
        List<String> serviceIdList = new List<String>();
        List<Form_Field__c> formFieldList = new List<Form_Field__c>();
        List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList('5000');
        
        Map<String, String> attachmentMap = new Map<String, String>();
        Map<String, List<FormServiceConfig__c>> serviceConfigMap = new Map<String, List<FormServiceConfig__c>>();
        Map<String, String> responseXMLMap = new Map<String, String>();
        
        System.debug('size of service List : '+serviceList.size());
        for(Form_Field_Junction__c formFieldJunction : serviceList){
            serviceNameList.add(formFieldJunction.Form_Field__r.Form_Service__r.Name);
            serviceIdList.add(formFieldJunction.Form_Field__r.Form_Service__r.Id);
            formFieldList.add(formFieldJunction.Form_Field__r);
        }
        for(FormServiceConfig__c formServiceConfig : new Forms_DataSelector().getServiceConfigList(formFieldList)){
            if(formServiceConfig.AttributeType__c == 'Response'){
                if(serviceConfigMap.containsKey(formServiceConfig.FormService__r.Name)){
                    serviceConfigMap.get(formServiceConfig.FormService__r.Name).add(formServiceConfig);
                } else {
                    serviceConfigMap.put(formServiceConfig.FormService__r.Name, new List<FormServiceConfig__c>{formServiceConfig});
                }
            }
        }
        String loadQuoteResponse = '<vehicle>'+
                            '<assetidentifier>4000001</assetidentifier>'+
                            '</vehicle>';
        String loadAssetResponse = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >'+
                                +'<soapenv:Body>'+
                                +'<sec:vehicle xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:sec="http://ws.chpconsulting.com/alfa/agreement/v1/security">'+
                                +'<v1:assetidentifier>4000001</v1:assetidentifier>'+
                                +'<v1:make>2001</v1:make>'+
                                +'<v1:model>Etios</v1:model>'+
                                +'<v1:year>2015</v1:year>'+
                                +'<v1:variants>'+
                                +'<v1:variant><v1:name>MX</v1:name></v1:variant>'+
                                +'<v1:variant><v1:name>LX</v1:name></v1:variant>'+
                                +'</v1:variants>'+
                                +'</sec:vehicle>'+
                                +'</soapenv:Body></soapenv:Envelope>';
                                
                            
        responseXMLMap.put('TerminationQuoteService.loadQuote', loadQuoteResponse);
        responseXMLMap.put('AssetService.loadAsset', loadAssetResponse);
        for(String formServiceName : serviceNameList){
            Forms_XMLBuilder.parseXML(responseXMLMap.get(formServiceName), serviceConfigMap.get(formServiceName));
          
        }
               
       //Forms_XMLBuilderTest.generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList);
        
    }
    /*
      Method Name: parseXMLEmptyXMLTest
      Method Signature/Inputs:createrecords
      Method Return Type/outputs: responseXMLMap
      Method Description:This method is used to parseXMLTest for empty response map
      */
    static testMethod void parseXMLEmptyXMLTest(){
        
        createrecords('5000');
        Map<String, String > inputMap = new Map<String, String>();
        inputMap.put('formNumber', '5000');
        inputMap.put('assetidentifier', '5000');
        String inputXML;
            Forms_XMLBuilder.parseXML(inputXML, new List<FormServiceConfig__c>());
        
        //Forms_XMLBuilderTest.generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList);
        
    }
    /*
      Method Name: parseXMLEmptyServiceConfigTest
      Method Signature/Inputs:createrecords
      Method Return Type/outputs: XML
      Method Description:This method is used to parseXMLTest for empty XML map
      */
    static testMethod void parseXMLEmptyServiceConfigTest(){
        
        createrecords('5000');
        Map<String, String > inputMap = new Map<String, String>();
        inputMap.put('formNumber', '5000');
        inputMap.put('assetidentifier', '5000');
        String inputXML = '<response></response>';
            Forms_XMLBuilder.parseXML(inputXML, new List<FormServiceConfig__c>());
        
        //Forms_XMLBuilderTest.generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList);
        
    }
   
}