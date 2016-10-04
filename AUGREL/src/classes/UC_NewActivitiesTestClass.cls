@isTest
public with sharing class UC_NewActivitiesTestClass {
  

	static Collateral__c collateral;
	static Account acct;
	static Account acct2;
	static Financial_Account__c fa;
	static Financial_Account__c fa2;
	static Financial_Account__c fa3;
	static List<Financial_Account_Customer__c> fac ;
	static List<Financial_Account_Customer__c> fac2 ;
	static Case parentCase;
	
    /* Note: References to "newCase" in this class are actually a TFS_Activity__c in the controller */
    
    static testMethod void testCallToAction() {
        /********************** create data *********************/
     	
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
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
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
      	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase; 	
    	
          

        /*******************************************************/
        
        
    	test.startTest();
    	
        PageReference pr = Page.UC_NewActivityCallToAction;
        pr.getParameters().put('Id',fa.Id);
        Test.setCurrentPage(pr);     
        ApexPages.StandardController ctrl = new ApexPages.StandardController(fa);
        UC_NewActivityController actCtrl = new UC_NewActivityController(ctrl);
        
        actCtrl.CallToAction();
    
        actCtrl.cancelCase();  // coverage
        actCtrl.newCase.category__c = 'Programs';
        actCtrl.newCase.Service_Request_Type__c = 'College Rebate Exceptions';
        actCtrl.newCase.Description__c = 'College Rebate';
        actCtrl.selectedContact = 'Co-Borrower';
        actCtrl.clearMessage();   // coverage
        actCtrl.setShowContact();
        
        actCtrl.createCase();
        
        
        test.stopTest();
    	
    }
  
     static testMethod void testRelatedActivity() {
    	
       /********************** create data *********************/
     	
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
    	
    	Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
    	fa = new Financial_Account__c(name = 'FA', collateral__c = collateral.Id, title__c = t1.id, Finance_Account_Status__c = 'Close',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
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
      	
    	Id recordTypeId = [select Id from recordType where sObjectType = 'Case' and name = 'UC - Request Information' limit 1].Id;
     	parentCase = new Case(financial_account__c = fa.Id, financial_account_customer__c = fac[0].Id,  action__c='Request Information', category__c='Fees', 
    				service_request_type__c = 'Disposition Fee',service_type__c='Inbound Call', Description = 'Description', recordTypeId = recordTypeId);
    	insert parentCase; 	
    	
         /*******************************************************/
    	test.startTest();
        PageReference pr = Page.UC_NewRelatedActivity;
        pr.getParameters().put('Id',parentCase.Id);
        Test.setCurrentPage(pr);   
    	
        ApexPages.StandardController ctrl = new ApexPages.StandardController(ParentCase);
        UC_NewRelatedActivityController actCtrl = new UC_NewRelatedActivityController(ctrl);
        
        actCtrl.checkRecordType();
        actCtrl.clearMessage();
        actCtrl.cancelCase();
        actCtrl.newCase.Description__c = 'An Activity';
        actCtrl.createCase();
        
        List <TFS_Activity__c> acts = [select Id from TFS_Activity__c];
        delete acts;
         
        
        //additional coverage
  
        actCtrl.fac = fac[0];
        actCtrl.isActivity = true;
        actCtrl.sessionInfo = 'test';
        actCtrl.action = 'test';
        List<Financial_Account_Customer__c> acctsToDelete = [select Id from Financial_Account_Customer__c];
        delete acctsToDelete;
        
        
        ctrl = new ApexPages.StandardController(ParentCase);
        actCtrl = new UC_NewRelatedActivityController(ctrl);
        
        actCtrl.resetSaveSuccessful();
        actCtrl.newCase = new TFS_Activity__c();
        actCtrl.insertCase();    //error
        
        test.stopTest();
    	
    }
     
}