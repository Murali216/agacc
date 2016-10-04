/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DataAggregatorHelperTest
Version...............: 1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 11/02/2015 
Last Modified by......: thenmozhi
Last Modified Date....: 11/27/2015
Description...........: This test class has been written for Forms_DataAggregatorhelper to fetching multiple dispatch modes  and languages details for specific forms
Change Request History:
thenmozhi       27/11/2015   Added comments in header and methods
##########################################################################################
 */
@isTest
public class Forms_DataAggregatorHelperTest
{    
      /*
      Method Name: test_aggregation
      Method Signature/Inputs:Forms_TestDataUtil.insertForm('2000');
      Method Return Type/outputs: Inserting records
      Method Description:This method is used to insert test data for the desired object for documenting i.e.(Dispatch mode,languages)
     */
     static testmethod void  test_aggregation()
    {
        Forms_TestDataUtil.insertForms_ErrorMessages();
        Form__c formInserted=Forms_TestDataUtil.insertForm('4201');
        
        Form_Request__c formReq = new Form_Request__c();
        formReq.Account_Number__c='70400100000010001';
        formReq.Dispatch_Name__c='Print Central,Print Local,Network print,Email,Fax';
        formReq.Form_Type__c='Automated';
        formReq.Form_Number__c='4201';
        formReq.CreationDate__c=Date.VAlueOf('2015-10-29 00:00:00');
        formReq.Device_Name__c = 'TFSW3F2018A';
        formReq.SourceSystem__c = 'ALFA';
        formReq.Target_System__c = 'FILENET';
        formReq.Recipient__c = '12345';
        formReq.Effective_State_Code__c = 'CA';
        
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
        
        
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '3102IN');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        inputMap.put('netBilledType1', '100');
        inputMap.put('netBilledType10', '100');             
        inputMap.put('netBilledType527', '100');
        inputMap.put('netBilledType53', '100');
        inputMap.put('netBilledType606', '100');
        inputMap.put('netBilledType607', '100');
        inputMap.put('netBilledType609', '100');
        inputMap.put('netBilledType54', '100');
        inputMap.put('netBilledType53', '100');
        inputMap.put('netBilledType529', '100');
        inputMap.put('taxBilledType609', '100');
        inputMap.put('taxBilledType1', '100');
        inputMap.put('taxBilledType10', '100');
        inputMap.put('taxBilledType53', '100');
        inputMap.put('taxBilledType606', '100');
        inputMap.put('taxBilledType607', '100');
        inputMap.put('taxBilledType54', '100');
        inputMap.put('taxBilledType53', '100');
        inputMap.put('taxBilledType529', '100');
        inputMap.put('taxBilledType527', '100');
        inputMap.put('instalmentsNetBalance', '100');
        inputMap.put('lateFeesNetBalance', '100');
        inputMap.put('contractualChargesNetBalance','100');
        inputMap.put('addonChargesTaxBalance','100');
        inputMap.put('adminChargesTaxBalance','100');
        inputMap.put('contractualChargesTaxBalance','100');
        inputMap.put('c529','TestDescription');
        inputMap.put('coCustomerFirstName','Geetha');
        inputMap.put('coCustomerMiddleName','Vani');
        inputMap.put('coCustomerLastName','Muthukuru');
        inputMap.put('SCHEDULEMISCTYPE','ScheduleType');
        inputMap.put('charge','111');
        inputMap.put('rescheduleOriginalTerm','100');
        inputMap.put('numberOfRemainingPayments','50');
        inputMap.put('currentpaymentdue','500');
        test.startTest();
        Forms_DataAggregatorHelper FormDataAggregator=new Forms_DataAggregatorHelper();
        
        FormDataAggregator.aggregateDispatchInformation(formInserted,formReq,documentData,inputMap);
        documentData.setLineItems(DocReqLineItemList);
        documentData.getLineItems();
        documentData.setDocumentRequest(DocReq);
        documentData.getDocumentRequest();
        
