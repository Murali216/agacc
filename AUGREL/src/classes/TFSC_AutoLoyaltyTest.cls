@isTest
private class TFSC_AutoLoyaltyTest {

    static testMethod void myUnitTest() {
        	
    // create FA, Next Best Action, Eligible Offer
        Id faRecordTypeId = [select Id from recordType where sObjectType = 'Financial_Account__c' and name = 'Lease' limit 1].Id;
     	Financial_Account__c fa = new Financial_Account__c(name = 'FA',Finance_Account_Status__c = 'Open',
    			code_edit_message__c = '1000', type_code_description__c = 'NotActuarial', RecordTypeId=faRecordTypeId);
    	insert fa;
    	
    	Next_Best_Action__c nba = new Next_Best_Action__c(Description__c = 'Description');
    	insert nba;
    	
    	Eligible_Offer__c eo = new Eligible_Offer__c(Certificate_Number__c = '1000', Eligible_Date__c = date.today(), end_Date__c = date.today().addDays(90),
    		Financial_Account__c = fa.Id, Next_Best_Action__c = nba.Id);
    	insert eo;


		test.startTest();
		
        PageReference pr = Page.TFS_Auto_Loyalty_Universal_Console;
        Test.setCurrentPage(pr);     
        pr.getParameters().put('Id',fa.Id);
        TFSC_AutoLoyalty ctrl = new TFSC_AutoLoyalty();
        ctrl.servicegroup = 'test';
        
        //error coverage
        pr.getParameters().put('12345',fa.Id);
        ctrl = new TFSC_AutoLoyalty();
        
        
		test.stopTest();
        
    }
}