/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_DataSelectorTest> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <11/02/2015> 
Last Modified by......: <thenmozhi>
Last Modified Date....: <11/27/2015 >
Description...........: <This test class has been written for Forms_DataSelector to quering metadata .it is used to collect external and internal data>

Change Request History:
thenmozhi       27/11/2015   Added comments in header and methods
##########################################################################################
 */
@isTest 
private class Forms_DataSelectorTest {
    public static String loadQuoteXML;
    /*
      Method Name: recordsCreation
      Method Signature/Inputs:Forms_TestDataUtil.insertForm('2000');
      Method Return Type/outputs: Inserting records
      Method Description:This method is used to insert test data for the desired object
     */
    static testmethod void recordsCreation(){
        Form__c form = Forms_TestDataUtil.insertForm('2000');
        Forms_TestDataUtil.insertFormFieldsForRequest();
        Forms_TestDataUtil.insertFormFieldsForALFAandSFDC();
    }
    /*
      Method Name: getFieldsForValidationSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field__c> formFields
      Method Description:This method is used cover the querying metadata with test records
                         for Success scenario
      */
    static testmethod void getFieldsForValidationSuccess(){
        recordsCreation();
        //Forms_DataSelector formsdataselector = new Forms_DataSelector();
        List<Form_Field__c> formFields = Forms_DataSelector.getFieldsForValidation('2000');//TC_111
        system.assertNotEquals(formFields.size(), 0);
    }
    /*
      Method Name: getFieldsForValidationEmptyFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field__c> formFields
      Method Description:This method is used cover the querying metadata with test records
                         for Empty scenario
      */
    static testmethod void getFieldsForValidationEmptyFormIdError(){
        recordsCreation();
        List<Form_Field__c> formFields = Forms_DataSelector.getFieldsForValidation('');//TC_112
        system.assertEquals(formFields.size(), 0);
    }
    /*
      Method Name: getFieldsForValidationEmptyFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field__c> formFields
      Method Description:This method is used cover the querying metadata with test records
                         for Invalid scenario
      */
    static testmethod void getFieldsForValidationWrongFormIdError(){
        recordsCreation();
        List<Form_Field__c> formFields = Forms_DataSelector.getFieldsForValidation('2001');//TC_113
        system.assertEquals(formFields.size(), 0);
    } 
    
   /*
      Method Name: getServiceListSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for success scenario
      */
    static testmethod void getServiceListSuccess(){
        recordsCreation();
        List<Form_Field_Junction__c> formFieldJunctionList = new Forms_DataSelector().getServiceList('2000');//TC_114
        system.assertNotEquals(formFieldJunctionList.size(), 0);
    }
       /*
      Method Name: getServiceListEmptyFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Empty scenario
      */
    static testmethod void getServiceListEmptyFormIdError(){
        recordsCreation();
        List<Form_Field_Junction__c> formFieldJunctionList = new Forms_DataSelector().getServiceList('');//TC_115
        system.assertEquals(formFieldJunctionList.size(), 0);
    }
    /*
      Method Name: getServiceListWrongFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Invalid scenario
      */
    static testmethod void getServiceListWrongFormIdError(){
        recordsCreation();
        List<Form_Field_Junction__c> formFieldJunctionList = new Forms_DataSelector().getServiceList('2001');//TC_116
        system.assertEquals(formFieldJunctionList.size(), 0);
    }   
     
    /*
      Method Name: getInternalFieldsListSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for success scenario
      */
    static testmethod void getInternalFieldsListSuccess(){
        recordsCreation();
        Forms_DataSelector formsselector = new Forms_DataSelector();
        List<Form_Field_Junction__c> formFieldJunctionList = formsselector.getInternalFieldsList('2000');//TC_117
        system.assertNotEquals(formFieldJunctionList.size(), 0);
    }
     /*
      Method Name: getInternalFieldsListEmptyFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Empty scenario
      */
    static testmethod void getInternalFieldsListEmptyFormIdError(){
        recordsCreation();
        List<Form_Field_Junction__c> formFieldJunctionList = new Forms_DataSelector().getInternalFieldsList('');//TC_118
        system.assertEquals(formFieldJunctionList.size(), 0);
    }
    /*
      Method Name: getInternalFieldsListWrongFormIdError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Invalid scenario
      */
    static testmethod void getInternalFieldsListWrongFormIdError(){
        recordsCreation();
        List<Form_Field_Junction__c> formFieldJunctionList = new Forms_DataSelector().getInternalFieldsList('2001');//TC_119
        system.assertEquals(formFieldJunctionList.size(), 0);
    }  
    
