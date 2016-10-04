@isTest
private class UC_RelatedCaseTestMethods {

	static Collateral__c collateral;
	static Account acct;
	static Account acct2;
	static Financial_Account__c fa;
	static Financial_Account__c fa2;
	static Financial_Account__c fa3;
	static List<Financial_Account_Customer__c> fac ;
	static List<Financial_Account_Customer__c> fac2 ;
	static Case parentCase;
	
    static testMethod void testActivityCasesList(){
		    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
		test.startTest();
		RecordType useRecordType = [Select Name, Id from RecordType WHERE Name = 'UC - Title Release' limit 1];
        Case testCase = new Case(Financial_Account__c = fa.id, Financial_Account_Customer__c = fac.get(0).id, Service_Recipient__c = 'Borrower/Customer', 
                           Service_Type__c='Inbound Call', Contact_Name__c = 'testing person', PIF_Group__c = 'Retail Portal', Title__c = fa.Title__c,
                           Status = 'In Process', Action__c = 'Start Process', Category__c = 'Title', Service_Request_Type__c = 'PIF Release', 
                           Admin_Group__c = 'Default',Subject = 'Title - PIF Release', Description = 'testing update functionality', RecordTypeId = useRecordType.id);
		
		System.debug('*** using this Case: '+testCase);
        UC_CasesActivitiesList cont = new UC_CasesActivitiesList(new ApexPages.StandardController(fa));
        PageReference pr = Page.UC_CasesActivitiesList;
        Test.setCurrentPage(pr); 
		
		cont.LoadCasesAndActivities();
		cont.LoadArchivedSRs();
		cont.LoadSysEvents();		
		
		test.stopTest();
	}
	
    static testMethod void testMakePaymentProcess() {
    	
        	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr);     
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
    
        caseCtrl.cancelCase();  // coverage
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Make a Payment';
        caseCtrl.newCase.Description = 'Make a Payment Case';
        caseCtrl.newCase.payment_channel__c = 'WUSP';
        
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
    	
        	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();  
        
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Refund';
        caseCtrl.newCase.Description = 'Test Method Refund Case';
        caseCtrl.newCase.payment_channel__c = 'WUSP';   
        caseCtrl.setEscalationType();
        
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
    	
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr);    
        caseCtrl.newCase.Action__c = 'Log Complaint';
        caseCtrl.updateAction();
        
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
    	
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
     	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Edit Profile';
        caseCtrl.updateAction();
        
        caseCtrl.cancelCase();
        test.stopTest();
     }
 
   static testMethod void testRequestDocumentation() {
    	
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
     	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr);
        caseCtrl.newCase.Action__c = 'Request Documentation';
        caseCtrl.updateAction();
        
        caseCtrl.selectedContact =  'Non-Signing Spouse';     
        caseCtrl.cancelCase();
        test.stopTest();
      }
 
   static testMethod void testPayoffQuote() {
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Request Information';
        caseCtrl.updateAction();
        
        
        caseCtrl.newCase.category__c = 'Payments';
        caseCtrl.newCase.Service_Request_Type__c = 'Payoff Quote';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
    
   static testMethod void testPIFReturnedMail() {
        	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
        
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
   
   static testMethod void testDirectMail() {
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
        caseCtrl.newCase.category__c = 'Lease End';
        caseCtrl.newCase.Service_Request_Type__c = 'Direct Sales';
        caseCtrl.newCase.Resulting_Decision__c = 'Refer to Dealer';
        caseCtrl.newCase.Delivery_Option__c = 'Garage Address';
        caseCtrl.newCase.Send_To__c = '111 Elm Stab';
        caseCtrl.newCase.Description = 'Test Method Log Complaint Case';
        caseCtrl.getFields();
        caseCtrl.setObjectType();    // coverage
        caseCtrl.checkRecordType();    // coverage
        caseCtrl.selectedContact = 'Co-Borrower';
        caseCtrl.setShowContact();
        caseCtrl.createCase();  
        test.stopTest();
    }
   
   static testMethod void testDirectSales() {
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
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
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
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
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr); 
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
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
    	
    	    	/***************************** create test data **************************/
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	title__c t1 = new Title__c(title_status__c = 'Held', collateral__c = collateral.id);
    	insert t1;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	UC_Account_Status__c acctStatus = new UC_Account_Status__c(name='1000', Icon__c = 'Green', Salesforce_Message__c='test');
    	insert acctStatus;
    	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=recordTypeId);
    	insert fa;
    	
    	
    	t1.title_status__c = 'whatever';
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id 	);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id, title__c = t1.id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE' ));
    				
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE',
			      	Privacy_Election_Third_Party_Sharing__c='Y' , Privacy_Election_Affiliate_Marketing__c='Y' , Privacy_Election_Dealership__c='Y'  ,
			    	Privacy_Election_Telemarketing__c='Y'  , Flag_Office_Of_Foreign_Asset_Control__c='Y', Privacy_Election_Affiliate_Sharing__c='Y' ,
			    	Privacy_Election_FCRA_Sharing__c='Y'   				
    				
    				));
    	insert fac; 
    	
    	UC_Unbound_Field_List__c ub = new UC_Unbound_field_List__c (Name='1',display_label__c = 'unbound', action__c='Start Process', category__c = 'Lease End',
    	     Topic__c = 'Direct Sales');
    	insert ub;           // used for Direct Sales test
    	
    	string faId = fa.id;
    	faId = faId.substring(0,15);
    	tempInteraction__c ti = new tempInteraction__c(name = faId, Interaction_Type__c = 'Inbound Call', ani__c='9999999999');
    	insert ti;
    	
    	recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase;
    	
    	/***************************** End test data **************************/
    	test.startTest();
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedCaseController caseCtrl = new UC_NewRelatedCaseController(ctrl);
        PageReference pr = Page.UC_NewRelatedCase;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr);   
        caseCtrl.newCase.Action__c = 'Start Process';
        caseCtrl.updateAction();
        
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


   
}