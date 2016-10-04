/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_DataAggregatorTest> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <10/16/2015> 
Last Modified by......: <thenmozhi>
Last Modified Date....: <11/27/2015 >
Description...........: <This test class has been written covering code for Forms_DataAggregator class for SFDC data>

Change Request History:
thenmozhi       27/11/2015   Added assertequals statement
##########################################################################################
 */
 @isTest 
private class Forms_DataAggregatorTest {
    public static String loadQuoteXML;
    public static String loadAssetXML;
    
     static testmethod void constructQueryNullTest(){
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        dataAggregator.constructQuery(null,null);
    }
  
   /*
      Method Name:createRecords
      Method Signature/Inputs:Forms_TestDataUtil.insertForm('2000');
      Method Return Type/outputs: Inserting records
      Method Description:This method is used to insert test data for the desired object
     */
       static void createRecords(){
        
        Forms_TestDataUtil.insertFormFieldsForRequest();
        Forms_TestDataUtil.insertFormFieldsForALFAandSFDC();//TC_144 
        
       // Forms_EffectiveState__c effectiveState = new Forms_EffectiveState__c();
        //effectiveState.State_Code__c = 'CA';
       // effectiveState.State_Name__c = 'California';
        //insert effectiveState;
        
        Collateral__c collateral = new Collateral__c();
        collateral.Model_year__c='2016';
        insert collateral;
        
        Financial_Account__c financialAccount = new Financial_Account__c();
        financialAccount.Name = 'John Doe';
        financialAccount.Financial_Account_Number__c = '111111111';
        financialAccount.Charges_Late__c = 10000;
        financialAccount.Payoff_Amount_Gross__c = 20000;
        financialAccount.Exchange_Account_Number__c = '5000';
        financialAccount.collateral__C =collateral.id; 
        Insert financialAccount;
        
        Contact contactObj = new Contact();
        contactObj.FirstName = 'John';
        contactObj.LastName ='Doe';
        contactObj.Phone = '9999988888';
        Insert contactObj;
    }
    /*
      Method Name: dataAggregator
      Method Signature/Inputs:createRecords() method is input
      Method Return Type/outputs: output map for SFDC data
      Method Description:This method is used to check the code coverage for FORMS_DataAggegator class sucess scenario 
    */
     static testMethod void dataAggregator(){
         Form__c form = Forms_TestDataUtil.insertForm('2000');
        createRecords();
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '2000');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        inputMap.put('effectivestatecode', 'CA');
        inputMap.put('name', 'John Doe');
        
        Forms_QueryConfig__c queryConfig = new Forms_QueryConfig__c();
        queryConfig.Complex_Query__c = true;
        queryConfig.DataType__c = 'String';
        queryConfig.Document_Object_Field__c = 'Language__c';
        queryConfig.Field_APIName__c = 'Election_language_Preference__c';
        queryConfig.Filter_Field__c = '';
        queryConfig.Object_ApiName__c = '';
        queryConfig.Query__c = 'Select  Election_Language_Preference__c  from financial_Account_customer__c where Financial_Account__r.Financial_Account_Number__c=? and Account__r.Universal_Customer_Id__c=?';
        queryConfig.ReferenceAttribute__c = 'String-accountnumber:String-externalid';
        insert queryConfig;
        
        Forms_QueryConfig__c queryConfig1 = new Forms_QueryConfig__c();
        queryConfig1.Complex_Query__c = false;
        queryConfig1.DataType__c = 'Integer';
        queryConfig1.Document_Object_Field__c = 'Vehicle_Year__c';
        queryConfig1.Field_APIName__c = 'Collateral__r.Model_Year__c';
        queryConfig1.Filter_Field__c = 'Financial_Account_Number__c';
        queryConfig1.Object_ApiName__c = 'Financial_Account__c';        
        queryConfig1.ReferenceAttribute__c = 'accountnumber';
        insert queryConfig1;
        
        Form_Field__c formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Language';
        formField.Target_Field__c = 'Language__C';
        formField.Source_System__c = 'SFDC';        
        formField.Forms_QueryConfig__c = queryConfig.Id;
        insert formField;
        
