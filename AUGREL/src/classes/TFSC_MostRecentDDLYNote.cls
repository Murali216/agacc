/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_MostRecentDDLYNote> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <14/12/2015> 

Last Modified by......: <ARJUN SONI>

Last Modified Date....: <16/12/2015 >

Description...........: <This Class has been written for feching the description field from standard object CASE.>
##########################################################################################
*/
public with sharing class TFSC_MostRecentDDLYNote 
{
  
    @InvocableMethod(label='Most recent DDLY note' description='Returns the Most recent record-Description of PayOff SR')
    
    public static List<String> MostRecentRecorDescriptionOfPayOffSR(List<String> faIds)
        {
        List<String> DescriptionList=new List<String>();
        if(faIds!=null && faIDs.size()>0){           
             List<Case> serviceRequests =new List<Case>();
             List<TFS_activity__c> tfsActivityList=new List<TFS_activity__c> ();
             serviceRequests =[Select Description,Source_Created_Date__c from Case where Service_Request_Type__c='Payoff Request' AND Service_Request_User_Group__c='Dealer Daily System' AND Financial_Account__c in :faIds order by Source_Created_Date__c desc limit 1];
             tfsActivityList=[Select Description__c,Source_Created_Date__c from TFS_activity__c where Service_Request_Type__c='Payoff Request' AND Service_Request_User_Group__c='Dealer Daily System' AND Financial_Account__c in :faIds order by Source_Created_Date__c desc limit 1];
             if(serviceRequests.size()>0 && tfsActivityList.size()>0){
                if(serviceRequests[0].Source_Created_Date__c > tfsActivityList[0].Source_Created_Date__c)
                    DescriptionList.add(serviceRequests[0].description );
                else
                    DescriptionList.add(tfsActivityList[0].Description__c );
                }
             else if(serviceRequests.size()==0 && tfsActivityList.size()>0){
                DescriptionList.add(tfsActivityList[0].Description__c );
                }
             else if(serviceRequests.size()>0 && tfsActivityList.size()==0){
                DescriptionList.add(serviceRequests[0].description );
                }             
            }
        return DescriptionList;  
        }
}