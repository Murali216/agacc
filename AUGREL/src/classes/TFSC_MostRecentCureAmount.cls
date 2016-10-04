/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentCureAmount> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <24/12/2015> 

Last Modified by......: <Megha Dalmia>

Last Modified Date....: <24/12/2015 >

Description...........: <This Class has been written for Returning the Most recent cure amount>
##########################################################################################
*/
public with sharing class TFSC_MostRecentCureAmount
{
@InvocableMethod(label='Most recent Cure Amount' description='Returns the Most recent cure amount')

    public static List<String> MostRecentCureAmount(List<String> faIds)
    {
        List<String> DescriptionList=new List<String>();
        String cureNoticeSent = 'cure notice sent';
        if(faIds!=null && faIDs.size()>0)
        {           
            List<Task> descriptions =new List<Task>();
            descriptions = [SELECT Description 
                          FROM Task 
                          WHERE WhatId = :faIds 
                          AND Collection_Activity_Code__c = 'CURE' 
                          ORDER BY Collection_Activity_DateTime__c DESC LIMIT 1];
                           
            for(Task Taskdescription :descriptions)
            {
                String amount = '';
                if(!String.isBlank(Taskdescription.Description)){
                    String tempDesc = Taskdescription.Description;
                    if(tempDesc.toLowerCase().contains(cureNoticeSent) && tempDesc.toLowerCase().contains('$')){
                
                        Integer dollarStart = tempDesc.indexOf('$');
                        Integer centStart = tempDesc.indexOf('.',dollarStart);
                        if(centStart >= 0){
                        Integer len = centStart - dollarStart + 3;
                        amount = tempDesc.mid(dollarStart, len);
                        }
                    }
                }   
        
                if(String.isBlank(amount)){
                    amount = '';
                }
                
                DescriptionList.add(amount);            
            }
        }
        return  DescriptionList;
    }      
}