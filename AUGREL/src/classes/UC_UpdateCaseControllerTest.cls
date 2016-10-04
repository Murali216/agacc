/**
	* UC_UpdateCaseControllerTest - <description>
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private  class UC_UpdateCaseControllerTest {
	static Collateral__c collateral;
    
	static title__c t1;
	
	static Account acct;
    static Account acct2;
    static Account acct3;
    
    static Financial_Account__c fa;
    static Financial_Account__c fa2;
    static Financial_Account__c fa3;
    static List<Financial_Account_Customer__c> fac ;
    static List<Financial_Account_Customer__c> fac2 ;
	
	static UC_Title_Update_Est_Mailing__c mailRule1;
	static UC_Title_Update_Est_Mailing__c mailRule2;
	static UC_Title_Update_Est_Mailing__c mailRule3;
    
    static Case testCase;
    
    static testmethod void UpdatePIFTitleCase(){
        createBaseData();
        test.startTest();
		t1.Financial_Account__c = fa.Id;
		update t1;
		
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
        testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = fac.get(0).id, Service_Recipient__c = 'Borrower/Customer', 
                           Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                           Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                           Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', RecordTypeId = useRecordType.id);
		System.debug('*** new Case: '+testCase);
      	insert testCase;
		
        // open VF page
        UC_UpdateCaseController cont = new UC_UpdateCaseController(new ApexPages.StandardController(testCase));
		
        PageReference updateCasePage = Page.UC_UpdateCaseTitle;
        Test.setCurrentPage(updateCasePage);
		cont.updateTitle();
		// populate fields
		cont.thisCase.Payoff_Date__c = Date.today();
		cont.thisCase.Payoff_Method__c = 'Certified';
		cont.thisCase.Send_To__c = 'Customer';
		cont.thisCase.Authorization_Received__c = 'No';
		// test est. mailing
		cont.thisTitle.Title_State__c='FL';
		cont.CalcEstMailingDate();
		
		cont.thisTitle.Hold_Reason__c = 'Not Within Maturity';
		cont.CalcEstMailingDate();
		
		cont.thisTitle.Hold_Reason__c = 'Not Within Maturity';
		cont.thisTitle.Title_State__c = 'UT';
		cont.CalcEstMailingDate();
			
        // update case
		cont.cancelCase();
		cont.SendToUpdate();
		PageReference updatedCase = cont.updateCase();
        // verify results
        test.stopTest();
    }
    
    
    static void createBaseData() {
		collateral = new Collateral__c(Name = 'Toyota');
		insert collateral;
		
       	t1 = new Title__c(title_status__c = 'Held', Hold_Reason__c = 'Band2 Review', collateral__c = collateral.id);
      	insert t1;
      	
        Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
      
      	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
      	insert acct;
      
      	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
      	insert acct2;
      
      	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
      	insert acct3;
      
      	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
      	insert acctStatus;
      
      	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
      	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, Title__c = t1.id, Finance_Account_Status__c = 'Open',
          	code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
      	insert fa;
      	System.debug('*** the first FA: '+fa);
      	t1.title_status__c = 'whatever';
      	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId   );
      	insert fa2;
      
      	fa3 = new Financial_Account__c(name = 'FA3', collateral__c = collateral.Id, RecordTypeId=faRecordTypeId);
      	insert fa3;
      
      	fac = new List<Financial_Account_Customer__c>();
      	fac.add(new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id,
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
            financial_account_customer__c = 'FAC1000'));
            
      	fac.add(new Financial_Account_Customer__c(name = 'FAC2000', financial_account__c = fa.id, account__c = acct2.Id,
            Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
              Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
            Privacy_Election_Telemarketing__c='Y' ,
            financial_account_customer__c = 'FAC2000'             
            ));

      	// create second acct for John Doe      
      	fac.add(new Financial_Account_Customer__c(name = 'FAC3000', financial_account__c = fa2.id, account__c = acct.Id,
            Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
            financial_account_customer__c = 'FAC3000'));
  
      	system.debug('**** fac[0] ' + fac[0]);
      	system.debug('**** fac[1] ' + fac[1]);
      	system.debug('**** fac[2] ' + fac[2]);  
              
      	insert fac; 
      
      	fac = [select name,  account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

      	mailRule1 = new UC_Title_Update_Est_Mailing__c(Name = 'rule 1', hold_reason__c = 'Band2 Review', Days_to_Add__c = 10.0, Title_State__c = 'FL');
		insert mailRule1;
      	mailRule2 = new UC_Title_Update_Est_Mailing__c(Name = 'rule 2', hold_reason__c = 'Not Within Maturity', Days_to_Add__c = 9.0, Title_State__c = 'UT');
		insert mailRule2;
      	mailRule3 = new UC_Title_Update_Est_Mailing__c(Name = 'rule 3', hold_reason__c = 'Not Within Maturity', Days_to_Add__c = 7.0, Title_State__c = '');
		insert mailRule3;
    }
}