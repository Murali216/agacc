global with sharing class TFSC_CommunitiesIntermediateController {

    public String defaultPage {
        get {             
            if (TFSC_CommunitySettings.PERSONID != null ) {
                for(Financial_Account_Customer__c fac : TFSC_CommunitySettings.findFinancialAccountCustomersForWeblogin()) {
                    if (fac.Identity_Theft_Indicator_Flag__c){
                        return TFSC_CommunitySettings.ID_THEFT_FLAG_ERROR_URL;                        
                    }
                }
            }
            
            return TFSC_CommunitySettings.DEFAULT_PAGE;
        }
    }
    
     public String getCustomSettingsDefaultPage() {
          return TFSC_CommunitySettings.DEFAULT_PAGE;
     }

    global TFSC_CommunitiesIntermediateController() {

    }

    @RemoteAction
    global static void noop() {
        return;
    }

}