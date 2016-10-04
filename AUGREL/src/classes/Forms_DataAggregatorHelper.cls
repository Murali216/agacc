/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DataAggregatorHelper
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 10/6/2015 
Last Modified by......: Thenmozhi
Last Modified Date....: 10/26/2015 
Description...........: This helper class has been written for fetching multiple dispatch modes  and languages details for specific forms


Change Request History:
thenmozhi      27/11/2015   Added commands for methods and header for code standard
Balaji    J    14/01/2016   Added two methods getOutStandingLeaseBalance and getSalesTaxOnOutStandingLeaseBalance for assigning balances docReqObj Object.

##########################################################################################
 */
public class Forms_DataAggregatorHelper {
    /*
      Method Name: aggregateDispatchInformation
      Method Signature/Inputs:Form__c formData, Form_Request__c formRequest, Forms_DocumentDataHolder documentData
      Method Return Type/outputs:Adding documentData 
      Method Description:This method is used to fetch document data
     */
    public void aggregateDispatchInformation(Form__c formData, Form_Request__c formRequest, Forms_DocumentDataHolder documentData,Map<string,string> dataMap){

        String dispatchTypes = formRequest.Dispatch_Name__c;
        if(dispatchTypes != null){
        List<String> dispatchType = dispatchTypes.split(';'); 
        for(String dispatchName : dispatchType){ 
            Document_Request_Line_Item__c docReqLineItem = new Document_Request_Line_Item__c();
            docReqLineItem.Type__c = Forms_Constant.DISPATHLINEITEMTYPE;
            docReqLineItem.dispatchName__c = dispatchName;
            docReqLineItem.isLegalEnvelop__c = formData.legalEnvelop__c;
            docReqLineItem.returnEnvelop__c = formData.returnEnvelopRequired__c;
            docReqLineItem.Is_Certified_Mail__c = formData.certifiedmail__c;
            docReqLineItem.noOfCopies__c = formData.NumberOfCopies__c;
            if(dispatchName.equalsIgnoreCase(Forms_Constant.DISPATCHNETWORKPRINT))
                docReqLineItem.Dispatch_DeviceName__c = formRequest.Device_Name__c;
            documentData.addLineItem(docReqLineItem);
            }
        }
        String formNumber = dataMap.get(Forms_Constant.FORMNUMBER);
        Map<String,String> expenseDescForExpenseType = new Map<String,String>();
        List<String> chargeCodes;
        Map<String,Decimal> getNetBilledNumber= new Map<String,Decimal>();
        Map<String,Decimal> getTaxBilledNumber= new Map<String,Decimal>();

       
          
    }
   
    /*account number convertion */

    public void convertAccountNumber(Map<String,String> dataMap, Forms_DocumentDataHolder documentData){

        String accountNumber = Forms_Utils.convertAccountNumber(dataMap.get('accountnumber'),dataMap.get('productcode'));
        Document_Request__c docRequest = documentData.getDocumentRequest();
        docRequest.AccountNumber__c = accountNumber; 
        documentData.setDocumentRequest(docRequest);

    } 
    /*
      Method Name: aggregateLanguagePreference
      Method Signature/Inputs:Form_Request__c formRequest, Forms_DocumentDataHolder documentData
      Method Return Type/outputs:Adding documentData for language preference 
      Method Description:This method is used to fetch document data for language preference.
     */
    public void aggregateLanguagePreference(Form_Request__c formRequest, Forms_DocumentDataHolder documentData){

        system.debug('Forms_DataAggregatorHelper::aggregateLanguagePreference:: doumentData  is '+documentData);
        //system.debug('Forms_DataAggregatorHelper::aggregateLanguagePreference:: Language is '+languagePreference);
        Document_Request__c docRequest = documentData.getDocumentRequest();
        docRequest.language__c = Forms_Utils.getLanguagePreference(docRequest.Language__c);
        documentData.setDocumentRequest(docRequest);
    }

    /*
      Method Name: handleDeceasedReceipent
      Method Signature/Inputs:Forms_DocumentDataHolder documentData
      Method Return Type/outputs:Adding Forms_Utils
      Method Description:This method is used to handle docReqObj  object 
     */
    public void handleDeceasedReceipent(Forms_DocumentDataHolder documentData){
        Document_Request__c docReqObj = documentData.getDocumentRequest();
        if(docReqObj.Recipient_NameLine1__c!=null)
        docReqObj.Recipient_NameLine1__c = Forms_Utils.handleDeceasedReceipent(docReqObj.Recipient_NameLine1__c, docReqObj.CustomString1__c);
        if(docReqObj.Customstring18__c!=null)
       
        docReqObj.Customstring18__c = Forms_Utils.handleDeceasedReceipent(docReqObj.Customstring18__c, docReqObj.CustomString1__c);
       
        if(docReqObj.Recipient_Name_Line_2__c!=null)
        docReqObj.Recipient_Name_Line_2__c = Forms_Utils.handleDeceasedReceipent(docReqObj.Recipient_Name_Line_2__c, docReqObj.CustomString3__c);
    }   
    
   public void trimAccNumber(Forms_DocumentDataHolder documentData,Map<String,String> responseDataMap){
      Document_Request__c docReqObj = documentData.getDocumentRequest();  
        if(responseDataMap.get('bankaccountnumber')!=null && responseDataMap.get('bankaccountnumber')!=' '){ 
           docReqObj.CustomString8__c = responseDataMap.get('bankaccountnumber').right(4);   
        }    
   }

}