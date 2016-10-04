@isTest
private class TFSC_MostRecentCureNoteTest 
    {
    //Setup test data
    Static List<String> testFAId = new List<String>();
    private static void setupTestFA()
    {    
        Financial_Account__c FA=new Financial_Account__c(Name='Account1', Financial_Account_Number__c = '12345');
        Insert FA;
        Task T=new Task(Description='ABCD',Collection_Activity_Code__c ='CURE',Collection_Activity_DateTime__c=System.today(), Financial_Account__c=FA.Id,  WhatId =FA.Id);  
        Insert T; 
    }     
    static testmethod void MostRecentCureYNote()
    {
        TFSC_MostRecentCureNoteTest.setupTestFA();      
        Financial_Account__c testFA=[SELECT id  FROM Financial_Account__c where Financial_Account_Number__c='12345'];
        String testFAIds = String.ValueOf(testFA.Id);          
        testFAId.add(testFAIds);   
        Test.startTest();
        List<String> DescriptionList = TFSC_MostRecentCureNote.MostRecentCureNoteDescription(testFAId);       
        Test.stopTest();
    }
}