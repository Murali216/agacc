/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentCureAmtandExpiryDateTest> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <24/12/2015> 

Last Modified by......: <Megha Dalmia>

Last Modified Date....: <24/12/2015 >

Description...........: <This Test Class has been written for the test coverage of TFSC_MostRecentCureExpDT and TFSC_MostRecentCureAmount class>
##########################################################################################
*/
@isTest
private class TFSC_MostRecentCureAmtandExpiryDateTest
    {
    //Setup test data
    Static List<String> testFAId = new List<String>();
    private static void setupTestFA()
    {    
        Financial_Account__c FA=new Financial_Account__c(Name='Account1', Financial_Account_Number__c = '12345');
        Insert FA;
        Task T=new Task(Description='cure notice sent $8978.00 expires 122314',Collection_Activity_Code__c ='CURE',Collection_Activity_DateTime__c=System.today(), Financial_Account__c=FA.Id,  WhatId =FA.Id);  
        Insert T;
    }     
    static testmethod void MostRecentCureamount()
    {
        TFSC_MostRecentCureAmtandExpiryDateTest.setupTestFA();      
        Financial_Account__c testFA=[SELECT id  FROM Financial_Account__c where Financial_Account_Number__c='12345'];
        String testFAIds = String.ValueOf(testFA.Id);          
        testFAId.add(testFAIds);   
        Test.startTest();
        List<String> cureAmt = TFSC_MostRecentCureAmount.MostRecentCureAmount(testFAId); 
        System.assertequals('$8978.00',cureAmt[0] );      
        Test.stopTest();
    }
    
    static testmethod void MostRecentCureexpDate()
    {
        TFSC_MostRecentCureAmtandExpiryDateTest.setupTestFA();      
        Financial_Account__c testFA=[SELECT id  FROM Financial_Account__c where Financial_Account_Number__c='12345'];
        String testFAIds = String.ValueOf(testFA.Id);          
        testFAId.add(testFAIds);   
        Test.startTest();
        List<Date> cureAmt = TFSC_MostRecentCureExpDT.MostRecentCureExpDt(testFAId); 
         Date tempDt = Date.newInstance(2014, 12, 23);
        System.assertequals(tempDt,cureAmt[0]);      
        Test.stopTest();
    }
}