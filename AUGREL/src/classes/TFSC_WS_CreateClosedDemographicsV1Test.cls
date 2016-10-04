@isTest
private class TFSC_WS_CreateClosedDemographicsV1Test {
	static Collateral__c collateral;
    
	static title__c t1;
	
	static Account acct;
    
    static Financial_Account__c fa;
    static Financial_Account_Customer__c fac ;
	
	static testMethod void myUnitTest() {
		createBaseData();
		LIST<account> testAcc = new LIST<account>();
		testAcc.add(acct);
		LIST<Title__c> testTitle = new LIST<Title__c>();
		testTitle.add(t1);
        
        Test.startTest();
        	
    	TFSC_WS_CreateClosedDemographicsV1.CreateUpdateDemographicsRequest req = new TFSC_WS_CreateClosedDemographicsV1.CreateUpdateDemographicsRequest(); 
		TFSC_WS_CreateClosedDemographicsV1.DemographicsAndCollateralDetails dcd = new TFSC_WS_CreateClosedDemographicsV1.DemographicsAndCollateralDetails();
		
		dcd.operation = TFSC_WS_CreateClosedDemographicsV1.operation.CREATE;
		dcd.financialAccount = fa;
		dcd.modifyFinancialAccount = false;
		dcd.financialAccountCustomer = fac;
		dcd.modifyFinancialAccountCustomer = false;
		dcd.collateral = collateral;
		dcd.modifyCollateral = false;
		LIST<TFSC_WS_CreateClosedDemographicsV1.DemographicsAndCollateralDetails> dcds = new list<TFSC_WS_CreateClosedDemographicsV1.DemographicsAndCollateralDetails>();
		dcds.add(dcd);
		
    	req.account = testAcc;
		req.title = testTitle;
		req.modifyAccount = false;
		req.demographicsAndCollateralDetails = dcds;
		
		System.debug('+*+*+ fac.Financial_Account__r.Financial_Account_Number__c: '+fac.Financial_Account__r.Financial_Account_Number__c);
		
        TFSC_WS_CreateClosedDemographicsV1.createUpdateDemographics(req);
            
        Test.stopTest();
	}
    static void createBaseData() {
		collateral = new Collateral__c(Name = '4T1BE32KX6U714628', Vehicle_Identification_Number__c = '4T1BE32KX6U714628', make__c = 'Toyota', model_name__c = 'camry');
		insert collateral;
		
       	t1 = new Title__c(title_status__c = 'Held', Hold_Reason__c = 'Band2 Review', collateral__c = collateral.id, Legacy_ID__c='1324');
      	insert t1;
      	
        Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
      
      	acct = new Account(Account_Number__c='1234567890', Universal_Customer_Id__c='1234567890', firstName = 'John', lastName = 'Doe', recordTypeId = acctRecordType, Social_Security_Number__pc='123123123');
      	insert acct;
            
      	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
      	insert acctStatus;
      
      	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
      	fa = new Financial_Account__c(name = 'FA', Title__c = t1.id, Finance_Account_Status__c = 'Open', Financial_Account_Number__c = '1234567890', Collateral__c = collateral.Id,
          	code_edit_message__c = '1000', branch__c = acct.Id, type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
      	insert fa;
		fa = [select name, Title__c, Finance_Account_Status__c, Financial_Account_Number__c, code_edit_message__c, branch__c, type_code_description__c, Collateral__r.Vehicle_Identification_Number__c, RecordTypeId from Financial_Account__c where name = 'FA'];
		
      	System.debug('*** the first FA: '+fa);
      
      	fac = new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id, Universal_Customer_Id__c = '1234567890',
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE', Marketing_Email__c = 'me@msn.com',
            financial_account_customer__c = '1234567890');            
              
      	insert fac; 
		fac = [select name, financial_account__c, account__c, Universal_Customer_Id__c, Financial_Account__r.Financial_Account_Number__c, Customer_Role_Type__c, Borrower_Position__c, Borrower_Status__c, Marketing_Email__c from financial_account_customer__c where name = 'FAC1000' LIMIT 1];
		
		System.debug('+*+*+ fac.Financial_Account__r.Financial_Account_Number__c: '+fac.Financial_Account__r.Financial_Account_Number__c);
    }
}