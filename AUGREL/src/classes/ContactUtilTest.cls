@isTest
public class ContactUtilTest{
	static Collateral__c collateral;
	static Account acct;
	static Financial_Account__c fa;
	static Financial_Account_Customer__c fac;
	
	static testMethod void scraActivityTest() {
		//Get the objects
		User user2 = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
		
		Financial_Account__c fa1 = [SELECT name, collateral__c, title__c, Finance_Account_Status__c,
								code_edit_message__c, type_code_description__c, RecordTypeId 
								FROM Financial_Account__c WHERE Name = 'FA'];
								
		Financial_Account_Customer__c fac1 = [		
				select Id, Name, Account__c, Account__r.LastName, Account__r.FirstName, Account__r.Name, 
					Account__r.IsPersonAccount, account__r.personContactId, Borrower_Position__c, 
					Financial_Account_Customer__c, Account__r.Social_Security_Number__pc, Customer_Full_Name__c		
				from financial_account_customer__c where name = 'FAC1000'];
    				
		Contact  contact1 = [SELECT Id, Active_Duty_End_Date__c,Active_Duty_Start_Date__c, Service_Branch__c 
					 	FROM Contact WHERE Id =:fac1.account__r.personContactId];
    	
    	//Setup Contact
    	contact1.Active_Duty_Start_Date__c = null;
    	contact1.Active_Duty_End_Date__c = Date.valueOf('2016-07-30');
    	contact1.Service_Branch__c = 'Coast Guard Reserve';
    	update contact1;
    	
    	System.debug('**** contact1 ' + contact1);
    	
    	Schema.DescribeSObjectResult obj = Schema.SObjectType.Case;   
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        Id caseRTId = caseRecordTypeMap.get('UC - Edit Profile').getRecordTypeId();
        
		Test.startTest();
		
		Case case1 = new Case(Financial_Account__c = fa1.Id, recordTypeId= caseRTId, status='New', action__c = 'Edit Profile',
                Service_Type__c='Inbound Call', Number_of_LME_s__c = '1',Requesting_location__c='CSC', 
                Financial_Account_Customer__c = fac1.Id, contact_name__c = fac1.Customer_Full_Name__c);
 		
 		System.runAs(user2){//User with SCRA Update permission set
	        case1.Category__c = 'Customer Profile Update';
			case1.Service_Request_Type__c = 'SCRA Update';
			case1.Description = 'Test1 SCRA Update on Case';
			insert case1;
 		}
 			
 		//Setup new contact to compare after change
		Contact contact1AfterChange = contact1.clone(false, true);
		contact1AfterChange.Active_Duty_Start_Date__c = Date.valueOf('2016-03-01');
    	contact1AfterChange.Active_Duty_End_Date__c = Date.valueOf('2016-08-01');
    	contact1AfterChange.Service_Branch__c = null;
    	
    	//Call the method to test
    	ContactUtil.createContactRelatedUCActivity(contact1, contact1AfterChange, case1, fa1, fac1);
    	
    	//Check the acitivity to see if it is valid
    	TFS_Activity__c activity1 = [SELECT Id, New_Active_duty_start_date__c, New_Active_duty_end_date__c, New_Service_branch__c,
    					action__c, category__c, topic__c, Service_type__c
    					FROM TFS_Activity__c WHERE financial_account_customer__c =:fac1.Id];
    	System.debug('activity1' + activity1);				
    	
    	//Validate
    	System.assertEquals(Date.valueOf('2016-08-01'), activity1.New_Active_duty_end_date__c);
    	System.assertEquals(case1.service_request_type__c, activity1.topic__c);
	 
	 	Test.stopTest();
	}
	
