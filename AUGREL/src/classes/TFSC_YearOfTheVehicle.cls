/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_YearOfTheVehicle> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <14/12/2015> 

Last Modified by......: <ARJUN SONI>

Last Modified Date....: <16/12/2015 >

Description...........: <This Class has been written for feching the List of year of vehicle field from Collateral object.>
##########################################################################################
*/
public with sharing class TFSC_YearOfTheVehicle 
{  
    @InvocableMethod(label='Year Of The Vehicle' description='Returns the Year Of The Vehicle for the current record of FA')
    public static List<String> YearOfTheVehicle(List<String> faIds)
        {
        List<String> YearOfTheVehicleList=new List<String>();
        String faId = faIds.get(0);
        List<Financial_Account__c> FA=[SELECT Collateral__r.Model_Year__c  FROM Financial_Account__c where id=:faId];
        for(Financial_Account__c c :FA )
            {                   
            String YearOfTheVehicle =c.Collateral__r.Model_Year__c;
            YearOfTheVehicleList.add(YearOfTheVehicle);        
            }   
        System.debug('****************** returned list\'s contents: ' + YearOfTheVehicleList);
        return YearOfTheVehicleList;  
        }
}