/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_UtilsTest 
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 11/02/2015 
Last Modified by......: thenmozhi
Last Modified Date....: 11/27/2015
Description...........: This test class has been written for Forms_UtilsTest to fetching multiple dispatch modes  and languages details for specific forms>
Change Request History:
thenmozhi       27/11/2015   Added comments in header and methods
Pranav          12/04/2015   Added a method to cover code for new changes.
##########################################################################################
 */
@isTest
Public class Forms_UtilTest
{
/*
      Method Name: UtilTest
      Method Signature/Inputs: VOID
      Method Return Type/outputs: VOID
      Method Description:This method is used to test the utility method of forms_util class.
*/
   public static testMethod void UtilTest()
   {
   Map<String,String> inputMap = new Map<String,String>();
   String accountNum='1234';
   String receipientName='ReceipientTest';
   String deceaseIndicator='DEA';
   
   Financial_Account__c acct=new Financial_Account__c();
   acct.Name='1234';
   acct.Financial_Account_Number__c = '1234';
   insert acct;
   
   Document_Request__c  docRequestNeeded=new Document_Request__c();
   
   Forms_DocumentDataHolder documentData=new Forms_DocumentDataHolder();
   
   Document_Request__c  docRequest=new Document_Request__c();
   docRequest.CustomString2__c='Legacy Retail Bank 700';
   docRequest.language__c='spanish';
   insert docRequest;
   
   documentData.setDocumentRequest(docRequest);
   
   
  /* Account accnt = new Account();
   accnt.name = 'testName';
   insert accnt;
   
   Financial_Account_Customer__c acctCustomer = new Financial_Account_Customer__c();
   acctCustomer.Election_Language_Preference__c = '';
   acctCustomer.Financial_Account_Number__c = acct.id;
   acctCustomer.Account__c = accnt.id;
   insert acctCustomer;*/
   
   Forms_Product_Type__c FormsProductType=new Forms_Product_Type__c();
   FormsProductType.Description__c='Legacy Retail Bank 700';
   FormsProductType.Name='BANK_700';
   insert FormsProductType;
   
   Forms_Product_Type__c FormsProductType1=new Forms_Product_Type__c();
   FormsProductType1.Description__c='Legacy Retail Bank 800';
   FormsProductType1.Name='BANK_800';
   insert FormsProductType1;
   
   test.starttest();
   Forms_Utils.executionTime(System.now(),System.now(),'Forms_UtilTest','UtilTest');
   String response1=Forms_Utils.convertAccountNumber(accountNum,docRequest.CustomString2__c);
   String response2= Forms_Utils.handleDeceasedReceipent(receipientName,deceaseIndicator);
   String response3=Forms_Utils.getLanguagePreference(docRequest.language__c);
   //TODO in main class
   String response4=Forms_Utils.getRequestId();
   test.stoptest();
   }
    
    public static testmethod void testConvertAccountNumber(){
        
        // Don't convert for lease account
        String accountNumber = '12345678901';
        String productType = 'CLSD_EN_LS';
        String cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('12345678901',cAccNumber);
        
        accountNumber = '12345678901';
        productType = 'ONE_PAY_LS';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('12345678901',cAccNumber);
        
        // append 800 for BANK_800
        accountNumber = '1234567890';
        productType = 'BANK_800';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('80012345678900001',cAccNumber);
        
        // append 700 for BANK_700
        accountNumber = '1234567890';
        productType = 'BANK_700';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('70012345678900001',cAccNumber);
        
        //Append 704 for PRE_CMP_LN, RET_BAL_LN,RET_SIM_LN
        accountNumber = '1234567890';
        productType = 'PRE_CMP_LN';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('70412345678900001',cAccNumber);
        
        accountNumber = '1234567890';
        productType = 'RET_BAL_LN';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('70412345678900001',cAccNumber);
        
        accountNumber = '1234567890';
        productType = 'RET_SIM_LN ';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('70412345678900001',cAccNumber);

        // append nothing if null or empty
        accountNumber = '1234567890';
        productType = null;
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('1234567890',cAccNumber);
        
        accountNumber = '1234567890';
        productType = '';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('1234567890',cAccNumber);
        
        accountNumber = '1234567890';
        productType = '  ';
        cAccNumber = Forms_Utils.convertAccountNumber(accountNumber, productType);
        System.assertEquals('1234567890',cAccNumber);
        
        
        
    }
   
 
  
  /*Method Name: handleDeceasedReceipentTest
    Method Signature/Inputs: deceasedIndicator(String), recipientName (String)
    Method Return Type/outputs: String. 
    Method Description: This method is to append Estate- based on deceased indicator.
  */ 
  public static testMethod void handleDeceasedReceipentTest(){
  String receipientName = 'Sneha';
  String deceasedIndicator = 'DEA';
  String testreceipientName = Forms_Utils.handleDeceasedReceipent(receipientName,deceasedIndicator);
  Forms_Utils.gettingAllMetaDataFields(Forms_Constant.DOCUMENTREQUEST);
  String userName = Forms_Utils.decryptUserName();
  String password = Forms_Utils.decryptPassword();
  } 
 
  
}