	static testMethod void scraInvalidTopicTest() {
		//Get the objects
		User user2 = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
		
		Financial_Account__c fa1 = [SELECT name, collateral__c, title__c, Finance_Account_Status__c,
								code_edit_message__c, type_code_description__c, RecordTypeId 
								FROM Financial_Account__c WHERE Name = 'FA'];
								
		Financial_Account_Customer__c fac1 = [select Id, Name, Account__c, Account__r.LastName, Account__r.FirstName, Account__r.Name, 
					Account__r.IsPersonAccount, account__r.personContactId, Borrower_Position__c, 
					Financial_Account_Customer__c, Account__r.Social_Security_Number__pc, Customer_Full_Name__c
    				from financial_account_customer__c where name = 'FAC1000'];
    				
		Contact  contact1 = [SELECT Id, Active_Duty_End_Date__c,Active_Duty_Start_Date__c, Service_Branch__c 
					 	FROM Contact WHERE Id =:fac1.account__r.personContactId];
    	
    	//Setup Contact
    	contact1.Active_Duty_Start_Date__c = null;
    	contact1.Active_Duty_End_Date__c = Date.valueOf('2016-07-30');
    	contact1.Service_Branch__c = 'Coast Guard Reserve';
    	update contact1;
    	
    	System.debug('**** contact1 ' + contact1);
    	
    	Schema.DescribeSObjectResult obj = Schema.SObjectType.Case;   
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        Id caseRTId = caseRecordTypeMap.get('UC - Edit Profile').getRecordTypeId();
        
		Test.startTest();
		
		Case case1 = new Case(Financial_Account__c = fa1.Id, recordTypeId= caseRTId, status='New', action__c = 'Edit Profile',
                Service_Type__c='Inbound Call', Number_of_LME_s__c = '1',Requesting_location__c='CSC', 
                Financial_Account_Customer__c = fac1.Id, contact_name__c = fac1.Customer_Full_Name__c);
 		
 		System.runAs(user2){//User with SCRA Update permission set
	        case1.Category__c = 'Customer Profile Update';
			case1.Service_Request_Type__c = 'SCRA Update INVALID';//***** Bad Topic
			case1.Description = 'Test1 SCRA Update on Case';
			insert case1;
 		}
 			
 		//Setup new contact to compare after change
		Contact contact1AfterChange = contact1.clone(false, true);
		contact1AfterChange.Active_Duty_Start_Date__c = Date.valueOf('2016-03-01');
    	contact1AfterChange.Active_Duty_End_Date__c = Date.valueOf('2016-08-01');
    	contact1AfterChange.Service_Branch__c = null;
    	
    	//Call the method to test
    	ContactUtil.createContactRelatedUCActivity(contact1, contact1AfterChange, case1, fa1, fac1);
    	
    	//Check the acitivity to see if it is valid
    	TFS_Activity__c activity1 = null;
    	try{
	    	activity1 = [SELECT Id, New_Active_duty_start_date__c, New_Active_duty_end_date__c, New_Service_branch__c,
	    					action__c, category__c, topic__c, Service_type__c
	    					FROM TFS_Activity__c WHERE financial_account_customer__c =:fac1.Id];
    	}catch (Exception e){
    		System.debug('System.QueryException: List has no rows for assignment to SObject');
    	}
    	
    	System.debug('activity1' + activity1);				
    	
    	//Validate
    	System.assertEquals(null, activity1);
	 
	 	Test.stopTest();
	}
	
	static testMethod void scraInvalidInputActivityTest() {
		//Get the objects
		User user2 = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
		
		Financial_Account__c fa1 = [SELECT name, collateral__c, title__c, Finance_Account_Status__c,
								code_edit_message__c, type_code_description__c, RecordTypeId 
								FROM Financial_Account__c WHERE Name = 'FA'];
								
		Financial_Account_Customer__c fac1 = [select Id, Name, Account__c, Account__r.LastName, Account__r.FirstName, Account__r.Name, 
					Account__r.IsPersonAccount, account__r.personContactId, Borrower_Position__c, 
					Financial_Account_Customer__c, Account__r.Social_Security_Number__pc, Customer_Full_Name__c
    				from financial_account_customer__c where name = 'FAC1000'];
    				
		Contact  contact1 = [SELECT Id, Active_Duty_End_Date__c,Active_Duty_Start_Date__c, Service_Branch__c 
					 	FROM Contact WHERE Id =:fac1.account__r.personContactId];
    	
    	//Setup Contact
    	contact1.Active_Duty_Start_Date__c = null;
    	contact1.Active_Duty_End_Date__c = Date.valueOf('2016-07-30');
    	contact1.Service_Branch__c = 'Coast Guard Reserve';
    	update contact1;
    	
    	System.debug('**** contact1 ' + contact1);
    	
    	Schema.DescribeSObjectResult obj = Schema.SObjectType.Case;   
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        Id caseRTId = caseRecordTypeMap.get('UC - Edit Profile').getRecordTypeId();
        
		Test.startTest();
		
		Case case1 = new Case(Financial_Account__c = fa1.Id, recordTypeId= caseRTId, status='New', action__c = 'Edit Profile',
                Service_Type__c='Inbound Call', Number_of_LME_s__c = '1',Requesting_location__c='CSC', 
                Financial_Account_Customer__c = fac1.Id, contact_name__c = fac1.Customer_Full_Name__c);
 		
 		System.runAs(user2){//User with SCRA Update permission set
	        case1.Category__c = 'Customer Profile Update';
			case1.Service_Request_Type__c = 'SCRA Update';
			case1.Description = 'Test1 SCRA Update on Case';
			insert case1;
 		}
 			
 		//Setup new contact to compare after change
		Contact contact1AfterChange = contact1.clone(false, true);
		contact1AfterChange.Active_Duty_End_Date__c = Date.valueOf('2016-08-01'); //******* Change of Value
    	//*********** REST of the 2 field value remains the change, one is null & other one is same value
    	
    	//Call the method to test
    	ContactUtil.createContactRelatedUCActivity(contact1, contact1AfterChange, case1, fa1, fac1);
    	
    	//Check the acitivity to see if it is valid
    	TFS_Activity__c activity1 = [SELECT Id, New_Active_duty_start_date__c, New_Active_duty_end_date__c, New_Service_branch__c,
    					action__c, category__c, topic__c, Service_type__c
    					FROM TFS_Activity__c WHERE financial_account_customer__c =:fac1.Id];
    	System.debug('activity1' + activity1);				
    	
    	//Validate
    	System.assertEquals(Date.valueOf('2016-08-01'), activity1.New_Active_duty_end_date__c);
    	
	 	Test.stopTest();
	}
	
