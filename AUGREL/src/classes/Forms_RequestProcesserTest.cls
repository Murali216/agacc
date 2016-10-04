/*
#########################################################################################
Project Name        : TFS Forms Implementation
File                : Forms_RequestProcesserTest
Version             : 1.0
Created by          : Kaavya
Created Date        : 10/06/2015 
Last Modified by    : <NAME>
Last Modified Date  : <MM/DD/YYYY>
Description         : This class is the Test class for Forms_RequestProcessorTest

Change Request History:
##########################################################################################
*/


@isTest
Public class Forms_RequestProcesserTest{

    /* Method Name : checkReqXmlGeneration  
    Method Signature/Inputs : NULL
    Method Return Type/outputs  : NULL
    Method Description : This test method is to test is successfully DMS request xml is generated or not.
    */
   public static testMethod void checkReqXmlGeneration(){
        test.startTest();
        Form__c formObj = new Form__c();
        Form_Request__c formReq = new Form_Request__c();
        formReq = Forms_TestDataUtil.getValidFormRequest('4201');
        insert formReq;

        Form_Request_Line_Item__c frmLineItem = new Form_Request_Line_Item__c();
        frmLineItem.FormAttributeKey__c = 'entitykey';
        frmLineItem.FormAttributeValue__c = '5555';

        Form_Request_Line_Item__c frmLineItem1 = new Form_Request_Line_Item__c();
        frmLineItem1.FormAttributeKey__c = 'externalid';
        frmLineItem1.FormAttributeValue__c = '4444';


        List<Form_Request_Line_Item__c> formAttributes = new List<Form_Request_Line_Item__c>();
        formAttributes.add(frmLineItem);
        formAttributes.add(frmLineItem1);
        insert formAttributes; 
        Forms_TestDataUtil.insertForms_ErrorMessages();
        formObj=Forms_TestDataUtil.insertForm('4201');
        system.assertnotequals(formObj,NULL);
        system.assertnotequals(formAttributes,NULL);
        Forms_RequestProcesser.processFormRequest(formReq,formAttributes); //TC_001,TC_002
        test.stoptest();  
    }
    
    /* Method Name : CheckNotNullFormValues
    Method Signature/Inputs : NULL
    Method Return Type/outputs  : NULL
    Method Description :  A test method to check for negative scenario when form attribute values are not null.
    */
    public static testMethod void CheckNotNullFormValues(){

        Form__c formObj = new Form__c();
        Form_Request__c formRequest = new Form_Request__c();
        Form_Request_Line_Item__c frmLineItem = new Form_Request_Line_Item__c();
        frmLineItem.FormAttributeKey__c = 'entitykey';
        frmLineItem.FormAttributeValue__c = '5555';

        Form_Request_Line_Item__c frmLineItem1 = new Form_Request_Line_Item__c();
        frmLineItem1.FormAttributeKey__c = 'externalid';
        frmLineItem1.FormAttributeValue__c = '4444';

        List<Form_Request_Line_Item__c> formAttributes = new List<Form_Request_Line_Item__c>();
        formAttributes.add(frmLineItem);
        formAttributes.add(frmLineItem1);
        insert formAttributes;

        formObj=Forms_TestDataUtil.insertForm('4201'); 
        Forms_TestDataUtil.insertForms_ErrorMessages();
        formRequest = Forms_TestDataUtil.getInvalidFormRequest('4201'); 
        insert formRequest; 
        Forms_TestDataUtil.getInvalidDocReq('4201');
        system.assertnotequals(formObj,NULL);
        system.assertnotequals(formAttributes,NULL);   

        test.startTest();
        Forms_RequestProcesser.processFormRequest(formRequest,formAttributes); //TC_003,TC_004
        //System.debug('Message in test class is:'+ mesg);
        test.stoptest();

    }
    
    /* Method Name : CheckNullFormAttributeValues
    Method Signature/Inputs : NULL
    Method Return Type/outputs  : NULL
    Method Description: A test method to check for negative scenario when form attribute values are null.
    */
    public static testMethod void CheckNullFormAttributeValues(){ 
        try{
        Form_Request__c formRequest = new Form_Request__c();
        formRequest = null; 
        Form_Request_Line_Item__c frmLineItem = new Form_Request_Line_Item__c();
        frmLineItem.FormAttributeKey__c = 'entitykey';
        frmLineItem.FormAttributeValue__c = '5555';

        Form_Request_Line_Item__c frmLineItem1 = new Form_Request_Line_Item__c();
        frmLineItem1.FormAttributeKey__c = 'externalid';
        frmLineItem1.FormAttributeValue__c = '4444';

        List<Form_Request_Line_Item__c> formAttributes = new List<Form_Request_Line_Item__c>();
        formAttributes.add(frmLineItem);
        formAttributes.add(frmLineItem1);
        Forms_TestDataUtil.insertForms_ErrorMessages();
        system.assertequals(formRequest,NULL);
        system.assertnotequals(formAttributes,NULL);   

        test.startTest();
        Forms_RequestProcesser.processFormRequest(formRequest,formAttributes); //TC_005
        //System.debug('Message in test class is:' + mesg);
        test.stoptest();
        }
        catch(Exception e){
            
        }
    }

   /* Method Name : checkProcessFormRequest
    Method Signature/Inputs : NULL 
    Method Return Type/outputs  : NULL
    Method Description: A test method to check for negative scenario when processFormRequest method is called.
    */
    public static testMethod void checkProcessFormRequest(){
        try{
        Form_Request__c formRequest = new Form_Request__c();
        formRequest = null; 
        List<Form_Request_Line_Item__c> formAttributes = new List<Form_Request_Line_Item__c>();
        formAttributes = null;      
        Forms_TestDataUtil.insertForms_ErrorMessages();
        system.assertequals(formRequest,NULL);
        system.assertequals(formAttributes,NULL);   
        test.startTest();
        Forms_RequestProcesser.processFormRequest(formRequest,formAttributes); //TC_006
        //System.debug('Message in test class is:'+ mesg);
        test.stoptest();
        }
        catch(Exception e){
            
        }
    }
}