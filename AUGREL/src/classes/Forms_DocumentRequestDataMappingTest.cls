/*
#########################################################################################
Project Name        : TFS Forms Implementation
File                : Forms_DocumentRequestDataMappingTest
Version             : <1.0>
Created by          : Kaavya
Created Date        : 19/10/2015 
Last Modified by    : <NAME>
Last Modified Date  : <MM/DD/YYYY >
Description         : This class is the Test class for Forms_DocumentRequestDataMapping

Change Request History:
##########################################################################################
*/

@isTest
Public class Forms_DocumentRequestDataMappingTest{

    /* 
    Method Name:test_docReqMapping
    Method Signature/Inputs:Responsedatamap, Documentrequest object, Forms_DocumentDataHolder.
    Method Return Type/outputs:Test Method Pass/Fail
    Method Description:This method is to cover the mappingResponseToDocReq method positive scenario.
    */
    
 Static testmethod void test_docReqMapping(){
    Map<String,String> responseDataMap1 = new Map<String,String>();
    Map<String,String> responseDataMap2 = new Map<String,String>();
    Map<String,String> DataTypeMap = new Map<String,String>();
    list <FormServiceConfig__c> formServConfigList = new list <FormServiceConfig__c>();
    Forms_TestDataUtil.insertForms_ErrorMessages();
    list <Document_Request_Line_Item__c> docReqLIList = new list <Document_Request_Line_Item__c>();  
    
    FormServiceConfig__c formServObj = new FormServiceConfig__c();
    formServObj.ReferenceAttribute__c='nameline1';
    formServObj.Link_to_Document_Request_Object__c='Recipient_NameLine1__c';
    formServObj.ParentNode__c='response';
    formServObj.AttributeType__c='Response';
    formServObj.data_type__c='String';
    formServConfigList.add(formServObj);
    
    System.assertNotEquals(formServObj,NULL);
       
    FormServiceConfig__c formServObj2 = new FormServiceConfig__c();
    formServObj2.ReferenceAttribute__c='newduedate';
    formServObj2.Link_to_Document_Request_Object__c='NewDueDate__c';
    formServObj2.AttributeType__c='Response';
    formServObj2.ParentNode__c='response';
    formServConfigList.add(formServObj2);
    System.assertNotEquals(formServObj2,NULL);
    
    FormServiceConfig__c formServObj3 = new FormServiceConfig__c();
    formServObj3.ReferenceAttribute__c='newpaymentamount';
    formServObj3.Link_to_Document_Request_Object__c='NewPaymentAmount__c';
    formServObj3.AttributeType__c='Response';
    formServObj3.ParentNode__c='response';
    formServConfigList.add(formServObj3);
    System.assertNotEquals(formServObj3,NULL);
    
    FormServiceConfig__c formServObj4 = new FormServiceConfig__c();
    formServObj4.ReferenceAttribute__c='currentduedate';
    formServObj4.Link_to_Document_Request_Object__c='CurrentDueDate__c';
    formServObj4.AttributeType__c='Response';
    formServObj4.ParentNode__c='response';
    formServConfigList.add(formServObj4);
    System.assertNotEquals(formServObj4,NULL);
    insert formservconfiglist;
    
    list<Forms_QueryConfig__c> configQueryList = new list<Forms_QueryConfig__c>();
    Forms_QueryConfig__c query = new Forms_QueryConfig__c();
    query.Name = 'test';
    query.Document_Object_Field__c = 'newduedate';
    configQueryList.add(query);
    
    Forms_QueryConfig__c query1 = new Forms_QueryConfig__c();
    Forms_QueryConfig__c query2 = new Forms_QueryConfig__c();
    Forms_QueryConfig__c query3 = new Forms_QueryConfig__c();
    
    query1.Name = 'test';
    query1.Document_Object_Field__c = 'newpaymentamount';
    configQueryList.add(query1);
    
    query2.Name = 'test';
    query2.Document_Object_Field__c = 'currentduedate';
    configQueryList.add(query2);
    
    query3.Name = 'test';
    query3.Document_Object_Field__c = 'nameline1';
    configQueryList.add(query3);    
    insert configQueryList;
    
                    
    responseDataMap1.put('nameline1','test');
    responseDataMap1.put('newduedate','2015-10-23');
    responseDataMap1.put('currentduedate','2015-10-30');
    responseDataMap1.put('newpaymentamount','0.25');
    //DataTypeMap.put('nameline1', 'data_type__c');
  
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    
    
    Document_Request_Line_Item__c docReqLI = new Document_Request_Line_Item__c();
    docReqLI.name = 'test';
    docReqLI.Document_Request__c = docRequest.id;
    docReqLIList.add(docReqLI);
    insert docReqLIList;
    
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest);
    documentDat.getLineItems();
    documentDat.setLineItems(docReqLIList);  
    responseDataMap2.put('middleName','test');
    Forms_DataValidator validator= new Forms_DataValidator('4201');
   
    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
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
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;
   
    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping(); 
    formObjMapping.mappingResponseToDocReq(responseDataMap1,documentDat,formFieldJuncList); //TC_081,TC_084,TC_085
    formObjMapping.mappingResponseToDocReq(responseDataMap2,documentDat, formFieldJuncList); 
    formObjMapping.validateResponseData(validator,documentDat);
    formObjMapping.generateDmsXML(documentDat);
    test.stoptest();
    }
    