	static testMethod void invalidContactInputTest() {
		//Get the objects
		User user2 = [SELECT Id, Name FROM User where Id =:UserInfo.getUserId()];
		
		Financial_Account__c fa1 = [SELECT name, collateral__c, title__c, Finance_Account_Status__c,
								code_edit_message__c, type_code_description__c, RecordTypeId 
								FROM Financial_Account__c WHERE Name = 'FA'];
								
		Financial_Account_Customer__c fac1 = [select Id, Name, Account__c, Account__r.LastName, Account__r.FirstName, Account__r.Name, 
					Account__r.IsPersonAccount, account__r.personContactId, Borrower_Position__c, 
					Financial_Account_Customer__c, Account__r.Social_Security_Number__pc, Customer_Full_Name__c
    				from financial_account_customer__c where name = 'FAC1000'];
    				
		Contact  contact1 = [SELECT Id, Active_Duty_End_Date__c,Active_Duty_Start_Date__c, Service_Branch__c 
					 	FROM Contact WHERE Id =:fac1.account__r.personContactId];
    	
    	//Setup Contact
    	contact1.Active_Duty_Start_Date__c = null;
    	contact1.Active_Duty_End_Date__c = Date.valueOf('2016-07-30');
    	contact1.Service_Branch__c = 'Coast Guard Reserve';
    	update contact1;
    	
    	System.debug('**** contact1 ' + contact1);
    	
    	Schema.DescribeSObjectResult obj = Schema.SObjectType.Case;   
        Map<String,Schema.RecordTypeInfo>caseRecordTypeMap = obj.getRecordTypeInfosByName();
        Id caseRTId = caseRecordTypeMap.get('UC - Edit Profile').getRecordTypeId();
        
		Test.startTest();
		
		Case case1 = new Case(Financial_Account__c = fa1.Id, recordTypeId= caseRTId, status='New', action__c = 'Edit Profile',
                Service_Type__c='Inbound Call', Number_of_LME_s__c = '1',Requesting_location__c='CSC', 
                Financial_Account_Customer__c = fac1.Id, contact_name__c = fac1.Customer_Full_Name__c);
 		
 		System.runAs(user2){//User with SCRA Update permission set
	        case1.Category__c = 'Customer Profile Update';
			case1.Service_Request_Type__c = 'SCRA Update';
			case1.Description = 'Test1 SCRA Update on Case';
			insert case1;
 		}
 			
 		//Setup new contact to compare after change
		Contact contact1AfterChange = null;
    	
    	//Call the method to test
    	ContactUtil.createContactRelatedUCActivity(contact1, contact1AfterChange, case1, fa1, fac1);
    	
    	//Check the acitivity to see if it is valid
    	TFS_Activity__c activity1 = null;
    	try{
	    	activity1 = [SELECT Id, New_Active_duty_start_date__c, New_Active_duty_end_date__c, New_Service_branch__c,
	    					action__c, category__c, topic__c, Service_type__c
	    					FROM TFS_Activity__c WHERE financial_account_customer__c =:fac1.Id];
    	}catch (Exception e){
    		System.debug('System.QueryException: List has no rows for assignment to SObject');
    	}
    	System.debug('activity1' + activity1);				
    	
    	//Validate
    	System.assertEquals(null, activity1);
	 
	 	Test.stopTest();
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
	
	@testSetup 
	static void faForSCRAActivity() {
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
    	
    	fac = new Financial_Account_Customer__c(name = 'FAC1000', financial_account__c = fa.id, account__c = acct.Id,
    				Customer_Role_Type__c = '0-Primary Borrower', Borrower_Position__c = 'Primary', Borrower_Status__c='ACTIVE',
    				financial_account_customer__c = 'FAC1000');
    				
    	system.debug('**** fac ' + fac);  
    					
    	insert fac; 
    	system.debug('**** fac ' + fac.name + '-' + fac.financial_Account__r.name +'-'+ fac.Account__r.Social_Security_Number__pc);		
	}
}