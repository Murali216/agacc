@isTest
private class TFSC_SearchControllerTest {
    
   	static testmethod void positiveTest1() {
	    createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    //cont.TFSC_SearchController();
	    //Positive Scenario1
	    cont.fANumber = '00070411111111110001';
	    cont.sSN = '11111111';
	    cont.fName = 'FN';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    cont.searchFAC();
	    cont.reset();
	    Integer tempInt =  cont.getnoOfFAC();
	    tempInt =  cont.getnoOfFA();
	    String tempStr = cont.getoneFAId();
	    tempStr = cont.getoneFANo();
    }
   	static testmethod void positiveTest2() {
		createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    
	    cont.fANumber = '1111111111';
	    cont.tIN = '11111111';
	    cont.busiName = 'Business';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    cont.searchFAC();
	    cont.reset();
	    Integer tempInt =  cont.getnoOfFAC();
	    tempInt =  cont.getnoOfFA();
	    String tempStr = cont.getoneFAId();
	    tempStr = cont.getoneFANo();

	    cont.searchFAC();
    }
   	static testmethod void positiveTest3() {
		createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    
	    cont.fANumber = '00070412345678900001';
	    cont.tIN = '11111111';
	    cont.busiName = 'Business';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    cont.searchFAC();
		cont.SearchArchivedFAC();
	    cont.reset();
    }
   	static testmethod void positiveTest4() {
		createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    
	    cont.fANumber = '00000000001234567890';
	    cont.tIN = '11111111';
	    cont.busiName = 'Business';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    cont.searchFAC();
		cont.SearchArchivedFAC();
	    cont.reset();
    }
   	static testmethod void archiveQueryTest() {
	    createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    
	    cont.fANumber = '00070411111111110001';
	    cont.sSN = '11111111';
	    cont.fName = 'FN';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    cont.TestWSResponse = 'SUCCESS';

		cont.SearchArchivedFAC();
	    
    }
   	static testmethod void archiveCreateTest() {
	    createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
		PageReference pr = Page.TFSC_Search;
		Test.setCurrentPage(pr);
		ApexPages.currentPage().getParameters().put('ArchiveFANum','00070411111111110001');
		ApexPages.currentPage().getParameters().put('AccountClosedDate','');
		ApexPages.currentPage().getParameters().put('AccountBranch','');
		ApexPages.currentPage().getParameters().put('AccountType','');
		
		cont.createFAFromArchive();	    
    }
   	static testmethod void negTest() {
	    createBaseData();
	    TFSC_searchController cont = new TFSC_searchController();
	    
	    //Negative Scenario = 0 records
	    cont.fANumber = '00000000001111110001';
	    cont.sSN = '00000000';
	    cont.fName = 'FN';
	    cont.lName = 'LName';
	    cont.garZip = '11111';
	    cont.vINFull = '11111111111111111111';
	    cont.vIN8 = '11111111';
	    
	    cont.searchFAC();
	    System.assertEquals(cont.searchedFACs.size(), 0);
    }

    private static Financial_Account__c insertFA(Collateral__c car) {
        
        String randomString = TFSC_TestUtils.generateRandomString(6);
        
        Financial_Account__c financialAccount = new Financial_Account__c(Financial_Account_Number__c = '1111111111', Collateral__c=car.Id,Finance_Account_Status__c='Active', CO_Host_Account_Number__c='00070411111111110001' );
        financialAccount.Collection_List_Number_1__c = '1704'; // for FPD
        financialAccount.History_Counter_Days_Past_Due__c = '10';
        insert financialAccount;        
       
        return financialAccount;
    }
    private static Financial_Account_Customer__c insertFAC(Financial_Account__c fa, Account acc) {
        
        String randomString = TFSC_TestUtils.generateRandomString(6);
        
        Financial_Account_Customer__c fac = new Financial_Account_Customer__c(Financial_Account__c = fa.Id, Account__c = acc.Id, Mailing_Postal_Code_Garage__c='11111' );
    fac.Borrower_Position__c = 'Primary';
        fac.Borrower_Status__c = 'Active';
        fac.Mailing_State_BillTo__c = 'CO';        
        fac.Work_Phone_Garage__c = '1111111111';
        fac.Mobile_Phone__c = '1111111111';
        fac.Home_Phone_Garage__c = '1111111111';
        fac.Work_Phone_Bill_To__c = '1111111111';
        fac.HomePhone_BillTo__c = '1111111111';
        fac.Borrower_Status__c = 'Active';
        fac.Customer_Role_Type__c = 'test';
        fac.FA_Role_Status__c = 'test';
    fac.Financial_Account_Customer__c = 'test2' + TFSC_TestUtils.generateRandomString(4);


        insert fac;        
       
        return fac;
    }
	private static void createBaseData(){
		Id persAccId = TFSC_Utils.getRecordTypeIdFromDeveloperNameAndsObjectName('Customer', 'Account');
	    Id bussAccId = TFSC_Utils.getRecordTypeIdFromDeveloperNameAndsObjectName('Business_Account', 'Account');

	    Account personAcct = new Account(FirstName='FName',LastName ='LName',RecordTypeId=persAccId, Social_Security_Number__pc='11111111');
	    insert personAcct;

	    Account bussAcc = new Account(name = 'Business Account123' ,RecordTypeId=bussAccId,Tax_Identification_Number__c='11111111');
	    insert bussAcc;

	    Collateral__c car = new Collateral__c(Vehicle_Identification_Number__c ='11111111111111111111',Make__c='Toyota', Model_Name__c='Camry',Model_Year__c='2015');
	    insert car;

	    Financial_Account__c fa = insertFA(car);    
	    
	    Financial_Account_Customer__c personfac = insertFAC(fa, personAcct);
	    Financial_Account_Customer__c busifac = insertFAC(fa, bussAcc);    
	}

}