Static testmethod void test_docReqMappingconfigSet(){
    Map<String,String> responseDataMap1 = new Map<String,String>();
    Map<String,String> responseDataMap2 = new Map<String,String>();
    Map<String,String> DataTypeMap = new Map<String,String>();
    list <FormServiceConfig__c> formServConfigList = new list <FormServiceConfig__c>();
    Forms_TestDataUtil.insertForms_ErrorMessages();
    list <Document_Request_Line_Item__c> docReqLIList = new list <Document_Request_Line_Item__c>();  
    
    FormServiceConfig__c formServObj = new FormServiceConfig__c();
    formServObj.ReferenceAttribute__c='nameline1';
    //formServObj.Link_to_Document_Request_Object__c='Recipient_NameLine1__c';
    formServObj.ParentNode__c='response';
    formServObj.AttributeType__c='Response';
    formServObj.data_type__c='String';
    formServConfigList.add(formServObj);
    
    System.assertNotEquals(formServObj,NULL);
       
    FormServiceConfig__c formServObj2 = new FormServiceConfig__c();
    formServObj2.ReferenceAttribute__c='newduedate';
    //formServObj2.Link_to_Document_Request_Object__c='NewDueDate__c';
    formServObj2.AttributeType__c='Response';
    formServObj2.ParentNode__c='response';
    formServConfigList.add(formServObj2);
    System.assertNotEquals(formServObj2,NULL);
    
    FormServiceConfig__c formServObj3 = new FormServiceConfig__c();
    formServObj3.ReferenceAttribute__c='newpaymentamount';
    //formServObj3.Link_to_Document_Request_Object__c='NewPaymentAmount__c';
    formServObj3.AttributeType__c='Response';
    formServObj3.ParentNode__c='response';
    formServConfigList.add(formServObj3);
    System.assertNotEquals(formServObj3,NULL);
    
    FormServiceConfig__c formServObj4 = new FormServiceConfig__c();
    formServObj4.ReferenceAttribute__c='currentduedate';
    //formServObj4.Link_to_Document_Request_Object__c='CurrentDueDate__c';
    formServObj4.AttributeType__c='Response';
    formServObj4.ParentNode__c='response';
    formServConfigList.add(formServObj4);
    System.assertNotEquals(formServObj4,NULL);
    insert formservconfiglist;
    
    list<Forms_QueryConfig__c> configQueryList = new list<Forms_QueryConfig__c>();
    Forms_QueryConfig__c query = new Forms_QueryConfig__c();
    query.Name = 'test';
    query.Document_Object_Field__c = 'newduedate';
    //configQueryList.add(query);
    
    Forms_QueryConfig__c query1 = new Forms_QueryConfig__c();
    Forms_QueryConfig__c query2 = new Forms_QueryConfig__c();
    Forms_QueryConfig__c query3 = new Forms_QueryConfig__c();
    
    query1.Name = 'test';
    query1.Document_Object_Field__c = 'NextMonthPaymentAmount__c';
    configQueryList.add(query1);
    
    query2.Name = 'test';
    query2.Document_Object_Field__c = 'currentduedate';
    //configQueryList.add(query2);
    
    query3.Name = 'test';
    query3.Document_Object_Field__c = 'Recipient_NameLine1__c';
    configQueryList.add(query3);    
    insert configQueryList;
    
                    
    responseDataMap1.put('Recipient_NameLine1__c','test');
    //responseDataMap1.put('newduedate','2015-10-23');
    //responseDataMap1.put('currentduedate','2015-10-30');
    responseDataMap1.put('NextMonthPaymentAmount__c','0.25');
    //DataTypeMap.put('nameline1', 'data_type__c');
  
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    
    
    Document_Request_Line_Item__c docReqLI = new Document_Request_Line_Item__c();
    docReqLI.name = 'test';
    docReqLI.Document_Request__c = docRequest.id;
    docReqLIList.add(docReqLI);
    insert docReqLIList;
    
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest);
    documentDat.getLineItems();
    documentDat.setLineItems(docReqLIList);  
    responseDataMap2.put('middleName','test');
    Forms_DataValidator validator= new Forms_DataValidator('4201');
   
    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
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
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;
   
    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping(); 
    formObjMapping.mappingResponseToDocReq(responseDataMap1,documentDat,formFieldJuncList); //TC_081,TC_084,TC_085
    formObjMapping.mappingResponseToDocReq(responseDataMap2,documentDat, formFieldJuncList); 
    formObjMapping.validateResponseData(validator,documentDat);
    formObjMapping.generateDmsXML(documentDat);
    test.stoptest();
    }
    
    /*
    Method Name:test_docReqMapping2
    Method Return Type/outputs:Test Method Pass/Fail
    Method Description:This method is to cover the mappingResponseToDocReq method positive scenario.
    */
    
    Static testmethod void test_docReqMapping2(){
  
    Map<String,String> responseDataMap1 = new Map<String,String>();
    Map<String,String> responseDataMap2 = new Map<String,String>();
    Map<String,String> DataTypeMap = new Map<String,String>();
    list<FormServiceConfig__c> FSClist = new list<FormServiceConfig__c>();
    Forms_TestDataUtil.insertForms_ErrorMessages();
        
    FormServiceConfig__c formServObj = new FormServiceConfig__c();
    formServObj.ReferenceAttribute__c='nameline1';
    formServObj.Link_to_Document_Request_Object__c='Recipient_NameLine1__c';
    formServObj.ParentNode__c='response';
    formServObj.AttributeType__c='Response';
    formServObj.data_type__c='String';
    System.assertNotEquals(formServObj,NULL);
    FSClist.add(formServObj);
    
    
    FormServiceConfig__c formServObj2 = new FormServiceConfig__c();
    formServObj2.ReferenceAttribute__c='creationdate';
    formServObj2.Link_to_Document_Request_Object__c='CreatedDate__c';
    formServObj2.AttributeType__c='Response';
    formServObj2.ParentNode__c='Entity';
    System.assertNotEquals(formServObj2,NULL);
    FSClist.add(formServObj2);
    
    FormServiceConfig__c formServObj3 = new FormServiceConfig__c();
    formServObj3.ReferenceAttribute__c='IsReturnEnvelopeRequired';
    formServObj3.Link_to_Document_Request_Object__c='ReturnEnvelope__c';
    formServObj3.AttributeType__c='Response';
    formServObj3.ParentNode__c='Dispatch';
    System.assertNotEquals(formServObj3,NULL);
    FSClist.add(formServObj3);
    
    insert FSClist; 
    
    responseDataMap1.put('creationdate','2015-10-23 00:00:00');
    responseDataMap1.put('nameline1','test');
    responseDataMap1.put('IsReturnEnvelopeRequired', 'true');
       
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest); 
   
    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
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
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;
   
    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping(); //TC_082,TC_083,TC_098,TC_099
    formObjMapping.mappingResponseToDocReq(responseDataMap1,documentDat, formFieldJuncList);    
    test.stoptest();
    }
    
    /* 
    Method Name:test_docreqlineitem
    Method Signature/Inputs:Responsedatamap, Documentrequest object, Forms_DocumentDataHolder.
    Method Return Type/outputs:Test Method Pass/Fail
    Method Description:This method is to cover the mappingResponseToDocReq method positive scenario with documentRequestLineItem object.
    */
    
    Static testmethod void test_docreqlineitem(){
    
    Map<String,String> responseDataMap1 = new Map<String,String>();
    Map<String,String> responseDataMap2 = new Map<String,String>();
    Map<String,String> DataTypeMap = new Map<String,String>();
    list<FormServiceConfig__c> FSClist = new list<FormServiceConfig__c>();
    Forms_TestDataUtil.insertForms_ErrorMessages();
    
    FormServiceConfig__c formServObj1 = new FormServiceConfig__c();
    formServObj1.ReferenceAttribute__c='cocustomer';
    formServObj1.Link_to_DocumentRequestLineItem_Object__c='CoCustomer_MiddleName__c';
    formServObj1.AttributeType__c='Response';
    formServObj1.ParentNode__c='Entity';
    System.assertNotEquals(formServObj1,NULL);
    FSClist.add(formServObj1);
    insert FSClist;
    
    responseDataMap1.put('cocustomer','test');
    
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest);
    
    
    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
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
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;
    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping(); //TC_086,TC_087,TC_088,TC_096,TC_097
    formObjMapping.mappingResponseToDocReq(responseDataMap1,documentDat,formFieldJuncList);
    test.stoptest();
    
    }
    /* 
    Method Name:test_docReqEXC
    Method Signature/Inputs:Responsedatamap, Documentrequest object, Forms_DocumentDataHolder.
    Method Return Type/outputs:Test Method Pass/Fail
    Method Description:This method is to cover the mappingResponseToDocReq method negative scenario.
    */
    
    Static testmethod void test_docReqEXC(){
    Forms_TestDataUtil.insertForms_ErrorMessages();
    list<FormServiceConfig__c>  fsclist = new list<FormServiceConfig__c>();
    FormServiceConfig__c formServObj2 = new FormServiceConfig__c();
    formServObj2.ReferenceAttribute__c='IsReturnEnvelopeRequired';
    formServObj2.Link_to_Document_Request_Object__c='ReturnEnvelope__c';
    formServObj2.AttributeType__c='Response';
    formServObj2.ParentNode__c='Dispatch';
    System.assertNotEquals(formServObj2,NULL);
    fsclist.add(formServObj2);
      
    Map<String,String> responseDataMap2 = new Map<String,String>();
    FormServiceConfig__c formServObj5 = new FormServiceConfig__c();
    formServObj5.ReferenceAttribute__c='nextmonthlypaymentamount';
    formServObj5.Link_to_Document_Request_Object__c='NextMonthPaymentAmount__c';
    formServObj5.AttributeType__c='Response';
    formServObj5.ParentNode__c='response';
    System.assertNotEquals(formServObj5,NULL);
    fsclist.add(formServObj5);
    
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest);
    insert fsclist;
    //responseDataMap2.put('creationdate','2015-10-23 00:00:00');
    //responseDataMap2.put('IsReturnEnvelopeRequired','true');

    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
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
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;

    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping(); //TC_089,TC_090,TC_091,TC_092,TC_093,TC_094,TC_095    
    formObjMapping.mappingResponseToDocReq(responseDataMap2,documentDat,formFieldJuncList);
    
    test.stoptest();
    }
    
    Static testmethod void test_Newmethod(){
    
    Map<String,String> responseDataMap1 = new Map<String,String>();    
    Map<String,String> docReqLineItemMap = new Map<STring,String>();
    Map<String,String> DataTypeMap = new Map<String,String>();
    list<FormServiceConfig__c> FSClist = new list<FormServiceConfig__c>();
    Forms_TestDataUtil.insertForms_ErrorMessages();
    
    FormServiceConfig__c formServObj1 = new FormServiceConfig__c();
    formServObj1.ReferenceAttribute__c='cocustomer';
    formServObj1.Link_to_DocumentRequestLineItem_Object__c='CoCustomer_MiddleName__c';
    formServObj1.AttributeType__c='Response';
    formServObj1.ParentNode__c='Entity';
    System.assertNotEquals(formServObj1,NULL);
    FSClist.add(formServObj1);
    insert FSClist;
    
    responseDataMap1.put('cocustomer','test');
    responseDataMap1.put('nameline1','test');
    responseDataMap1.put('newduedate','2015-10-23');
    responseDataMap1.put('currentduedate','2015-10-30');
    responseDataMap1.put('newpaymentamount','0.25');
    responseDataMap1.put('formID','4201');
    responseDataMap1.put(Forms_Constant.FORMNUMBER,'4201');
    docReqLineItemMap.put('Co-Customers','CustomString4__c');
    
    
    
    case caseobj = new case();
    caseobj.Status='New';
    caseobj.Origin='Email';
    caseobj.KM_Department__c='TestDepartment';
    caseobj.KM_Change_Category__c = 'TestCategory';
    caseobj.KM_Documentation_Impacted__c='TestDocumentation';
    insert caseobj;

    Document_Request__c docRequest = new Document_Request__c();
    docRequest.AccountNumber__c='70400100000010001';
    docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');
    docRequest.Dealer_Number__c='Dealer123';
    docRequest.Case__c= caseobj.id;
    docRequest.NextMonthPaymentAmount__c=2000.0;
    docRequest.language__c='english';
    insert docRequest;
    Forms_DocumentDataHolder documentDat = new Forms_DocumentDataHolder();
    documentDat.setDocumentRequest(docRequest);
    
    
    Forms_TestDataUtil.insertForms_ErrorMessages();
    Form__c formObj = Forms_TestDataUtil.insertForm('4201');
    list<Form_Field_Junction__c> formFieldJuncList = new list<Form_Field_Junction__c>();
    Form_Field__c formFieldObj7= new Form_Field__c();
    formFieldObj7.Name='customSTring';
    formFieldObj7.Target_Field__c='CustomString4__c';
    formFieldObj7.Line_item_field__c=true;
    formFieldObj7.Line_item_type__c ='Co-Customers';
    formFieldObj7.Data_Type__c = 'Dummy';            
    formFieldObj7.source_system__c='ALFA';
    insert formFieldObj7;
    
    Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
    formFieldJunction.Form__c = formobj.Id;
    formFieldJunction.Form_Field__c = formFieldObj7.Id;
    formFieldJunction.required__c =true;
    formFieldJuncList.add(formFieldJunction);
    insert formFieldJuncList;
    Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
    
    test.startTest();            
    Forms_DocumentRequestDataMapping formObjMapping= new Forms_DocumentRequestDataMapping();
    formObjMapping.mapResponseToDocReqLineItem(responseDataMap1,docReqLineItemMap,documentData);
    Forms_DataSelector.getMultiServicesJunctions(responseDataMap1,docReqLineItemMap);       
    test.stoptest();
    
    }   
  }