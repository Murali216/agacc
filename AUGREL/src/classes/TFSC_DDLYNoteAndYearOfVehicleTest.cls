/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentDDLYNoteTest> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <15/12/2015> 

Last Modified by......: <ARJUN SONI>

Last Modified Date....: <15/12/2015 >

Description...........: <This Test Class has been written for Covering the TFSC_MostRecentDDLYNote and TFSC_YearOfTheVehicle class>
##########################################################################################
*/

@isTest
private class TFSC_DDLYNoteAndYearOfVehicleTest 
    {
    //Setup test data
    Static List<String> testFAIds = new List<String>();
    private static List<Financial_Account__c> setupTestFA()
    {           	
        List<Financial_account__c> FAsToInsert=new List<Financial_account__c> ();        	
        for(Integer i=0;i<4;i++) { 
	        Financial_Account__c FA=new Financial_Account__c(Name='FATAccount1'+i, Financial_Account_Number__c = 'FAT12345'+i);
	        FAsToInsert.add(FA);
	        }	        
        Insert FAsToInsert; 
        List<Case> caseToInsert=new List<Case> ();
        List<TFS_Activity__c> tfsActivityToInsert=new List<TFS_Activity__c> ();
        for(Integer i=0;i<4;i++){
        	if(i==1){
        		// Testing scenario where  Case record is associated with Financial account but there is no associated TFS_activity__c record. 
		        Case c=new Case(Description='Description From Case',KM_Department__c='D1',Service_Request_User_Group__c='Dealer Daily System',KM_Change_Category__c='Other',KM_Documentation_Impacted__c='other',Service_Request_Type__c='Payoff Request', Financial_Account__c=FAsToInsert[i].id);  
		        caseToInsert.add(c); 
        		}
        	if(i==2){
        		// Testing scenario where  associated  Case and TFS_activity__c records are present.      
		        TFS_Activity__c act=new TFS_Activity__c(Description__c='Description From Activity',Service_Request_User_Group__c='Dealer Daily System',Service_Request_Type__c='Payoff Request', Financial_Account__c=FAsToInsert[i].id);  
		        tfsActivityToInsert.add(act);  
        		}
        	if(i==3){
        		Case c=new Case(Description='Description From Case',KM_Department__c='D1',Service_Request_User_Group__c='Dealer Daily System',KM_Change_Category__c='Other',KM_Documentation_Impacted__c='other',Service_Request_Type__c='Payoff Request', Financial_Account__c=FAsToInsert[i].id);  
		        caseToInsert.add(c); 		        
		        TFS_Activity__c act=new TFS_Activity__c(Description__c='Description From Activity',Service_Request_User_Group__c='Dealer Daily System',Service_Request_Type__c='Payoff Request', Financial_Account__c=FAsToInsert[i].id);  
		        tfsActivityToInsert.add(act);
        		}
        	}
        insert caseToInsert ;
        insert tfsActivityToInsert;
        return FAsToInsert ;     
    }     
    static testmethod void testMostRecentDDLYNote()
    {
        
         Test.startTest();
         List<Financial_account__c> testFAs=TFSC_DDLYNoteAndYearOfVehicleTest.setupTestFA();
        for(Financial_account__c fa:testFAs){
        	testFAIds=new List<String> ();
        	testFAIds.add(fa.id);
        	 List<String> DescriptionList = TFSC_MostRecentDDLYNote.MostRecentRecorDescriptionOfPayOffSR(testFAIds); 
        	 if(fa.Financial_Account_Number__c=='FAT123450')
        	 	System.assertEquals(DescriptionList.size(),0);
        	 if(fa.Financial_Account_Number__c=='FAT123451')
        	 	System.assertEquals('Description From Case',DescriptionList[0]);
        	 if(fa.Financial_Account_Number__c=='FAT123452')
        	 	System.assertEquals('Description From Activity',DescriptionList[0]); 
        	 if(fa.Financial_Account_Number__c=='FAT123453')
        	 	System.assertEquals('Description From Activity',DescriptionList[0]); 	 
        	} 
         testFAIds=new List<String> ();
         testFAIds.add(testFAs[0].id);
         List<String> YearOfTheVehicle= TFSC_YearOfTheVehicle.YearOfTheVehicle(testFAIds);
        Test.stopTest();  
    }
      
}