     /*
      Method Name: getServiceConfigListSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<FormServiceConfig__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Success scenario
      */
    static testmethod void getServiceConfigListSuccess(){
        recordsCreation();
        List<Form_Field__c> formFields = new List<Form_Field__c>();
        List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList('2000');//TC_120
        for(Form_Field_Junction__c formFieldJunction: serviceList){
            formFields.add(formFieldJunction.Form_Field__r);
        }
        List<FormServiceConfig__c> formServiceConfigList = new Forms_DataSelector().getServiceConfigList(formFields);
        system.assertNotEquals(formServiceConfigList.size(), 0);
    }
    /*
      Method Name: getServiceConfigListEmptyListError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: List<Form_Field_Junction__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Empty scenario
      */
    static testmethod void getServiceConfigListEmptyListError(){
        recordsCreation();
        List<Form_Field__c> formFields = new List<Form_Field__c>();
        List<FormServiceConfig__c> formServiceConfigList = new Forms_DataSelector().getServiceConfigList(formFields);//TC_121
        system.assertEquals(formServiceConfigList.size(), 0);
    }
    /*
      Method Name: getAttachmentsSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String,Attachment> 
      Method Description:This method is used cover the querying metadata with test records
                         for Success scenario
      */
     static testmethod void getAttachmentsSuccess(){
        recordsCreation();
        List<String> serviceIdList = new List<String>();
        List<Form_Field__c> formFields = new List<Form_Field__c>();
        List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList('2000');
        for(Form_Field_Junction__c formFieldJunction: serviceList){
            formFields.add(formFieldJunction.Form_Field__r);
        }
        //system.debug('::FormFields::'+json.serialize(formFields));
        List<FormServiceConfig__c> serviceConfigList = new Forms_DataSelector().getServiceConfigList(formFields);
        for(FormServiceConfig__c FormService: serviceConfigList){
            serviceIdList.add(FormService.FormService__r.Id); 
        }
        Map<String,Attachment> attachmentMap = new Forms_DataSelector().getAttachments(serviceIdList);
        system.assertNotEquals(attachmentMap.size(), 0);
    }
     /*
      Method Name: getAttachmentsEmptyListError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String,Attachment> 
      Method Description:This method is used cover the querying metadata with test records
                         for Empty scenario
      */
    static testmethod void getAttachmentsEmptyListError(){
        recordsCreation();
        List<String> serviceIdList = new List<String>();
        Map<String,Attachment> attachmentMap = new Forms_DataSelector().getAttachments(serviceIdList);
        system.assertEquals(attachmentMap.size(), 0);
    }   
    /*
      Method Name: getQueryConfigRecordsSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String,Forms_QueryConfig__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for success scenario for SFDC data
      */
    static testmethod void getQueryConfigRecordsSuccess(){
        recordsCreation();
        List<Id> queryConfigIdList = new List<Id>();
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        List<Form_Field_Junction__c> internalObjectFields = new Forms_DataSelector().getInternalFieldsList('2000'); 
        for(Form_Field_Junction__c formFieldJunction :internalObjectFields ){
            if(formFieldJunction.Form_Field__r.Forms_QueryConfig__c != null)
            queryConfigIdList.add(formFieldJunction.Form_Field__r.Forms_QueryConfig__c);    
        }
        Map<String,Forms_QueryConfig__c> queryConfigMap = new Forms_DataSelector().getQueryConfigRecords(queryConfigIdList);
        system.assertNotEquals(queryConfigMap.size(), 0);
    }
    /*
      Method Name: getQueryConfigRecordsEmptyListError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String,Forms_QueryConfig__c> 
      Method Description:This method is used cover the querying metadata with test records
                         for Failure scenario for SFDC data
      */
    static testmethod void getQueryConfigRecordsEmptyListError(){
        recordsCreation();
        List<Id> queryConfigIdList = new List<Id>();
        Map<String,Forms_QueryConfig__c> queryConfigMap = new Forms_DataSelector().getQueryConfigRecords(queryConfigIdList);
        system.assertEquals(queryConfigMap.size(), 0);
    }