        Form_Field__c formField1 = new Form_Field__c();
        formField1.Data_Type__c = 'Integer';
        formField1.Name = 'VehicleYear';
        formField1.Target_Field__c = 'Vehicle_Year__c';
        formField1.Source_System__c = 'SFDC';        
        formField1.Forms_QueryConfig__c = queryConfig1.Id;
        insert formField1;
        
        Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
        formFieldJunction.Form__c = form.Id;
        formFieldJunction.Form_Field__c = formField.Id;
        insert formFieldJunction;
        
        Form_Field_Junction__c formFieldJunction1 = new Form_Field_Junction__c();
        formFieldJunction1.Form__c = form.Id;
        formFieldJunction1.Form_Field__c = formField1.Id;
        insert formFieldJunction1;
        
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        Map<String, String> outputMap = dataAggregator.queryForLookupData('2000',inputMap);//TC_141
        system.debug('::outputMap::'+json.serialize(outputMap));
        system.debug('::outputMap1::'+outputMap.containsKey('effectivestatename')+ 'Calii'+outputMap.get('accountnumber'));
        //system.assertequals(outputMap.containsKey('effectivestatename'),false);//TC_142
        //system.assertequals(outputMap.get('CustomString4__c'),'CA');
        
        Forms_DataAggregator dataAggregator1= new Forms_DataAggregator();
        
