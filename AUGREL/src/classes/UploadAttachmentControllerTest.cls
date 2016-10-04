@isTest
private class UploadAttachmentControllerTest {
	static Collateral__c collateral;
    	
	static Account acct;
    
    static Financial_Account__c fa;
    static List<Financial_Account_Customer__c> fac ;
    
    static Case testCase;
	
	static testMethod void uploadTest() {
		Test.startTest();
		// create test case
		CreateBaseData();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
		System.debug('*** fa.id:'+fa.id);
		System.debug('*** fac.get(0).id:'+fac.get(0).id);
		System.debug('*** useRecordType.id'+useRecordType.id);
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = fac.get(0).id, Service_Recipient__c = 'Borrower/Customer', 
                           Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                           Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                           Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		
		// open VF page
        UploadAttachmentController cont = new UploadAttachmentController(new ApexPages.StandardController(testCase));		
        PageReference updateCasePage = Page.UC_UpdateCaseTitle;
        Test.setCurrentPage(updateCasePage);
		
		// test operations
		//create test doc
		Document td = new Document();
		td.name = 'Test';
		td.body = Blob.valueOf('test body');
		// set values
		cont.fileName = 'test file';
		cont.fileBody = Blob.valueOf('test body');
		cont.strPrintedDate = Date.today();
		cont.strStatus = 'Print Immediately (w/o Title/Lien Release)';
		// call functions
		PageReference pr = cont.processUpload();
		
		Test.stopTest();
	}
	
	static testMethod void uploadTestFail() {
		Test.startTest();
		// create test case
		CreateBaseData();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
		System.debug('*** fa.id:'+fa.id);
		System.debug('*** fac.get(0).id:'+fac.get(0).id);
		System.debug('*** useRecordType.id'+useRecordType.id);
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = fac.get(0).id, Service_Recipient__c = 'Borrower/Customer', 
                           Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                           Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                           Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		
		// open VF page
        UploadAttachmentController cont = new UploadAttachmentController(new ApexPages.StandardController(testCase));		
        PageReference updateCasePage = Page.UC_UpdateCaseTitle;
        Test.setCurrentPage(updateCasePage);
		
		
		// call functions
		PageReference pr = cont.processUpload();
		
		Test.stopTest();
	}
	
	static void CreateBaseData(){
		collateral = new Collateral__c(Name = 'Toyota');
		insert collateral;
      	
        Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
      
      	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
      	insert acct;
      
      	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
      	insert acctStatus;
      
      	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
      	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, Finance_Account_Status__c = 'Open',
          	code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
      	insert fa;
      	      
      	fac = new List<Financial_Account_Customer__c>();
      	fac.add(new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id,
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
            financial_account_customer__c = 'FAC1000'));
              
      	insert fac; 
		
		fac = [select name,  account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];
	}
}