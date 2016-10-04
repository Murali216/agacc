/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DataValidatorTest
Version...............: 1.0
Created by............: Charitha_Seelam,Kaavya_Kanna,Pranav_Prasun,Geetha_muthukuru
Created Date..........: 10/08/2015 
Last Modified by......: Charitha_Seelam
Last Modified Date....: 11/26/2015
Description...........: Test Class to test the Forms_DataValidator methods

Change Request History:
##########################################################################################
*/


@isTest
Public class Forms_DataValidatorTest
{ 
    Static testmethod void test_ValidateFormReqData()
    {
        Forms_TestDataUtil.insertForms_ErrorMessages();
        Forms_TestDataUtil.insertForm('4201');
        Forms_TestDataUtil.insertFormFieldsForRequest();
        Form_Request__c formReq = Forms_TestDataUtil.getValidFormRequest('4201');
        Form_Request__c invalidFormReq =  Forms_TestDataUtil.getInvalidFormRequest('4201');   
        List<Form_Request_Line_Item__c> lineItems = Forms_TestDataUtil.getValidFormReqLineItems();
        List<Form_Request_Line_Item__c> lineItems1 = Forms_TestDataUtil.getFormReqLineItems();
        
        Forms_DataValidator dataValidator = new Forms_DataValidator('4201');
        Forms_Validation_Result__c validationResult = new Forms_Validation_Result__c();
        
        Forms_DataValidator dataValidator1 = new Forms_DataValidator('4201');
        Forms_Validation_Result__c validationResult1 = new Forms_Validation_Result__c();
        
        Forms_DataValidator dataValidator2 = new Forms_DataValidator('4201');
        Forms_Validation_Result__c validationResult2 = new Forms_Validation_Result__c();
                
        test.starttest();
             
        validationResult  = dataValidator.validateData(formReq,lineItems);//TC_014
        System.assertNotEquals(validationResult.status__c,Forms_constant.SUCCESS);
        validationResult1 = dataValidator.validateData(invalidFormReq,lineItems1);//TC_012
        System.assertEquals(validationResult1.status__c,Forms_constant.FAILURE);
        validationResult2 = datavalidator.validatedata(formReq,null);//TC_013
        System.assertEquals(validationResult2.status__c,Forms_constant.FAILURE);        
        test.stoptest();
        
        
        system.debug('*********Validation Result'+validationResult);       
        system.debug('*********Validation Result Message '+validationResult.ErrorMessage__c);  
         
    }
    
    Static testmethod void test_ValidateFormDataInvalid()
    {
        Forms_TestDataUtil.insertForms_ErrorMessages();        
        Form_Request__c formReq;//TC_011,TC_012     
        List<Form_Request_Line_Item__c> lineItems;//TC_011,TC_013     
                        
        Forms_DataValidator dataValidator = new Forms_DataValidator('4201');
        Forms_Validation_Result__c validationResult = new Forms_Validation_Result__c();
        Forms_DataValidator dataValidator1 = new Forms_DataValidator('4000');
        Forms_Validation_Result__c validationResult1 = new Forms_Validation_Result__c();
        
        test.starttest();       
        validationResult  = dataValidator.validateData(formReq,lineItems);
        System.assertEquals(validationResult.status__c,Forms_constant.FAILURE); 
        validationResult1  = dataValidator1.validateData(formReq,lineItems);
        System.assertEquals(validationResult1.status__c,Forms_constant.FAILURE); 
        test.stoptest();
        
        system.debug('*********Validation Result Invalid'+validationResult);       
        system.debug('*********Validation Result Message '+validationResult.ErrorMessage__c);  
         
    } 
    
    static testmethod void test_validateDocument()
    {               
        Forms_TestDataUtil.insertForms_ErrorMessages();
        Form__c formObj = Forms_TestDataUtil.insertForm('4201');
        Forms_TestDataUtil.insertFormFieldsForResponse();
        List<Document_Request_Line_Item__c> lineItems = new List<Document_Request_Line_Item__c>();
        
        
        Document_Request__c docRequest = Forms_TestDataUtil.getDocumentRequest('4201');       
        Document_Request__c invalidDocReq = Forms_TestDataUtil.getInvalidDocReq('4201');
        
        Document_Request_Line_Item__c docReqLineItem = Forms_TestDataUtil.getDocREqLineItem(docRequest);
        lineItems.add(docReqLineItem);
        Forms_Validation_Result__c validationResult = new Forms_Validation_Result__c();       
        Forms_DataValidator dataValidator = new Forms_DataValidator('4201');
        
        Forms_Validation_Result__c validationResult1 = new Forms_Validation_Result__c();       
        Forms_DataValidator dataValidator1 = new Forms_DataValidator('4201');
        
        Forms_Validation_Result__c validationResult2 = new Forms_Validation_Result__c();       
        Forms_DataValidator dataValidator2 = new Forms_DataValidator('4201');
        
        Forms_Validation_Result__c validationResult3 = new Forms_Validation_Result__c();       
        Forms_DataValidator dataValidator3 = new Forms_DataValidator('4201');
        
        test.starttest(); 
        
        validationResult = dataValidator.validateDocumentData(docRequest,lineItems);//TC_036
        System.assertEquals(validationResult.status__c,Forms_constant.SUCCESS);             
        system.debug('*********Validation Result'+validationResult);       
        system.debug('*********Validation Result Message '+validationResult.ErrorMessage__c);

        validationResult1 = dataValidator1.validateDocumentData(invalidDocReq,lineItems);//TC_034
        System.assertEquals(validationResult1.status__c,Forms_constant.FAILURE);                
        system.debug('*********Validation Result1'+validationResult1);       
        system.debug('*********Validation Result1 Message '+validationResult1.ErrorMessage__c); 
        
        validationResult2 = dataValidator2.validateDocumentData(docRequest,null);//TC_35
        System.assertEquals(validationResult2.status__c,Forms_constant.FAILURE);                
        system.debug('*********Validation Result2'+validationResult2);       
        system.debug('*********Validation Result2 Message '+validationResult2.ErrorMessage__c); 
        
        try{
            //FormField to raise Exception in DataValidator class.
            Form_Field__c formFieldObj7= new Form_Field__c();
            formFieldObj7.Name='customSTring';
            formFieldObj7.Target_Field__c='CustomString4__c';
            formFieldObj7.Data_Type__c = 'Dummy';            
            formFieldObj7.source_system__c='ALFA';
            insert formFieldObj7;
            
            Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
            formFieldJunction.Form__c = formobj.Id;
            formFieldJunction.Form_Field__c = formFieldObj7.Id;
            formFieldJunction.required__c =true;
            insert formFieldJunction;
            docRequest.CustomString4__c = 'testCode';
            Forms_DataValidator dataValidator4 = new Forms_DataValidator('4201');
            validationResult3 = dataValidator4.validateDocumentData(docRequest,lineItems);
        }
        catch(Exception e)
        {
            System.debug('Error In TestClass'+e.getMessage());
            
        }
        Forms_DataValidator dataValidator5 = new Forms_DataValidator('4201');
        validationResult3 = dataValidator5.validateDocumentData(null,null); //TC_033
        //System.assertEquals(validationResult2.status__c,Forms_constant.FAILURE); 
        test.stoptest();
                        
    }        
   
    
}