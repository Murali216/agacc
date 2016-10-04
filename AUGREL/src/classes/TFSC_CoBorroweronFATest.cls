/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_CoBorroweronFATest> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <24/12/2015> 

Last Modified by......: <Megha Dalmia>

Last Modified Date....: <24/12/2015 >

Description...........: <This Test Class has been written for the test coverage of TFSC_CoBorrowerExistOnFA class>
##########################################################################################
*/
@isTest
private class TFSC_CoBorroweronFATest
    {
    //Setup test data
    Static List<String> testFAId = new List<String>();
    private static void setupTestFA()
    {    
        Financial_Account__c FA=new Financial_Account__c(Name='Account1', Financial_Account_Number__c = '12345');
        Insert FA;
        Account acc= new Account(name='CoBorrower');
        Insert acc;
        Financial_Account_Customer__c fac=new Financial_Account_Customer__c(Customer_Role_Type__c='1-CoBorrower', Borrower_Status__c= 'Active' , Financial_Account__c=FA.Id, account__c=acc.id);  
        Insert fac;
    } 

    private static void setupTestFAC()
    {    
        Financial_Account__c FAnoCB=new Financial_Account__c(Name='Account1', Financial_Account_Number__c = '123456');
        Insert FAnoCB;
        Account accBo= new Account(name='Borrower');
        Insert accBo;
        Financial_Account_Customer__c facnoCB=new Financial_Account_Customer__c(Customer_Role_Type__c='0-Primary Borrower', Borrower_Status__c= 'Active' , Financial_Account__c=FAnoCB.Id, account__c=accBo.id);  
        Insert facnoCB;
    }     
    static testmethod void CoBorroweronFATest()
    {
        TFSC_CoBorroweronFATest.setupTestFA();      
        Financial_Account__c testFA=[SELECT id  FROM Financial_Account__c where Financial_Account_Number__c='12345'];
        String testFAIds = String.ValueOf(testFA.Id);          
        testFAId.add(testFAIds);   
        Test.startTest();
        List<Boolean> CoBorrExist = TFSC_CoBorrowerExistOnFA.CoBorrowerOnAccount(testFAId); 
        System.assertequals(True,CoBorrExist[0] );      
        Test.stopTest();
    }
    
    static testmethod void CoBorrowerNotonFATest()
    {
        TFSC_CoBorroweronFATest.setupTestFAC();      
        Financial_Account__c testFA=[SELECT id  FROM Financial_Account__c where Financial_Account_Number__c='123456'];
        String testFAIds = String.ValueOf(testFA.Id);          
        testFAId.add(testFAIds);   
        Test.startTest();
        List<Boolean> CoBorrExist = TFSC_CoBorrowerExistOnFA.CoBorrowerOnAccount(testFAId); 
        System.assertequals(False,CoBorrExist[0] );      
        Test.stopTest();
    }
 
 }