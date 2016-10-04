/**    
    * @author  Amanjot Purewal
        * @date 8/25/2015    
        * @description This class handles Custom Search Parameters and methods
     */ 

public with Sharing class TFSC_SearchController{
    // UI fields
    public String fANumber{get;set;}
    public String sSN{get;set;}
    public String tIN{get;set;}
    public String fName{get;set;}
    public String lName{get;set;}
    public String busiName{get;set;}
    public String garZip{get;set;}
    public String vINFull{get;set;}
    public String vIN8{get;set;}
    
    public String TestWSResponse;
    
    public Integer noOfFAC;
    public Integer noArchiveOfFAC {get;Set;}
    public Integer getnoOfFAC(){
        return noOfFAC;
    }
    public Integer noOfFA;
    public Integer getnoOfFA(){
        return noOfFA;
    }
    public String oneFAId;
    public String getoneFAId(){
        return oneFAId;
    }
    public String oneFANo;
    public String getoneFANo(){
        return oneFANo;
    }
    private String queryFilter='';
    private Integer resultLimit1 = 10;
    private Integer resultLimit2 = 50;
    public list<Financial_Account_Customer__c> searchedFACs{get;set;} 
    public list<SfClosedAccount__x> searchedArchivedFACs{get;set;} 
    public LIST<ArchiveSearchResult> ArchiveResults {get; Set;}
    

    public TFSC_SearchController(){
        searchedFACs = null;
        noOfFA=-1;
        TestWSResponse = 'Running Test';
    }
    public void reset(){        
        searchedFACs = null;
        searchedArchivedFACs= null;
    }

// create the dynamic query based on the User input parameters 
    public void searchFAC(){
        noOfFAC = -1;
        noOfFA = -1;
        oneFAId ='';
        oneFANo ='';
        
        PullActiveFAC();
        
        if(searchedFACs != null){       
            noOfFAC = searchedFACs.size();      
            Set <Id> uniqueSearchedFAs = new Set<Id>();
            for(Financial_Account_Customer__c fac : searchedFACs){// Check if search returns a unique FA (there may be multiple FAC but if they all belong to one FA), then auto pop the FA in console
                uniqueSearchedFAs.add(fac.Financial_Account__r.Id);
            }
            if(uniqueSearchedFAs !=null && uniqueSearchedFAs.size() == 1){
                noOfFA = 1; //No of Unique FAs
                oneFAId = searchedFACs.get(0).Financial_Account__r.Id;
                oneFANo  = searchedFACs.get(0).Financial_Account_Number__c;
            }
        }
        if(noOfFAC == 0 ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Records found for this search Criteria')); 
        }else if(noOfFAC > resultLimit2 ){
            searchedFACs.remove(50);//Remove the last result if more than 50 are returned.
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your search returned more than 50 results. Not all results are displayed below. Enter additional criteria to refine your search.'));
        }else if(noOfFAC >= resultLimit1 ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter additional criteria to refine your search.'));
        }
    }
    public void SearchArchivedFAC(){
        noOfFAC = -1;
        noOfFA = -1;
        oneFAId ='';
        oneFANo ='';
        noArchiveOfFAC = -1;
        
        PullActiveFAC();
        PullArchivedFAC();
        
        // For search all we are not auto navigating to the FA
        if(searchedFACs != null){       
            noOfFAC = searchedFACs.size();      
        }
        if(searchedArchivedFACs != null){
            noArchiveOfFAC = searchedArchivedFACs.size();
        }
        if(noOfFAC == 0 && noArchiveOfFAC == 0){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Records found for this search Criteria')); 
        }
        if(noOfFAC > resultLimit2 ){
            searchedFACs.remove(50);//Remove the last result if more than 50 are returned.
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your search returned more than 50 results. Not all results are displayed below. Enter additional criteria to refine your search.'));
        }
        if(noOfFAC >= resultLimit1 ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter additional criteria to refine your search.'));
        }
        if(noArchiveOfFAC > resultLimit2 ){
            searchedArchivedFACs.remove(50);//Remove the last result if more than 50 are returned.
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Your search returned more than 50 results. Not all results are displayed below. Enter additional criteria to refine your search.'));
        }
        if(noArchiveOfFAC >= resultLimit1 ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter additional criteria to refine your search.'));
        }
    }
    // if an archived FA is chosen the following steps are needed:
    // 1) Check if FA exists in SFDC
    // 2) if not Tibco_ws_SendFARequest.SendRequest('0016142681'{fa Num},Dt {account closed date},'034'{account branch},'Retail'{acct type});
    // 2a) verify that FA now exists and then open
    // 3) if so open the FA
    public void createFAFromArchive(){
        System.debug('**** looking to create the FA from Archive');
        String sArchiveFANum = Apexpages.currentPage().getParameters().get('ArchiveFANum');
        datetime dtAccountClosedDate = null;
        if(Apexpages.currentPage().getParameters().get('AccountClosedDate')!=''){
            dtAccountClosedDate = datetime.parse(Apexpages.currentPage().getParameters().get('AccountClosedDate'));
        }
        String sAccountBranch = Apexpages.currentPage().getParameters().get('AccountBranch');
        String sAccountType = Apexpages.currentPage().getParameters().get('AccountType');
        
        if(sArchiveFANum != ''){
            LIST<Financial_Account__c> existingFA = [select id from Financial_Account__c where Financial_Account_Number__c=:sArchiveFANum];
            if(existingFA.size()>0){
                System.debug('**** the FA Num: '+sArchiveFANum);
                noOfFA = 1; //No of Unique FAs
                oneFAId = existingFA.get(0).Id;
                oneFANo = sArchiveFANum;                
            }else{
                System.debug('**** Time to pull from tape back-up');
                String CalloutResult = CallOutTibco_ws_SendFARequest(sArchiveFANum, dtAccountClosedDate, sAccountBranch, sAccountType);
                if(CalloutResult=='SUCCESS'){
                    LIST<Financial_Account__c> newFA = [select id, Financial_Account_Number__c from Financial_Account__c where Financial_Account_Number__c=:sArchiveFANum];
                    if(newFA.size()>0){
                        System.debug('**** the FA Num: '+newFA.get(0).Financial_Account_Number__c);
                        noOfFA = 1;
                        oneFAId = newFA.get(0).id;
                        oneFANo = newFA.get(0).Financial_Account_Number__c;
                    }
                }else{
                    // display any error messages
                    String message = '';
                    if(CalloutResult=='NO_DATA_FOUND'){
                        message='No FA found or No FAC found';
                    }else if(CalloutResult=='ERROR'){
                        message='Technical Error';
                    }else{
                        message='Error attempting retrieve the FA and FAC: '+CalloutResult;
                    }
                    System.debug('**** Unable to pull record: '+CalloutResult);
                    ApexPages.Message WSErr = new ApexPages.message(ApexPages.severity.error, message);
                    ApexPages.addmessage(WSErr);
                }
            }
        }
    }
    
    private void PullActiveFAC(){
        
        try{
            searchedFACs = (List<Financial_Account_Customer__c>)Database.Query(ActiveFAQuery());            
        }catch(QueryException se){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,se.getMessage()));
        }       
    }
    private void PullArchivedFAC(){
        try{
            ArchiveResults = new LIST<ArchiveSearchResult>();
            String ArcSOQL = ArchiveFAQuery();
            if(!Test.isRunningTest()){
                System.debug('**** searching archive');
                searchedArchivedFACs = (List<SfClosedAccount__x>)Database.Query(ArcSOQL);
                for(SfClosedAccount__x ca: searchedArchivedFACs){
                    Datetime acctCloseDate;
                    if(ca.accountClosedDate__c != null){
                        acctCloseDate = ca.accountClosedDate__c;
                    }else{
                        acctCloseDate = Datetime.now();
                    }
                    ArchiveResults.add(new ArchiveSearchResult(
                                ca.accountType__c,
                                ca.branch__c, 
                                acctCloseDate.format(), 
                                ca.businessName__c, 
                                ca.financialAccountNumber__c, 
                                ca.financialAccountStatus__c, 
                                ca.firstName__c, 
                                string.valueOf(ca.Id), 
                                ca.last8VinNumber__c, 
                                ca.lastName__c, 
                                ca.make__c, 
                                ca.modelName__c, 
                                ca.modelYear__c, 
                                ca.ssn__c, 
                                ca.tin__c, 
                                ca.vehicleIdentificationNumber__c, 
                                ca.zipcode__c
                                ));
                }
            }else{
                ArchiveResults.add(new ArchiveSearchResult(
                            '',
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            '', 
                            ''
                            ));
            }
        }catch(Exception se){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Unable to connect with external object. please try again later'));
        }
    }
    
    
    private String ActiveFAQuery(){
        String queryFilter = '';
        String selectFields = 'SELECT Id, Account__r.FirstName, Account__r.LastName, Account__r.Name, Account__r.IsPersonAccount, Vehicle_Identification_Number__c,Financial_Account__r.Collateral__r.Vehicle_Identification_Number_Last_8_Ch__c,Model_Year__c,Make__c,Model_Name__c,Mailing_Postal_Code_Garage__c,Financial_Account_Number__c,Social_Security_Number__c,Tax_Identification_Number__c,Financial_Account__r.Id,Financial_Account__r.Finance_Account_Status__c FROM Financial_Account_Customer__c';
        String queryOrder = 'Account__r.Name , Mailing_Postal_Code_Garage__c,Financial_Account_Number__c '; // Order By fields
        String queryLimit = '51';//Put the max number of records limit here  
        
        if(TFSC_Utils.isNotNullAndNotEmpty(fANumber)){
            fANumber=fANumber.replaceAll(' ','');
            fANumber = fANumber.trim().toUpperCase();
            if(fANumber.length() == 10 || fANumber.length() == 11 ){
                queryFilter = queryFilter + ' Financial_Account__r.Financial_Account_Number__c =\''+String.escapeSingleQuotes(fANumber)+'\' AND';
            }else if(fANumber.length() == 20 ){  
                if(fANumber.startsWith('000704') && fANumber.endsWith('0001') ){
                    fANumber = fANumber.substring(6,16);
                }else if(fANumber.startsWith('0000000000')){            
                    fANumber = fANumber.substring(10,12)+'0'+fANumber.substring(12,20);
                }
                queryFilter = queryFilter + ' Financial_Account__r.Financial_Account_Number__c =\''+String.escapeSingleQuotes(fANumber)+'\' AND';
            }
        }    
        if(TFSC_Utils.isNotNullAndNotEmpty(sSN)){
                queryFilter = queryFilter +' Social_Security_Number__c =\''+String.escapeSingleQuotes(sSN)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(tIN)){
                
               queryFilter = queryFilter + ' Tax_Identification_Number__c =\''+String.escapeSingleQuotes(tIN)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(lName)){
             lName=lName.trim();
             lName=lName.toUpperCase();
             queryFilter = queryFilter + ' Account__r.LastName =\''+String.escapeSingleQuotes(lName)+'\' AND';
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(fName)) {
                    fName=fName.trim();
                    fName=fName.toUpperCase();
                    queryFilter = queryFilter + ' Account__r.FirstName LIKE \''+String.escapeSingleQuotes(fName)+'%\' AND';
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(garZip)){
                queryFilter = queryFilter + ' Mailing_Postal_Code_Garage__c =\''+String.escapeSingleQuotes(garZip)+'\' AND' ;
        }    
        if(TFSC_Utils.isNotNullAndNotEmpty(busiName)){
                queryFilter = queryFilter + ' Account__r.Name LIKE \''+String.escapeSingleQuotes(busiName)+'%\' AND  Account__r.RecordType.Name =\'Business Account\' AND';       
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(vINFull)){
                vINFull=vINFull.replaceAll(' ','');
                vINFull = vINFull.toUpperCase();
                queryFilter = queryFilter + ' Vehicle_Identification_Number__c =\''+String.escapeSingleQuotes(vINFull)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(vIN8)){
                vIN8 =vIN8.replaceAll(' ','');
                vIN8 = vIN8.toUpperCase();
                queryFilter = queryFilter +' Financial_Account__r.Collateral__r.Vehicle_Identification_Number_Last_8_Ch__c =\''+String.escapeSingleQuotes(vIN8)+'\' AND' ;
        }    
        if(queryFilter.endsWith('AND')){    
            queryFilter = queryFilter.Substring(0,queryFilter.length()-4);//Remove the last "AND" from query String
        }
        return selectFields+' WHERE '+queryFilter+' ORDER BY '+queryOrder+' LIMIT '+queryLimit ;
    }
    private String ArchiveFAQuery(){
        String queryFilter = '';
        String selectFields = 'Select accountType__c, branch__c, accountClosedDate__c, businessName__c, financialAccountNumber__c, financialAccountStatus__c, firstName__c, Id, last8VinNumber__c, lastName__c, make__c, modelName__c, modelYear__c, ssn__c, tin__c, vehicleIdentificationNumber__c, zipcode__c from SfClosedAccount__x';
        String queryOrder = 'businessName__c , zipcode__c, financialAccountNumber__c '; // Order By fields
        String queryLimit = '51';//Put the max number of records limit here  
        
        if(TFSC_Utils.isNotNullAndNotEmpty(fANumber)){
            fANumber = fANumber.toUpperCase();
            if(fANumber.length() == 10 || fANumber.length() == 11 ){
                queryFilter = queryFilter + ' financialAccountNumber__c =\''+String.escapeSingleQuotes(fANumber)+'\' AND';
            }else if(fANumber.length() == 20 ){  
                if(fANumber.startsWith('000704') && fANumber.endsWith('0001') ){
                    fANumber = fANumber.substring(6,16);
                }else if(fANumber.startsWith('0000000000')){            
                    fANumber = fANumber.substring(10,12)+'0'+fANumber.substring(12,20);
                }
                queryFilter = queryFilter + ' financialAccountNumber__c =\''+String.escapeSingleQuotes(fANumber)+'\' AND';
            }
        }           
        if(TFSC_Utils.isNotNullAndNotEmpty(sSN)){
                queryFilter = queryFilter +' ssn__c =\''+String.escapeSingleQuotes(sSN)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(tIN)){
               queryFilter = queryFilter + ' tin__c =\''+String.escapeSingleQuotes(tIN)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(lName)){
            queryFilter = queryFilter + ' lastName__c =\''+String.escapeSingleQuotes(lName)+'\' AND';
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(fName)) {
                    queryFilter = queryFilter + ' firstName__c LIKE \''+String.escapeSingleQuotes(fName)+'%\' AND';
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(garZip)){
                queryFilter = queryFilter + ' zipcode__c =\''+String.escapeSingleQuotes(garZip)+'\' AND' ;
        }    
        if(TFSC_Utils.isNotNullAndNotEmpty(busiName)){
                queryFilter = queryFilter + ' businessName__c LIKE \''+String.escapeSingleQuotes(busiName)+'%\' AND  accountType__c =\'Business Account\' AND';       
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(vINFull)){
                vINFull = vINFull.toUpperCase();
                queryFilter = queryFilter + ' vehicleIdentificationNumber__c =\''+String.escapeSingleQuotes(vINFull)+'\' AND' ;
        }
        if(TFSC_Utils.isNotNullAndNotEmpty(vIN8)){
                vIN8 = vIN8.toUpperCase();
                queryFilter = queryFilter +' last8VinNumber__c =\''+String.escapeSingleQuotes(vIN8)+'\' AND' ;
        }    
        
        if(queryFilter.endsWith('AND')){    
            queryFilter = queryFilter.Substring(0,queryFilter.length()-4);//Remove the last "AND" from query String
        }
        //queryFilter = 'financialaccountnumber__c = ';
        System.debug('**** the archive query: '+selectFields+' WHERE '+queryFilter+' ORDER BY '+queryOrder+' LIMIT '+queryLimit);
        return selectFields+' WHERE '+queryFilter+' ORDER BY '+queryOrder+' LIMIT '+queryLimit ;
    }
    
    public String CallOutTibco_ws_SendFARequest(String archiveFANum, DateTime ClosedDate, String AcctBranch, String AcctType){
        string strResult = '';
        if(!Test.isRunningTest()){
            strResult = Tibco_ws_SendFARequest.SendRequest(archiveFANum, ClosedDate, AcctBranch, AcctType);
        }else{
            strResult=TestWSResponse;
        }
        return strResult;
    }
    
    public class ArchiveSearchResult{
        //Select accountType__c, branch__c, accountClosedDate__c, businessName__c, financialAccountNumber__c, financialAccountStatus__c, firstName__c, Id, last8VinNumber__c, lastName__c, make__c, modelName__c, modelYear__c, ssn__c, tin__c, vehicleIdentificationNumber__c, zipcode__c
        public String accountType {get; set;}
        public String branch {get; set;} 
        public String accountClosedDate {get; set;} 
        public String businessName {get; set;} 
        public String financialAccountNumber {get; set;} 
        public String financialAccountStatus {get; set;} 
        public String firstName {get; set;} 
        public String Id {get; set;} 
        public String last8VinNumber {get; set;} 
        public String lastName {get; set;} 
        public String make {get; set;} 
        public String modelName {get; set;} 
        public String modelYear {get; set;} 
        public String ssn {get; set;} 
        public String tin {get; set;} 
        public String vehicleIdentificationNumber {get; set;} 
        public String zipcode {get; set;}
        
        public ArchiveSearchResult(
                    String useaccountType,
                    String usebranch, 
                    String useaccountClosedDate, 
                    String usebusinessName, 
                    String usefinancialAccountNumber, 
                    String usefinancialAccountStatus, 
                    String usefirstName, 
                    String useId, 
                    String uselast8VinNumber, 
                    String uselastName, 
                    String usemake, 
                    String usemodelName, 
                    String usemodelYear, 
                    String usessn, 
                    String usetin, 
                    String usevehicleIdentificationNumber, 
                    String usezipcode){
            accountType = useaccountType;
            branch = usebranch; 
            accountClosedDate = useaccountClosedDate; 
            if(usebusinessName == null){
                businessName = usefirstName + ' ' + uselastName; 
            }else{
                businessName = usebusinessName; 
            }
            financialAccountNumber = usefinancialAccountNumber; 
            financialAccountStatus = usefinancialAccountStatus; 
            firstName = usefirstName; 
            Id = useId; 
            last8VinNumber = uselast8VinNumber; 
            lastName = uselastName; 
            make = usemake; 
            modelName = usemodelName; 
            modelYear = usemodelYear; 
            ssn = usessn; 
            tin = usetin; 
            vehicleIdentificationNumber = usevehicleIdentificationNumber; 
            zipcode = usezipcode;               
        }
    }
}