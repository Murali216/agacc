/**
    * Leveraged for Auto Loyalty to display Offer tabs
    * @author: Abhishek Ballabh
    * @version: 1.0
*/

global with sharing class TFSC_AutoLoyalty {
   
    public String servicegroup{get;set;}
    public String offer{get;set;}
    public String financialAccountId {
        get {
            return ApexPages.currentPage().getParameters().get('Id');
        }
        set;
    }
    public Financial_Account__c financialAccount{get;set;}
    public string sergroup{get;set;}
     //Financial Account Customer: The current person spoken to or the primary co-borrower
    public Financial_Account_Customer__c financialAccountCustomer{get;set;}
    public List<item> dataList {get; set;}
    String URL;
    
   
    
   

    public TFSC_Autoloyalty() {
        
        if(isValidFinancialID()){
               
                // First Thing is to retrieve the current financial account record
                setFinancialAccountIdFromMainTab();
                // Also, set the financial account customer
                financialAccountCustomer = TFSC_Utils.getCoBorrowerFinancialAccountCustomerFromPhoneNumber(financialAccountId,'') ;
                }
                dataList = new List<item>();
                for (Eligible_Offer__c c : [select Id, Name, Eligible_Date__c, end_date__c, Next_Best_Action__r.description__c,Certificate_Number__c from Eligible_Offer__c where financial_account__c = :financialAccountId and eligible_Date__c<=TODAY and end_date__c> N_Days_Ago:30
                    order by createdDate desc limit 200]) {
                        dataList.add(new item(c.Id, c.Name,c.Next_Best_Action__r.description__c, c.Eligible_Date__c, c.end_date__c,c.Certificate_Number__c));
                    }
                }
            
    public Boolean isValidFinancialID() {
        if(financialAccountId == null || financialAccountId.length() < 15) {
            
            return false;
        }
        
        return true;
    }
    
     
    public void setFinancialAccountIdFromMainTab(){
        
        try{
        offer='Auto Loyalty';
        
        sergroup = [Select Service_Request_User_Group__c From User Where Id = :UserInfo.getUserId()][0].Service_Request_User_Group__c;
        system.debug('ServiceGroup: '+sergroup);
                Id faAccountId = Id.valueOf(financialAccountId);
                financialAccount = [
                            SELECT
                                        Id,
                                        Financial_Account_Number__c,
                                        Total_Amount_Due__c,
                                        Payment_Amount_Past_Due__c,
                                        Payment_Date_Next__c,
                                        History_Counter_Days_Past_Due__c,
                                        Refi_Pitch_Eligible_Flag__c,
                                        Refi_Pitch_Treatment__c
                            FROM
                                        Financial_Account__c
                            WHERE
                                        //Id = :faAccountId
                                        Id = :financialAccountId
                            LIMIT
                                        1
                ];
                
        }catch(Exception e){
          
        }
        
        //return null;
    }
    
    public class item {
        public Id recId  {get; set;}
        public String Name  {get; set;}
        public string Description {get; set;}
        public string Eligible_Date {get; set;}
        public string End_date {get; set;}
        public string Certificate {get; set;}
      
        
        public item(Id rId, string Name, string Description, Date Eligible_Date, Date End_Date, string Certificate) {
            this.recId = rId;
            this.Name = name;
            this.description = description;
            this.Eligible_date = Eligible_Date.format();
            this.End_date = End_Date.format();
            this.Certificate = Certificate;
        }
        }
}