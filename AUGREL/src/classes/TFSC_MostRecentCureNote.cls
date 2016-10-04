/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentCureNote > 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <15/12/2015> 

Last Modified by......: <ARJUN SONI>

Last Modified Date....: <15/12/2015 >

Description...........: <This Class has been written for getting the description field from task object>
##########################################################################################
*/
public with sharing class TFSC_MostRecentCureNote 
{
@InvocableMethod(label='Most recent Cure note' description='Returns the Most recent description of task')

    public static List<String> MostRecentCureNoteDescription(List<String> faIds)
    {
        List<String> DescriptionList=new List<String>();
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
            DescriptionList.add(Taskdescription.Description);            
            }
        }
        return  DescriptionList;
    }      
}