@isTest
private class UC_TestMethods {

	static Collateral__c collateral;
	static Account acct;
	static Account acct2;
	static Financial_Account__c fa;
	static Financial_Account__c fa2;
	static Financial_Account__c fa3;
	static List<Financial_Account_Customer__c> fac ;
	
    static testMethod void testFaHighlightPanel() {
    	 
    	createBaseData();
    	test.startTest();
    	
    	 
        PageReference pr = Page.faHighlightPanel;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr); 
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        faHighlightPanel caseCtrl = new faHighlightPanel(ctrl);   
        
        test.stopTest();
    	
    }
    
    static testMethod void testMakePaymentProcess() {
    	
    	createBaseData();
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
    	
    	createBaseData();
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
    	
    	createBaseData();
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
       
  static testMethod void testMisappliedPayments() {
    	
    	createBaseData();
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
		
		
    	createBaseData();
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
  
  
    static void createBaseData() {
    	
    	collateral = new Collateral__c(name = 'Toyota');
    	insert collateral;
    	
    	acct = new Account(name = 'John Doe');
    	insert acct;
    	
    	acct2 = new Account(name = 'Mary Doe');
    	insert acct2;
    	
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id);
    	insert fa;
    	
    	fa2 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id);
    	insert fa2;
    	
    	fa3 = new Financial_Account__c(name = 'FA2', collateral__c = collateral.Id);
    	insert fa3;
    	
    	fac = new List<Financial_Account_Customer__c>();
    	fac.add(new Financial_Account_Customer__c(name = 'FAC1', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE'));
    	fac.add(new Financial_Account_Customer__c(name = 'FAC2', financial_account__c = fa.id, account__c = acct2.Id,
    				Customer_Role_Type__c = '6-Co-Borrower', Borrower_Position__c = 'Co-X', Borrower_Status__c='ACTIVE'));
    	insert fac; 
    	
    }
    
   
}