        //system.assertequals(outputMap.get('latechargedue'),'10000.00');
    }
     /*
      Method Name: dataAggregatorFailure
      Method Signature/Inputs:createRecords() method is input
      Method Return Type/outputs: output map for SFDC data
      Method Description:This method is used to check the code coverage for FORMS_DataAggegator class Failure scenario 
    */
    static testMethod void dataAggregatorFailure(){
    Form__c form = Forms_TestDataUtil.insertForm('2000');
        createRecords();
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '2000');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        inputMap.put('name', 'John');
        
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
         
        Map<String, String> outputMap = dataAggregator.queryForLookupData('2000',inputMap);
        system.assertequals(outputMap.containsKey('latechargedue'),false);//TC_142
    }
   /*
      Method Name: dataAggregatorWrongFormIdFailure
      Method Signature/Inputs:createRecords() method is input and wrong Form Id
      Method Return Type/outputs: output map for SFDC data
      Method Description:This method is used to check the code coverage for FORMS_DataAggegator class Failure scenario 
    */
    static testMethod void dataAggregatorWrongFormIdFailure(){
    Form__c form = Forms_TestDataUtil.insertForm('2000');
        createrecords();
        Map<String, String> inputMap = new Map<String, String>();
        
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '2000');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        Map<String, String> outputMap = dataAggregator.queryForLookupData('2001',inputMap);//TC_143
        system.assertEquals(outputMap.size(), 0);
    }    
    
    Static testmethod void executeComplexQueryTest(){
    Form__c form = Forms_TestDataUtil.insertForm('2000');
        createRecords();
        Map<String, String> inputMap = new Map<String, String>();
        
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '2000');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        List<Forms_QueryConfig__c> queryConfigList = new List<Forms_QueryConfig__c>();
        Forms_QueryConfig__c queryConfig = new Forms_QueryConfig__c();
        queryConfig.Complex_Query__c = true;
        queryConfig.DataType__c = 'String';
        queryConfig.Document_Object_Field__c = 'Language__c';
        queryConfig.Field_APIName__c = 'Election_language_Preference__c';
        queryConfig.Filter_Field__c = '';
        queryConfig.Object_ApiName__c = '';
        queryConfig.Query__c = 'Select  Election_Language_Preference__c  from financial_Account_customer__c where Financial_Account__r.Financial_Account_Number__c=? and Account__r.Universal_Customer_Id__c=?';
        queryConfig.ReferenceAttribute__c = 'String-accountnumber:String-externalid';
        insert queryConfig;
        

        
        queryConfigList.add(queryConfig);
                
        dataAggregator.executeComplexQuery(queryConfigList,inputMap);
        //
        }
        
        
    static testmethod void aggregateFormDataTest(){
   
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        Form__c form = Forms_TestDataUtil.insertForm('3102IN');
        Form_Request__c formRequest = Forms_TestDataUtil.getValidFormRequest('3102IN');
        Document_Request__c docReq = Forms_TestDataUtil.getDocumentRequest('4015');
        Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
        documentData.setDocumentRequest(docReq);
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '3102IN');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        inputMap.put('netBilledType527', '100');
        inputMap.put('netBilledType53', '100');
        //for admin,addon,lateFees and other Charges
        inputMap.put('adminCharges', '100');
        inputMap.put('addOnCharges', '100');
        inputMap.put('otherCharges', '100');
         inputMap.put('lateFees', '100'); 

        dataAggregator.aggregateFormData(form,formRequest ,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator1= new Forms_DataAggregator();
        Form__c form1 = Forms_TestDataUtil.insertForm('6156');
        Form_Request__c formRequest1 = Forms_TestDataUtil.getValidFormRequest('6156');        
        inputMap.put('formnumber', '6156');        
        dataAggregator1.aggregateFormData(form1,formRequest1 ,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator2= new Forms_DataAggregator();
        Form__c form2 = Forms_TestDataUtil.insertForm('6153');
        Form_Request__c formRequest2 = Forms_TestDataUtil.getValidFormRequest('6153');        
        inputMap.put('formnumber', '6153');        
        dataAggregator2.aggregateFormData(form2,formRequest2 ,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator3= new Forms_DataAggregator();
        Form__c form3 = Forms_TestDataUtil.insertForm('6153MD');
        Form_Request__c formRequest3 = Forms_TestDataUtil.getValidFormRequest('6153MD');        
        inputMap.put('formnumber', '6153MD');        
        dataAggregator3.aggregateFormData(form3,formRequest3,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator4= new Forms_DataAggregator();
        Form__c form4 = Forms_TestDataUtil.insertForm('8051');
        Form_Request__c formRequest4 = Forms_TestDataUtil.getValidFormRequest('8051');        
        inputMap.put('formnumber', '8051');        
        dataAggregator4.aggregateFormData(form4,formRequest4,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator5= new Forms_DataAggregator();
        Form__c form5 = Forms_TestDataUtil.insertForm('8051OH');
        Form_Request__c formRequest5 = Forms_TestDataUtil.getValidFormRequest('8051OH');        
        inputMap.put('formnumber', '8051OH');        
        dataAggregator5.aggregateFormData(form5,formRequest5,documentData ,inputMap);
                   
        Forms_DataAggregator dataAggregator6= new Forms_DataAggregator();
        Form__c form6 = Forms_TestDataUtil.insertForm('8051WA');
        Form_Request__c formRequest6 = Forms_TestDataUtil.getValidFormRequest('8051WA');        
        inputMap.put('formnumber', '8051WA');        
        dataAggregator6.aggregateFormData(form6,formRequest6,documentData ,inputMap);
        
        
        Forms_DataAggregator dataAggregator7= new Forms_DataAggregator();
        Form__c form7 = Forms_TestDataUtil.insertForm('3385');
        Form_Request__c formRequest7 = Forms_TestDataUtil.getValidFormRequest('3385');        
        inputMap.put('formnumber', '3385');        
        dataAggregator7.aggregateFormData(form7,formRequest7,documentData ,inputMap);
        
        Forms_DataAggregator dataAggregator8= new Forms_DataAggregator();
        Form__c form8 = Forms_TestDataUtil.insertForm('600-01');
        Form_Request__c formRequest8 = Forms_TestDataUtil.getValidFormRequest('600-01');        
        inputMap.put('formnumber', '600-01');        
        dataAggregator8.aggregateFormData(form8,formRequest8,documentData ,inputMap);
        
        //testing 6029 form calculations
        Forms_DataAggregator dataAggregator9= new Forms_DataAggregator();
        Form__c form9 = Forms_TestDataUtil.insertForm('6029');
        Form_Request__c formRequest9 = Forms_TestDataUtil.getValidFormRequest('6029');        
        inputMap.put('formnumber', '6029');        
        dataAggregator9.aggregateFormData(form9,formRequest9,documentData ,inputMap);
        
        //testing 6015 Form calculations
        Forms_DataAggregator dataAggregator10= new Forms_DataAggregator();
        Form__c form10 = Forms_TestDataUtil.insertForm('6015');
        Form_Request__c formRequest10 = Forms_TestDataUtil.getValidFormRequest('6015');        
        inputMap.put('formnumber', '6015');
        inputMap.put('netBilledType527','100');
        inputMap.put('taxBilledType527','200');  
        inputMap.put('netBilledType531','100');
        inputMap.put('taxBilledType531','200'); 
        inputMap.put('charge','100');
        dataAggregator10.aggregateFormData(form10,formRequest10,documentData ,inputMap);
        
         //testing 4015MO Form calculations
        Forms_DataAggregator dataAggregator11= new Forms_DataAggregator();
        Form__c form11 = Forms_TestDataUtil.insertForm('4015MO');
        Form_Request__c formRequest11 = Forms_TestDataUtil.getValidFormRequest('4015MO');        
        inputMap.put('formnumber', '4015MO');
        inputMap.put('gross53','53');
        inputMap.put('gross505','505');  
        inputMap.put('gross502','502');
        inputMap.put('gross509','509');
        inputMap.put('gross527','527');     
        inputMap.put('gross531','531');
        inputMap.put('allGrossChargeTypes','1000');
        dataAggregator11.aggregateFormData(form11,formRequest11,documentData ,inputMap);
        
         //testing 4005ME Form calculations
        Forms_DataAggregator dataAggregator12= new Forms_DataAggregator();
        Form__c form12 = Forms_TestDataUtil.insertForm('4005ME');
        Form_Request__c formRequest12 = Forms_TestDataUtil.getValidFormRequest('4005ME');        
        inputMap.put('formnumber', '4005ME'); 
        inputMap.put('gross502','502');
        inputMap.put('gross509','509');
        inputMap.put('gross617','617');     
        inputMap.put('gross531','531');
        inputMap.put('gross527','527');
        inputMap.put('expense102','102');
        inputMap.put('expense104','104');
        inputMap.put('expense106','106');
        inputMap.put('expense100','100');
        inputMap.put('expense110','110');
        inputMap.put('expense112','112');
        inputMap.put('expense120','120');
        inputMap.put('expense122','122');
        
        dataAggregator12.aggregateFormData(form12,formRequest12,documentData ,inputMap);
        
        
       
        }
    static testmethod void testCalUnpaidGrossBalance(){
        
         //testing 4015 Form calculations
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        Form__c form = Forms_TestDataUtil.insertForm('4015');
        Form_Request__c formRequest = Forms_TestDataUtil.getValidFormRequest('4015');
        Document_Request__c docReq = Forms_TestDataUtil.getDocumentRequest('4015');
        Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
        documentData.setDocumentRequest(docReq);
        Map<String,String> inputMap = new Map<String,String>();
        inputMap.put('formnumber', '4015');
        inputMap.put('netBilledType53','100');
        inputMap.put('taxBilledType53','200');  
        inputMap.put('netBilledType502','100');
        inputMap.put('taxBilledType502','200');
        inputMap.put('netBilledType505','100');
        inputMap.put('taxBilledType505','200');  
        inputMap.put('netBilledType509','100');
        inputMap.put('taxBilledType509','200');
        inputMap.put('netBilledType527','100');
        inputMap.put('taxBilledType527','200');  
        inputMap.put('netBilledType531','100');
        inputMap.put('taxBilledType531','200');
        inputMap.put('netBilledType529','100');
        inputMap.put('taxBilledType529','200');
        inputMap.put('currentpaymentdue','100');
        inputMap.put('SCHEDULEMISCTYPE','Test');
        inputMap.put('charge','100');
        Forms_ResponseDataHolder.setSingleNodeData(inputMap);
        dataAggregator.aggregateFormData(form,formRequest,documentData ,Forms_ResponseDataHolder.getSingleNodeData());                
    }
   // testing extra functionality
   Static testmethod void executeQueryTest(){
    Form__c form = Forms_TestDataUtil.insertForm('323-10');
        createRecords();
        Map<String, String> inputMap = new Map<String, String>();
        
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '323-10'); 
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        
        Forms_QueryConfig__c queryConfig = new Forms_QueryConfig__c();
        queryConfig.Complex_Query__c = false;
        queryConfig.DataType__c = 'String';
        queryConfig.Document_Object_Field__c = 'Language__c';
        queryConfig.Field_APIName__c = 'Election_language_Preference__c';
        queryConfig.Filter_Field__c = '';
        queryConfig.Object_ApiName__c = '';
        queryConfig.Query__c = 'Select  Election_Language_Preference__c from financial_Account_customer__c where Financial_Account__r.Financial_Account_Number__c=? and Account__r.Universal_Customer_Id__c=?';
        queryConfig.ReferenceAttribute__c = 'String-accountnumber:String-externalid';
        insert queryConfig;
        List<Forms_QueryConfig__c> queryConfigList = new List<Forms_QueryConfig__c>();
        queryConfigList.add(queryConfig);
        
        //queryConfig.Query__c
        dataAggregator.queryConfigkey='key1';
        dataAggregator.queryConfigvalue='value1';
        dataAggregator.sql='Select  Election_Language_Preference__c  from financial_Account_customer__c';
      //  dataAggregator.executeComplexQuery(queryConfigList,inputMap);
         List<sObject> sObjectResult = dataAggregator.executeQueryTogetRecords('Select  Election_Language_Preference__c from financial_Account_customer__c');
       
       //Testing new method 
       Map<String,String> dataMap = new Map <String,String>();
       Map<String,String> resultMap = new Map <String,String>(); 
       Document_Request__c docReq = Forms_TestDataUtil.getDocumentRequest('4015');
       Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
       documentData.setDocumentRequest(docReq);
       dataMap.put('formnumber','6029'); 
       Map<String,String> LogicdataMap1 = new Map<String,String>();                
       logicdataMap1  =  dataAggregator.aggregateLogicDate(dataMap, resultMap,documentData);   
        }
      Static testmethod void aggregateLogicDateTest(){
       Map<String,String> dataMap = new Map <String,String>();
       Map<String,String> resultMap = new Map <String,String>(); 
       dataMap.put('formnumber','4015'); 
       Map<String,String> LogicdataMap1 = new Map<String,String>();
       Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
       Document_Request__c docReq = Forms_TestDataUtil.getDocumentRequest('4015');
       Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
       documentData.setDocumentRequest(docReq);
       Form__c frm1 =new Form__c();
       frm1.Name='Automatic';
       frm1.Form_Number__c='4015';
       insert frm1;
       Forms_LogicConfiguration__c logicConfig = new Forms_LogicConfiguration__c();
       logicConfig.Name='LogicTest';
       logicConfig.Referecen_Attribute__c='productcode';
       logicConfig.Logic_Condition__c='IF';
       logicConfig.Operator__c='IN';
       logicConfig.value__c='BANK_700,BANK_800,RET_BAL_LN,RET_SIM_LN';
       dataMap.put('productcode','BANK_700');
       insert logicConfig;
       Form_Field__c frmField = new Form_Field__c();
       frmField.Name='Vehicle Model';
       frmField.Data_Type__c='String';
       frmField.Source_System__c='LOGIC';
       frmField.Forms_Logic_Config__c = logicConfig.Id;
       insert frmField;
       Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
       formFieldJunction.Form__c=frm1.Id;
       formFieldJunction.Form_Field__c=frmField.Id;
       insert formFieldJunction;  
         test.startTest();
           LogicdataMap1 = dataAggregator.aggregateLogicDate(dataMap,resultMap,documentData);
          test.stopTest();          
       }

}