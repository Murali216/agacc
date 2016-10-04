/**
	* UC_NewCase_SendToTest - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private class UC_NewCase_SendToTest {
	static Collateral__c collateral;
    
	static title__c t1;
	
	static Account acct;
	static Account acctDealer;
    
    static Financial_Account__c fa;
    static Financial_Account_Customer__c facPrimary;
    static Financial_Account_Customer__c facCo;
	    
    static Case testCase;
	
	static testMethod void testPrimary() {
        createBaseData();
        test.startTest();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = facPrimary.id, Service_Recipient__c = 'Borrower/Customer', 
                        Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                        Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                        Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', 
						Send_To__c = 'Customer', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		UC_NewCase_SendTo st = new UC_NewCase_SendTo(testCase, facPrimary, facCo, FA);
		st.FillAddress();
		test.stopTest();
	}
	static testMethod void testCo() {
        createBaseData();
        test.startTest();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = facCo.id, Service_Recipient__c = 'Borrower/Customer', 
                        Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                        Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                        Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', 
						Send_To__c = 'Co-borrower', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		UC_NewCase_SendTo st = new UC_NewCase_SendTo(testCase, facPrimary, facCo, FA);
		st.FillAddress();
		test.stopTest();
	}
	static testMethod void testDealer() {
        createBaseData();
        test.startTest();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = facPrimary.id, Service_Recipient__c = 'Borrower/Customer', 
                        Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                        Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                        Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', 
						Send_To__c = 'Originating Dealer', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		UC_NewCase_SendTo st = new UC_NewCase_SendTo(testCase, facPrimary, facCo, FA);
		st.FillAddress();
		test.stopTest();
	}
	
    static void createBaseData() {
		collateral = new Collateral__c(Name = 'Toyota');
		insert collateral;
		      	
        Id acctCustRT = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
        Id acctDealerRT = [select Id from recordtype where sObjectType = 'Account' and name = 'Dealer' limit 1].Id;
      
      	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctCustRT, Social_Security_Number__pc='123123123');
      	insert acct;
      	acctDealer = new Account(Name = 'Dealer', recordTypeId = acctDealerRT);
      	insert acctDealer;
      
      	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
      	insert acctStatus;
      
      	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
      	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, Finance_Account_Status__c = 'Open',
          	code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', Dealership__c = acctDealer.Id, RecordTypeId=faRecordTypeId);
      	insert fa;
		      
      	facPrimary = new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id,
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
            financial_account_customer__c = 'FAC1000');
      	insert facPrimary; 
            
      	facCo = new Financial_Account_Customer__c(name = 'FAC2000', financial_account__c = fa.id, account__c = acct.Id,
            Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
              Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
            Privacy_Election_Telemarketing__c='Y' ,
            financial_account_customer__c = 'FAC2000'             
            );
      	insert facCo;              
      
      	facPrimary = [select name,  account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c where name = 'FAC1000'];
		facCo = [select name,  account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c where name = 'FAC2000'];
    }
}