    /*
      Method Name: getEndPointUrlsSuccess
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String, String> 
      Method Description:This method is used cover the querying metadata with test records
                         for success scenario for Endpoint URL data
      */
    static testmethod void getEndPointUrlsSuccess(){
        recordsCreation();
        Forms_TestDataUtil.insertEndPoints();
        List<String> serviceNameList = new List<String>();
        List<Form_Field__c> formFields = new List<Form_Field__c>();
        List<Form_Field_Junction__c> serviceList = new Forms_DataSelector().getServiceList('2000');
        for(Form_Field_Junction__c formFieldJunction: serviceList){
            formFields.add(formFieldJunction.Form_Field__r);
        }
        List<FormServiceConfig__c> serviceConfigList = new Forms_DataSelector().getServiceConfigList(formFields);
        for(FormServiceConfig__c FormService: serviceConfigList){
            serviceNameList.add(FormService.FormService__r.Name); 
        }
        Map<String, String> endPointMap = new Forms_DataSelector().getEndPointUrls(serviceNameList);
        system.assertNotEquals(endPointMap.size(), 0);
    }
    /*
      Method Name: getEndPointUrlsEmptyListError
      Method Signature/Inputs:recordsCreation()
      Method Return Type/outputs: Map<String, String> 
      Method Description:This method is used cover the querying metadata with test records
                         for empty scenario for Endpoint URL data
      */
    static testmethod void getEndPointUrlsEmptyListError(){
        recordsCreation();
        Forms_TestDataUtil.insertEndPoints();
        List<String> serviceNameList = new List<String>();
        Map<String, String> endPointMap = new Forms_DataSelector().getEndPointUrls(serviceNameList);
        system.assertEquals(endPointMap.size(), 0);
    }
    
    /*
      Method Name: getConfiguredFields
      Method Signature/Inputs:String formID
      Method Return Type/outputs: List<Form_Field_Junction__c>
      Method Description:This Method is used to query data from Form_Field_Junction__c
   */
     static testmethod void getConfiguredFields(){
     List<Form_Field_Junction__c> formfieldslist = Forms_DataSelector.getConfiguredFields('2000');
     Forms_DataSelector.getAdobeServiceEndPoint();
     }
       
     /*
      Method Name: getLogicConfigurationTest
      Method Signature/Inputs:List<id> logicConfigList
      Method Return Type/outputs: List<Forms_LogicConfiguration__c>
      Method Description:This Method is used to query data from Form_Field_Junction__c
   */
     static testmethod void getLogicConfigurationTest(){
     List<id> logicConfigList = new List<id>();
     //logicConfigList.add('a20123');
     List<Forms_LogicConfiguration__c> formslogic = Forms_DataSelector.getLogicConfiguration(logicConfigList);
     }
     /*
      Method Name: getFormInformationTest
      Method Signature/Inputs:String formNumber
      Method Return Type/outputs: Form__c
      Method Description:This Method is used to query data from Form_Field_Junction__c
   */
     static testmethod void getFormInformationTest(){
     Form__c formObj = new Form__c();
     formObj.certifiedmail__c = TRUE;
     formObj.Form_Number__c = '2000';
     formObj.NumberOfCopies__c=1;
     insert formObj;
     formObj = Forms_DataSelector.getFormInformation('2000');
     
     }
 }