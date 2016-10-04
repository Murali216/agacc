/*
#########################################################################################

Project Name..........: TFS AB

File..................: <TFSC_CoBorrowerExistOnFA> 

Version...............: <1.0>

Created by............: INFOSYS TECHNOLOGIES

Created Date..........: <24/12/2015> 

Last Modified by......: <Megha Dalmia>

Last Modified Date....: <24/12/2015 >

Description...........: <This Class has been written for Returning the data if coborrower exist on Account>
##########################################################################################
*/
public with sharing class TFSC_CoBorrowerExistOnFA
{
@InvocableMethod(label='CoBorroweronFAExist' description='Returns data if coborrower exist on Account')

    public static List<Boolean> CoBorrowerOnAccount(List<String> faIds)
    {
        List<Boolean> CoBorrowerExist=new List<Boolean>();
        if(faIds!=null && faIDs.size()>0)
        {           
            List<Financial_Account_Customer__c> coBorrowers =new List<Financial_Account_Customer__c>();
            coBorrowers = [SELECT id, Customer_Role_Type__c, Borrower_Status__c 
                          FROM Financial_Account_Customer__c 
                          WHERE Financial_Account__c = :faIds 
                          AND Borrower_Status__c = 'Active' AND Customer_Role_Type__c!='0-Primary Borrower'];
                          
            if(coBorrowers!=null && coBorrowers.size()>0){
            CoBorrowerExist.add(True);
            }          
            else 
            CoBorrowerExist.add(False);  
        }
        return  CoBorrowerExist;
    }      
}