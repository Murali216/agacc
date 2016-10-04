/**
	* FlowWebServiceFiservTest - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private class FlowWebServiceFiservTest {
	static Collateral__c collateral;
	static Account acctCustomer;
	static Account acctDealer;
    static Financial_Account__c fa;
	static List<Financial_Account_Customer__c> fac;
	
	static testMethod void invokeTest() {
    	Test.startTest();
		CreateData();
		
       	Map<String,Object> inputParams = new Map<String,Object>();
       	Map<String,Object> outputParams = new Map<String,Object>();
       
       	inputParams.put('vFinanceAccountId',fa.id);
       	inputParams.put('vCoConsent',True);
       	inputParams.put('vPrConsent',True);
       	//inputParams.put('vIntegrationid','Attorney Name: ,');
      	
		FlowWebServiceFiserv testFlow = new FlowWebServiceFiserv();
       	Process.PluginRequest request = new Process.PluginRequest(inputParams);
       	
		try{
			testFlow.describe();
         	testFlow.invoke(request);
       	}catch (Exception e){
        	System.Debug(e);
        }
       
       	Test.StopTest();
	}
	static testMethod void CalloutTest(){
		CreateData();
		Test.startTest();
    	test.setMock(WebServiceMock.class, new Fiserv_ws_CreditAppImplMock());
		System.debug('*)*)*) entering Test callout with FA-'+fa.Financial_Account_Number__c);
		Fiserv_ws_SendCreditApp.CreditApplication(fa.Financial_Account_Number__c, '', true,true);
		Test.stopTest();
	}
    
	static void CreateData(){
		collateral = new Collateral__c(Name = 'Toyota');
		insert collateral;		
       	
        Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
      	acctCustomer = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
      	insert acctCustomer;
        Id acctDealerRT = [select Id from recordtype where sObjectType = 'Account' and name = 'Dealer' limit 1].Id;
      	acctDealer = new Account(Name = 'Test of Unit', Account_Number__c = '03043', BillingState = 'GA',recordTypeId = acctDealerRT);
      	insert acctDealer;
		
		Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
      	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, Finance_Account_Status__c = 'Open', 
						Financial_Account_Number__c = '1234567890', Dealership__c = acctDealer.Id,
          				code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
		insert fa;
		
		fac = new List<Financial_Account_Customer__c>();
      	fac.add(new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acctCustomer.Id,
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
            financial_account_customer__c = 'FAC1000'));
            
      	fac.add(new Financial_Account_Customer__c(name = 'FAC2000', financial_account__c = fa.id, account__c = acctCustomer.Id,
            Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
              Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
            Privacy_Election_Telemarketing__c='Y' ,
            financial_account_customer__c = 'FAC2000'             
            ));
		insert fac;
	}
}