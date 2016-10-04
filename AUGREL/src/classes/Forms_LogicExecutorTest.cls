/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_LogicExecutorTest> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <02/26/2016> 
Last Modified by......: <pranav>
Last Modified Date....: <02/26/2016>
Description...........: <This test class has been written covering code for Forms_LogicExecutor class for SFDC data>

Change Request History:

##########################################################################################
 */



 @isTest 
private class Forms_LogicExecutorTest{


/*
      Method Name:testExecuteMethod1
      Method Signature/Inputs:
      Method Return Type/outputs: Testing Logic 
      Method Description:This method is used to insert test data for the desired Logic class
*/

 static testmethod void testExecuteMethod1(){

 Map <String,String> testDataMap = new Map<String,String>();
       testDataMap.put('testamount1','100');
       testDataMap.put('testamount2','100');
       testDataMap.put('refValkey','testRef');
  Map<String,String> testResultMap = new Map<String,String>();
 
 List<Forms_LogicConfiguration__c> logicConfigList1 = new  List<Forms_LogicConfiguration__c>();
 List<Forms_LogicConfiguration__c> logicConfigList2 = new  List<Forms_LogicConfiguration__c>();
 Forms_LogicConfiguration__c logicConfig1 = new Forms_LogicConfiguration__c();
 
            logicConfig1.Referecen_Attribute__c ='testamount';
            logicConfig1.Logic_Condition__c='ADDSUB';
            logicConfig1.expression__c='testamount1+testamount2';
            insert logicConfig1;
 logicConfigList1.add(logicConfig1);
 
 Forms_LogicConfiguration__c logicConfig2 = new Forms_LogicConfiguration__c();
            logicConfig2.Referecen_Attribute__c ='refValkey';
            logicConfig2.Logic_Condition__c='IF';
            logicConfig2.Operator__c='IN';
            ///logicConfig2.successValue__c;
           // logicConfig2.failValue__c;
            logicConfig2.value__c='abc,def';
            //logicConfig2.document_object__c;
            insert logicConfig2;
 logicConfigList2.add(logicConfig2);
 
// referenceValue

            test.starttest();
            //checking the first loop 
            Form__c formInserted=Forms_TestDataUtil.insertForm('4201');
            List<Document_Request_Line_Item__c> DocReqLineItemList=new List<Document_Request_Line_Item__c>();
        
        Document_Request_Line_Item__c docReqLineItem = new Document_Request_Line_Item__c();
        docReqLineItem.Type__c = Forms_Constant.DISPATHLINEITEMTYPE;        
        docReqLineItem.isLegalEnvelop__c = formInserted.legalEnvelop__c;
        docReqLineItem.returnEnvelop__c = formInserted.returnEnvelopRequired__c;
        DocReqLineItemList.add(docReqLineItem);        
        Document_Request_Line_Item__c docReqLineItem1 = new Document_Request_Line_Item__c();
        docReqLineItem1.Type__c = Forms_Constant.DISPATHLINEITEMTYPE;        
        docReqLineItem1.isLegalEnvelop__c = formInserted.legalEnvelop__c;
        docReqLineItem1.returnEnvelop__c = formInserted.returnEnvelopRequired__c;
        DocReqLineItemList.add(docReqLineItem1);          
        
        Document_request__c DocReq=Forms_TestDataUtil.getDocumentRequest('4201');
        
        Forms_DocumentDataHolder documentData=new Forms_DocumentDataHolder();
        documentData.setDocumentRequest(DocReq);
        documentData.setLineItems(DocReqLineItemList);                      
            Map<String,String>  resultMap1 = Forms_LogicExecutor.execute(testDataMap,logicConfigList1, testResultMap,documentData);
            //System.assert();
            
            //checking the else condition
            Map<String,String>  resultMap2 = Forms_LogicExecutor.execute(testDataMap,logicConfigList2, testResultMap,documentData);
            //System.assert();
            test.stoptest();
            
    }       
}