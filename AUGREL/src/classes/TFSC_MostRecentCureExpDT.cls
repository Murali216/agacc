/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentCureExpDT> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <24/12/2015> 

Last Modified by......: <Megha Dalmia>

Last Modified Date....: <24/12/2015 >

Description...........: <This Class has been written for Returning the Most recent cure expiry date>
##########################################################################################
*/
public with sharing class TFSC_MostRecentCureExpDT
{
@InvocableMethod(label='Most recent Cure ExpDt' description='Returns the Most recent cure expiry date')

    public static List<Date> MostRecentCureExpDt(List<String> faIds)
    {
        List<Date> ExpiryDate=new List<Date>();
        String cureNoticeSent = 'cure notice sent';
        try{
            if(faIds!=null && faIDs.size()>0)
            {           
                List<Task> descriptions =new List<Task>();
                descriptions = [SELECT Description 
                              FROM Task 
                              WHERE WhatId = :faIds 
                              AND Collection_Activity_Code__c = 'CURE' 
                              ORDER BY Collection_Activity_DateTime__c DESC LIMIT 1];
                  
                              
                for(Task Taskdescription :descriptions){
                    Date expDt = null;
                    String blankdate='';
                    String expires = 'expires';
            
                    if(!String.isBlank(Taskdescription.Description)){
                        String tempDescFull = Taskdescription.Description;
                        String tempDesc = tempDescFull.replaceAll('\\s+',' ');
                
                        if(tempDesc.containsIgnoreCase(cureNoticeSent) && tempDesc.containsIgnoreCase(expires) && tempDesc.toLowerCase().indexOf(expires) >= 0){
                    
                            //Determine the starting point for the expiration date
                            Integer expStart = tempDesc.toLowerCase().indexOf(expires) + expires.length() + 1;
                    
                            //parse out the date; the date is in a MMDDYY format
                            Integer month = Integer.valueOf(tempDesc.substring(expStart, (expStart + 2)));
                            Integer day = Integer.valueOf(tempDesc.substring((expStart + 2), (expStart + 4)));
                            Integer year = 2000 + Integer.valueOf(tempDesc.substring((expStart + 4), (expStart + 6)));
                            Date tempDt = Date.newInstance(year, month, day);
                            blankdate = tempDt.format();
                            expDt = tempDt;
                        }
                    }
            
                    if(String.isBlank(blankdate)){
                        expDt = null;
                    }
                    ExpiryDate.add(expDt);
                }
            }
        }
        catch(exception e)
        {
            System.debug('An error occured while parsing the data');
        }
        return  ExpiryDate;
    }      
}