@isTest
public with sharing class UC_NewCaseTestClass {

	static Collateral__c collateral;
	static Account acct;
	static Account acct2;
	static Account acct3;

	static Financial_Account__c fa;
	static Financial_Account__c fa2;
	static Financial_Account__c fa3;
	static List<Financial_Account_Customer__c> fac ;
	static List<Financial_Account_Customer__c> fac2 ;
	
    static testMethod void testFaHighlightPanel() {
    	 
      	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
    	
    	 
        PageReference pr = Page.faHighlightPanel;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        faHighlightPanel caseCtrl = new faHighlightPanel(ctrl);   
        
        // other accounts coverage (custom component)
        UC_facOtherAccountsController otherAccts = new UC_facOtherAccountsController();
        otherAccts.parms= fa.id + ';' + acct.Social_Security_Number__pc +';'+'';
        otherAccts = new UC_facOtherAccountsController();
        otherAccts.parms= fa2.id + ';'+  acct2.Social_Security_Number__pc +';'+'999999999';
        otherAccts.showTopPopup();
        otherAccts.closePopup();
        
        test.stopTest();
     	 
    }
    
    static testMethod void testMakePaymentProcess() {
    	
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseStartProcess;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        caseCtrl.startProcess();
    
        caseCtrl.cancelCase();  // coverage
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Make a Payment';
        caseCtrl.newCase.Description = 'Make a Payment Case';
        caseCtrl.newCase.payment_channel__c = 'WUSP';
        caseCtrl.setEscalationType();
        
        caseCtrl.createCase();
        
        system.debug('++++ from Test Method savedCase: ' + caseCtrl.savedCase);
        TFS_Activity__c act = new TFS_Activity__c (
        	case__c = caseCtrl.savedCase.Id,
        	description__c = '8/11/2014 5:28:25 PM Name or Company: myCompany Account Number: 001-000000 Payment Amount: $2,999.00 ' +
       	     'Payment Date: 8/11/2014 Collector ID: ASSOCTEST Transaction Confirmation Number: 1234567'
          );
        insert act;
        TFS_Activity__c testAct = [select payment_amount__c from TFS_Activity__c where id = :act.Id];
        system.assertEquals(2999.00, testAct.payment_amount__c);
        
        
        test.stopTest();
    	
    }
  
    static testMethod void testRefundProcess() {
    	
    	    	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseStartProcess;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        caseCtrl.startProcess();   
        
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Refund';
        caseCtrl.newCase.Description = 'Test Method Refund Case';
        caseCtrl.newCase.payment_channel__c = 'WUSP';
        
        caseCtrl.createCase();
        
        system.debug('++++ from Test Method savedCase: ' + caseCtrl.savedCase);
        TFS_Activity__c act = new TFS_Activity__c (
        	case__c = caseCtrl.savedCase.Id,
        	description__c = '8/11/2014 5:28:25 PM Name or Company: myCompany Account Number: 001-000000 Refund Amount: $500.00 ' +
       	     'Payment Date: 8/11/2014 Collector ID: ASSOCTEST Transaction Confirmation Number: 1234567'
          );
        insert act;
        system.debug('++++ Refund Activity from Test Method: ' + act);
        TFS_Activity__c testAct = [select case__c, Refund_Amount__c from TFS_Activity__c where case__c = :caseCtrl.savedCase.Id];
        system.assertEquals(500.00, testAct.Refund_Amount__c);
        
        
        test.stopTest();
    	
    }
    
   static testMethod void testLogComplaintProcess() {
    	
       	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        caseCtrl.logComplaint();   
        
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Payments';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.clearMessage();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();         
        
        test.stopTest();
    	
    }
   static testMethod void testEditProfile() {
    	
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
     	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseEditProfile;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.EditProfile(); 
        
        caseCtrl.cancelCase();
        test.stopTest();
     }
     
   static testMethod void testEditProfileForSCRA() {
   	
   	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	system.debug('**** acct ' + acct);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
    				financial_account_customer__c = 'FAC1000'));
    	  
    	system.debug('**** fac[0] ' + fac[0]);
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc,
    			account__r.IsPersonAccount, account__r.personContactId
    			from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/
    	User user2 = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
    	Contact  contact1 = [SELECT Id, Active_Duty_End_Date__c,Active_Duty_Start_Date__c, Service_Branch__c 
					 	FROM Contact WHERE Id =:fac[0].account__r.personContactId];
		contact1.Active_Duty_Start_Date__c = null;
    	contact1.Active_Duty_End_Date__c = Date.valueOf('2016-07-30');
    	contact1.Service_Branch__c = 'Coast Guard Reserve';
    	update contact1;

    	test.startTest();
     	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseEditProfile;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.EditProfile();
        
        System.runAs(user2){//User with SCRA Update permission set
	        Case case1 = caseCtrl.newCase; 
	        case1.Category__c = 'Customer Profile Update';
			case1.Service_Request_Type__c = 'SCRA Update';
			case1.Description = 'Test1 SCRA Update on Case';
			
			caseCtrl.getFields();
			
			System.debug('caseCtrl.contactForFAC : ' + caseCtrl.contactForFAC);
			//Setup change of contact data
			caseCtrl.contactForFAC.Active_Duty_Start_Date__c = Date.valueOf('2016-03-01');
    		caseCtrl.contactForFAC.Active_Duty_End_Date__c = Date.valueOf('2016-08-01');
    		caseCtrl.contactForFAC.Service_Branch__c = null;
			
			caseCtrl.createCase();
 		}
 		
 		//Check the acitivity to see if it is valid
    	TFS_Activity__c activity1 = [SELECT Id, New_Active_duty_start_date__c, New_Active_duty_end_date__c, New_Service_branch__c,
    					action__c, category__c, topic__c, Service_type__c
    					FROM TFS_Activity__c WHERE financial_account_customer__c =:fac[0].Id];
    	System.debug('activity1' + activity1);				
    	
    	//Validate
    	System.assertEquals(Date.valueOf('2016-08-01'), activity1.New_Active_duty_end_date__c);
    	
        test.stopTest();
   	
   }  
 
   static testMethod void testRequestDocumentation() {
    	
    	    	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
     	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseRequestDocumentation;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);
        caseCtrl.RequestDocumentation();  
        caseCtrl.selectedContact =  'Non-Signing Spouse';     
        caseCtrl.cancelCase();
        test.stopTest();
      }
 
    
   static testMethod void testPIFReturnedMail() {
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.StartProcess();
        caseCtrl.newCase.category__c = 'Title';
        caseCtrl.newCase.title__c = fa.Title__c;   //weird data model
        caseCtrl.newCase.Service_Request_Type__c = 'PIF Returned Mail';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
             
        caseCtrl.newCase.Send_To__c = 'Customer';
        caseCtrl.getFields();
        caseCtrl.newCase.Send_To__c = 'Co-borrower';
        caseCtrl.getFields();
        caseCtrl.newCase.Send_To__c = 'Originating Dealer';
        caseCtrl.getFields();
        caseCtrl.newCase.Send_To__c = '3rd Party';
        caseCtrl.getFields();
        
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
   
   static testMethod void testDirectMail() {
    	    	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.StartProcess();
        caseCtrl.newCase.category__c = 'Lease End';
        caseCtrl.newCase.Service_Request_Type__c = 'Direct Sales';
        caseCtrl.newCase.Resulting_Decision__c = 'Refer to Dealer';
        caseCtrl.newCase.Delivery_Option__c = 'Garage Address';
         caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
   
   static testMethod void testDirectSales() {
       	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.StartProcess();
        caseCtrl.newCase.category__c = 'Title';
        caseCtrl.newCase.title__c = fa.Title__c;   //weird data model
        caseCtrl.newCase.Service_Request_Type__c = 'PIF Returned Mail';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
   
   static testMethod void testReturnedMail() {
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.StartProcess();
        caseCtrl.newCase.category__c = 'Communications';
        caseCtrl.newCase.Service_Request_Type__c = 'Return Mail';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.newCase.Address_Update_Required__c = 'No';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
                       
 
   static testMethod void testDueDateChange() {
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseLogComplaint;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.StartProcess();
        caseCtrl.newCase.category__c = 'Contract Modifications';
        caseCtrl.newCase.Service_Request_Type__c = 'Due Date Change';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.newCase.Denial_Reason__c = 'Denied';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
             
                         
  static testMethod void testMisappliedPayments() {
    	
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseStartProcess;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        caseCtrl.startProcess();   
        
        
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Misapplied Payment';
        caseCtrl.newCase.Description = 'Misapplied Payment Case';
        caseCtrl.newCase.payment_channel__c = 'WUSP';
        caseCtrl.newCase.Source__c = 'Account';
        caseCtrl.newCase.Acct_Misapplied_To__c = fa.Id;
        caseCtrl.newCase.Payment_Amount__c = 1000;
        caseCtrl.newCase.Effective_Date__c = date.today().addDays(-1);
        caseCtrl.newCase.Payment_Amount1__c = 1000;
        caseCtrl.newCase.Effective_Date1__c = date.today().addDays(-1);
        caseCtrl.newCase.Apply_to_Account1__c = fa2.Id;
        caseCtrl.newCase.Payment_Amount2__c = 1000;
        caseCtrl.newCase.Effective_Date2__c = date.today().addDays(-1);
        caseCtrl.newCase.Apply_to_Account2__c = fa3.Id;
        caseCtrl.createCase();

		// cases have automatically been created.
		// Now update the Case Description so that the Activities will get updated.
		TFSC_UCCaseTriggerHandler.alreadyProcessed = false;
        Case c = caseCtrl.savedCase;
        system.debug('++++ from Test Method Case to update: ' + c);
        c.description = 'Description has been changed.';
        c.Payment_Amount__c = 2000;
        c.Effective_Date__c = date.today().addDays(-2);
        c.Payment_Amount1__c = 2000;
        c.Effective_Date1__c = date.today().addDays(-2);
        c.Payment_Amount2__c = 2000;
        c.Effective_Date2__c = date.today().addDays(-2);
        update c;
        
        // simulate status change publisher action so that activities will get updated
        CaseComment cc = new CaseComment(commentBody='The status has been changed to Resolved', parentId = c.Id);
        insert cc;
        
        test.stopTest();
    	
    }    
    
    
    
    
    static testMethod void testCaseActivitiesList() {
     	
		Id caseRecordTypeId = [select Id from recordType where sObjectType = 'Case' and developerName= 'UC_Request_Information' limit 1].Id;
		Id activityRecordTypeId = [select Id from recordType where sObjectType = 'TFS_Activity__c' and developerName= 'TFS_Activity' limit 1].Id;
		
		
    	    	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	Case c = new Case(subject = 'Any Subject', description = 'Any Description', action__c ='Request Information', category__c = 'Payments',
    						service_request_type__c = 'Sales Tax', financial_account__c = fa.id, 
    						recordTypeId = caseRecordTypeId);
    	insert c;
    	TFS_Activity__c a = new TFS_Activity__c(subject__c = 'Any Subject', description__c = 'Any Description', financial_account__c = fa.id, case__c = c.Id,
    						recordTypeId = activityRecordTypeId );
    	insert a;
    	
    	test.startTest();
    	 
        PageReference pr = Page.UC_CasesActivitiesList;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
    	UC_CasesActivitiesList ucci = new UC_CasesActivitiesList(ctrl);
     	
     	test.stopTest();
     }
  
    static testMethod void testPayoffQuote() {
        	/************************ create test data *****************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	 title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	Id acctRecordType = [select Id from recordtype where sObjectType = 'Account' and name = 'Customer' limit 1].Id;
    	
    	acct = new Account(firstName = 'John', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct;
    	
    	acct2 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='456456456');
    	insert acct2;
    	
    	acct3 = new Account(firstName = 'Mary', lastName = 'Doe',recordTypeId = acctRecordType,Social_Security_Number__pc='123123123');
    	insert acct3;
    	
    	system.debug('**** acct ' + acct);
    	system.debug('**** acct2 ' + acct2);
    	system.debug('**** acct.Social_Security_Number__pc ' + acct.Social_Security_Number__pc);
    	system.debug('**** acct2.Social_Security_Number__pc ' + acct2.Social_Security_Number__pc);
    	   
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Retail' limit 1].Id;
 
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id,  RecordTypeId=faRecordTypeId 	);
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
    				financial_account_customer__c = 'FAC3000'			));
  
    	system.debug('**** fac[0] ' + fac[0]);
    	system.debug('**** fac[1] ' + fac[1]);
    	system.debug('**** fac[2] ' + fac[2]);  
    					
    	insert fac; 
    	
    	fac = [select name,	account__r.name, financial_Account__r.name, Account__r.Social_Security_Number__pc from financial_account_customer__c];

    	system.debug('**** fac[0] ' + fac[0].name + '-' + fac[0].financial_Account__r.name +'-'+ fac[0].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[1] ' + fac[1].name + '-' + fac[1].financial_Account__r.name +'-'+ fac[1].Account__r.Social_Security_Number__pc);
    	system.debug('**** fac[2] ' + fac[2].name + '-' + fac[2].financial_Account__r.name +'-'+ fac[2].Account__r.Social_Security_Number__pc);

    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	/************************ end test data *****************************/

    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewCaseController caseCtrl = new UC_NewCaseController(ctrl);
        PageReference pr = Page.UC_NewCaseRequestInformation;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.RequestInformation();
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Payoff Quote';
        caseCtrl.newCase.Description = 'Test Method Payoff Quote Case';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact =  'Third Party';
        caseCtrl.setShowContact();
        caseCtrl.newCase.contact_name__c = 'Chris Smith';
        caseCtrl.newCase.relationship_name__c = 'Brother';
        caseCtrl.createCase(); 
        caseCtrl.resetSaveSuccessful();   // coverage
        UC_Unbound_Field_List__c uf = new UC_Unbound_Field_List__c(display_label__c='hello');
       // caseCtrl.UnboundField unboundvar = new caseCtrl.UnboundField(uf);
        test.stopTest();  
    }
             
    @testSetup 
	static void userForSCRAActivity() {
		PermissionSet ps = [SELECT Id,Name FROM PermissionSet WHERE Name = 'BK_SCRA_Fields' LIMIT 1];
		System.debug('ps : ' + ps);
		
		//Current User
		PermissionSetAssignment psa = new PermissionSetAssignment(PermissionSetId = ps.Id, AssigneeId = UserInfo.getUserId());
		insert psa;
		System.debug('psa : ' + psa);
	}
	
	@testSetup 
	static void customSettingForSCRAActivity() {
		//Create custom setting
    	List<Service_Request_Field_Map__c> contactSRMapCSListToInsert = new List<Service_Request_Field_Map__c>();

		Service_Request_Field_Map__c contactSRCS = new Service_Request_Field_Map__c(Name = 'Active_Duty_End_Date__c', 
													Source_Field__c = 'Active_Duty_End_Date__c',
													Source_Object__c = 'Contact',											
		                                            Target_Field__c = 'New_Active_duty_end_date__c', 
													Target_Object__c = 'TFS_Activity__c',
													Target_Field_Old__c = 'Current_Active_duty_end_date__c',
													Record_Type__c = 'Customer_Profile_Change', 
													Type__c = 'BK/SCRA Update', 
													Group__c =1.0, 
													Conversion_Type__c = '',
													Address_Type__c = '', 
													Service_Request_Category__c = 'General Customer Inquiry', 
													Service_Result__c = 'Provided Info/Documented Acct',
													Consent_Validation__c = false
													);
		contactSRMapCSListToInsert.add(contactSRCS);		
		contactSRCS = new Service_Request_Field_Map__c(Name = 'Active_Duty_Start_Date__c', 
													Source_Field__c = 'Active_Duty_Start_Date__c',
													Source_Object__c = 'Contact',											
		                                            Target_Field__c = 'New_Active_duty_start_date__c', 
													Target_Object__c = 'TFS_Activity__c',
													Target_Field_Old__c = 'Current_Active_duty_start_date__c',
													Record_Type__c = 'Customer_Profile_Change', 
													Type__c = 'BK/SCRA Update', 
													Group__c = 1.0, 
													Conversion_Type__c = '',
													Address_Type__c = '', 
													Service_Request_Category__c = 'General Customer Inquiry', 
													Service_Result__c = 'Provided Info/Documented Acct',
													Consent_Validation__c = false
													);													
		contactSRMapCSListToInsert.add(contactSRCS);		
		contactSRCS = new Service_Request_Field_Map__c(Name = 'Service_Branch__c', 
													Source_Field__c = 'Service_Branch__c',
													Source_Object__c = 'Contact',											
		                                            Target_Field__c = 'New_Service_branch__c', 
													Target_Object__c = 'TFS_Activity__c',
													Target_Field_Old__c = 'Current_Service_branch__c',
													Record_Type__c = 'Customer_Profile_Change', 
													Type__c = 'BK/SCRA Update', 
													Group__c = 1.0, 
													Conversion_Type__c = '',
													Address_Type__c = '', 
													Service_Request_Category__c = 'General Customer Inquiry', 
													Service_Result__c = 'Provided Info/Documented Acct',
													Consent_Validation__c = false
													);												
		contactSRMapCSListToInsert.add(contactSRCS);		
		insert contactSRMapCSListToInsert;
	}    
}