        FormDataAggregator.aggregateLanguagePreference(formReq,documentData);
        FormDataAggregator.handleDeceasedReceipent(documentData);
        test.stopTest();
    }
    
    static testMethod void testCalculations()
    {
        Forms_DataAggregator dataAggregator= new Forms_DataAggregator();
        Form__c form = Forms_TestDataUtil.insertForm('3102IN');
        Form_Request__c formRequest = Forms_TestDataUtil.getValidFormRequest('3102IN');
        Document_Request__C docReq = new Document_Request__c();
        Document_Request__C docReq1 = new Document_Request__c();
        docReq.FormId__c='4015';
        docReq1.FormId__c='6015';
        Document_Request_Line_Item__c docReqLineItem;
        docReq.customDecimal20__c=1230.00;
        docReq.customDecimal19__c=1540.00;
        docReq.customDecimal15__c=1540.00;
        
        
        Forms_DocumentDataHolder documentData = new Forms_DocumentDataHolder();
        documentData.setDocumentRequest(docReq1);
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '111111111');
        inputMap.put('formnumber', '3102IN');
        inputMap.put('formtype', 'Automated');
        inputMap.put('dispatchmode', 'Fax');
        inputMap.put('netBilledType1', '100');
        inputMap.put('netBilledType10', '100');
        inputMap.put('netBilledType527', '100');
        inputMap.put('netBilledType53', '100');
        inputMap.put('netBilledType606', '100');
        inputMap.put('netBilledType607', '100');
        inputMap.put('netBilledType609', '100');
        inputMap.put('netBilledType54', '100');
        inputMap.put('netBilledType53', '100');
        inputMap.put('netBilledType529', '100');
        inputMap.put('taxBilledType609', '100');
        inputMap.put('taxBilledType1', '100');
        inputMap.put('taxBilledType10', '100');
        inputMap.put('taxBilledType53', '100');
        inputMap.put('taxBilledType606', '100');
        inputMap.put('taxBilledType607', '100');
        inputMap.put('taxBilledType54', '100');
        inputMap.put('taxBilledType53', '100');
        inputMap.put('taxBilledType529', '100');
        inputMap.put('taxBilledType527', '100');
        inputMap.put('gross533','533');
        inputMap.put('gross534','534');
        inputMap.put('gross535','535');
        inputMap.put('gross502','502');
        inputMap.put('gross509','509');
        inputMap.put('gross607','607');
        inputMap.put('gross510','510');
        inputMap.put('gross536','536');
        inputMap.put('net533','533');
        inputMap.put('net534','534');
        inputMap.put('net535','535');
        inputMap.put('net536','536');
        inputMap.put('tax533','533');
        inputMap.put('tax534','534');
        inputMap.put('tax535','535');
        inputMap.put('tax536','536');
        inputMap.put('net502','502');
        inputMap.put('tax502','502');
        inputMap.put('net509','509');
        inputMap.put('tax509','509');
        inputMap.put('gross527','527');
        inputMap.put('net527','527');
        inputMap.put('tax527','527');
        inputMap.put('gross531','531');
        inputMap.put('net531','531');
        inputMap.put('tax531','531');
        inputMap.put('taxAmount','200');
        inputMap.put('totalCustomerOverPayments','200');
        inputMap.put('newDayOfMonth','2016-01-05');
        inputMap.put('currentDayofMonth','2016-01-05');
        inputMap.put('dayOfTheMonthOfWithdrawal','2016-01-05');
        inputMap.put('monthlyPaymentDay','2016-01-05');
        inputMap.put('allNetArrears','500');        
        inputMap.put('instalmentsNetBalance', '100');
        inputMap.put('ateFeesNetBalance', '100');
        inputMap.put('contractualChargesNetBalance','100');
        inputMap.put('addonChargesTaxBalance','100');
        inputMap.put('adminChargesTaxBalance','100');
        inputMap.put('contractualChargesTaxBalance','100');
        inputMap.put('c529','TestDescription');
        inputMap.put('coCustomerFirstName','Geetha');
        inputMap.put('coCustomerMiddleName','Vani');
        inputMap.put('coCustomerLastName','Muthukuru');
        inputMap.put('SCHEDULEMISCTYPE','ScheduleType');
        inputMap.put('charge','111');
        inputMap.put('rescheduleOriginalTerm','100');
        inputMap.put('numberOfRemainingPayments','50');
        inputMap.put('currentpaymentdue','500');
        inputMap.put('allNetArrears','300');
        inputMap.put('futureRecievableNetAmount','150');
        inputMap.put('futurePaymentsAmount','120');
        inputMap.put('totalamountdue','100');
        inputMap.put('adminCharges','100');
        inputMap.put('addOnCharges','100');
        inputMap.put('otherCharges','100');
        inputMap.put('lateFees','100');
        inputMap.put('allGrossChargeTypes','1000');
        inputMap.put('expense102','102');
        inputMap.put('expense120','120');
        inputMap.put('expense106','106');
        inputMap.put('expense110','110');
        inputMap.put('expense104','104');
        inputMap.put('expense122','122');
        inputMap.put('OtherRepoCharges_Description__c','100');
        inputMap.put('c527','Attorney Fee');
        inputMap.put('c531','Other Fee');
        inputMap.put('g527','Attorney Fee');
        inputMap.put('g531','Other Fee');
        inputMap.put('expenseCode527','Attorney Fee');
        inputMap.put('expenseCode531','Other Fee');
                
        dataAggregator.aggregateFormData(form,formRequest ,documentData ,inputMap);        
        
        Form__c form1 = Forms_TestDataUtil.insertForm('6156');
        Form_Request__c formRequest1 = Forms_TestDataUtil.getValidFormRequest('6156');
        
        inputMap.put('formnumber', '6156');
        
        //4001
         Form__c form2 = Forms_TestDataUtil.insertForm('4001');
        Form_Request__c formRequest2 = Forms_TestDataUtil.getValidFormRequest('4001');
        
        inputMap.put('formnumber', '4001');
        
        
        //for covering list
        
        Form__c form11 = Forms_TestDataUtil.insertForm('4000');
        Form_Request__c formRequest11 = Forms_TestDataUtil.getValidFormRequest('4000');
        Forms_DataAggregatorHelper helper11 = new Forms_DataAggregatorHelper();
        if(form11.Form_Number__c=='4000')
            boolean existsLineItem=false;
        helper11.aggregateDispatchInformation(form11 ,formRequest11,documentData,inputMap);
        

        }
        
        }