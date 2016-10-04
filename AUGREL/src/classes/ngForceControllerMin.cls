global class ngForceControllerMin{
    
    public Boolean makeGridVisible{get;set;}
    
    public ngForceControllerMin() {
        makeGridVisible = false;
    }
    
    public PageReference updateGridVisible() {
        return null;
    }
    
    public static List<Saved_Notes_Search__c> savedSearches  { get; set; }
    
    @RemoteAction
    global static List<Saved_Notes_Search__c> getSavedSearches() {
         String userProfileName =
           [SELECT u.Profile.Name FROM User u WHERE u.id = :Userinfo.getUserId()].Profile.Name;
       

          String qry = 
                   ' SELECT Id, Name, Search_Criteria__c, Globally_Available__c '  
                  + ' FROM Saved_Notes_Search__c ' +
                  + '  WHERE OwnerId = \'' + UserInfo.getUserId() + '\'' +
                  +'                 OR ' 
                  + '      Profile_Visibility__c INCLUDES (\'' + userProfileName + '\')' 
                  + '         ORDER BY  Globally_Available__c    DESC, Name ';
                          

                    
                    

            savedSearches =  Database.query(qry);
       
        return savedSearches;
    }
    
    @RemoteAction
    global static void insertSearch(String name, String criteria) {
        Saved_Notes_Search__c search = new Saved_Notes_Search__c();
        search.name = name;
        search.Search_Criteria__c = criteria;
        
        insert search;
    }
    
    
    @RemoteAction
    global static String insertSearchGetId(String name, String criteria) {
        Saved_Notes_Search__c search = new Saved_Notes_Search__c();
        search.name = name;
        search.Search_Criteria__c = criteria;
        
        insert search;
        return search.Id;
    }
    
    @RemoteAction
    global static void deleteSearch(String id) {
        Saved_Notes_Search__c search = new Saved_Notes_Search__c();
        search.Id = id; 
        delete search;
    }



    @remoteAction
    global static String query(String soql) {
        List<sObject> records;
        try {
            records = Database.query(soql);
        } catch (QueryException qe) {
            return '[{"message":"'+qe.getMessage()+'","errorCode":"INVALID_QUERY"}]';
        }
        
        Map<String, Object> result = new Map<String, Object>();
        result.put('records', records);
        result.put('totalSize', records.size());
        result.put('done', true);
        
        return JSON.serialize(result);
    }
    
    
    @remoteAction
    global static List<Task> queryTasks(String faId) {
        
        List<Task> listToReturn;
        listToReturn = [SELECT  Id, Source_Created_Date__c, Service_Request_User_Group__c, Collection_Activity_Code__c, 
                           Service_Request_Type__c, Description,  StarsSRNumber__c, Source_Created_By__c,
                           Source_System_Created_By__c, Service_Request_Category__c, Service_Result__c, 
                           Service_Type__c, Current_Mileage__c, Service_Recipient__c, SR_Last_Name_Business_Name__c, 
                           SR_First_Name__c, Status, LastModifiedBy.Name, LastModifiedDate, TransferReason__c, Dealer__c
                        FROM Task 
                        WHERE Financial_Account__c = :faId 
                        ORDER BY Source_Created_Date__c DESC
                        LIMIT 1000];
        System.Debug('Task size:' + listToReturn.size());
        return listToReturn;
        
    }
    
    
    @remoteAction
    global static List<Case> queryCases(String faId) {
        
        List<Case> listToReturn;
        listToReturn = [SELECT Id, Source_Created_Date__c, Service_Request_User_Group__c, Communication_Comments__c,    
                            Service_Request_Type__c, Description,  StarsSRNumber__c, Source_Created_By__c,
                            Source_System_Created_By__c, Category__c, Service_Result__c, Service_Type__c, 
                            Current_Mileage__c, Service_Recipient__c, SR_Last_Name_Business_Name__c, SR_First_Name__c, 
                            Status, LastModifiedBy.Name, LastModifiedDate, TransferReason__c, Dealer__c 
                         FROM Case 
                         WHERE Financial_Account__c = :faId
                         ORDER BY Source_Created_Date__c DESC
                         LIMIT 500];
        System.Debug('Case size:' + listToReturn.size());
        return listToReturn;
        
    }

    // Consolidate Notes - Refactor by Venkata - Start
    @remoteAction
    global static List<TFS_Activity__c> queryActivities(String faId) {
        
        List<TFS_Activity__c> listToReturn;
        listToReturn = [SELECT Id, Source_Created_Date__c, Service_Request_User_Group__c, Action__c,    
                            Service_Request_Type__c, Description__c,  StarsSRNumber__c, Source_Created_By__c,
                            Source_System_Created_By__c, Category__c, Service_Result__c, Service_Type__c, 
                            Current_Mileage__c, Service_Recipient__c, SR_Last_Name_Business_Name__c, SR_First_Name__c, 
                            Status__c, LastModifiedBy.Name, LastModifiedDate, Confirmation_Number__c, Dealer__c 
                         FROM TFS_Activity__c
                         WHERE Financial_Account__c = :faId
                         ORDER BY Source_Created_Date__c DESC
                         LIMIT 500];
        System.Debug('TFS Activity size:' + listToReturn.size());
        return listToReturn;
        
    }    

    @remoteAction
    global static List<SfSysEvent__x> querySysEvents(String faId) {
        
        List<SfSysEvent__x> listToReturn;
        try{
            Financial_Account__c fa = [SELECT Financial_Account_Number__c FROM Financial_Account__c WHERE Id = :faId];
            String faNumber;
            if (fa != null){
                faNumber = fa.Financial_Account_Number__c;
            }
            listToReturn = [SELECT id__c, sourceCreatedDate__c, serviceRequestUserGroup__c, action__c,    
                                serviceRequestType__c, description__c,  starsSrNumber__c, sourceCreatedBy__c,
                                sourceSystemCreatedBy__c, category__c, serviceResult__c, serviceType__c, 
                                currentMileage__c, serviceRecipient__c, srLastNameBusinessName__c, srFirstName__c, 
                                status__c, lastModifiedBy__c, lastModifiedDate__c, certifiedUsed__c, dealer__c
                             FROM SfSysEvent__x
                             WHERE financialAccountNumber__c = :faNumber 
                             ORDER BY sourceCreatedDate__c DESC
                             LIMIT 500];
        } catch (Exception ex) {
                listToReturn =  new List<SfSysEvent__x>();
        }
        System.Debug('SysEvents size:' + listToReturn.size());
        return listToReturn;
        
    }    

/**    @remoteAction
    global static List<SfTask__x> queryArchivedTasks(String faId) {
        
        List<SfTask__x> listToReturn;
        listToReturn = [SELECT  taskId__c, sourceCreatedDate__c, collActyPromiseAmt1__c, collActyCode__c, 
                           collActyPromiseAmt2__c, description__c,  collActyPromiseDate1__c, sourceCreatedBy__c,
                           sourceSystemCreatedBy__c, collActyPromiseDate2__c, collActyReviewDate__c, 
                           collAccountNumber__c, currentMileage__c, collRecommendedPassStgy__c, collUserId__c, 
                           ownerId__c, taskStatus__c, lastModifiedById__c, lastModifiedDate__c, priority__c, subject__c
                        FROM SfTask__x 
                        WHERE faId__c = :faId 
                        ORDER BY sourceCreatedDate__c DESC
                        LIMIT 500];
        System.Debug('Sf Task size:' + listToReturn.size());
        return listToReturn;
        
    }
    
    
    @remoteAction
    global static List<SfCase__x> queryArchivedCases(String faId) {
        
        List<SfCase__x> listToReturn;
        listToReturn = [SELECT id__c, sourceCreatedDateC__c, serviceRequestUserGroupC__c, communicationCommentsC__c,    
                            serviceRequestTypeC__c, description__c,  starsSrNumberC__c, sourceCreatedByC__c,
                            sourceSystemCreatedByC__c, serviceRequestCategoryC__c, serviceResultC__c, serviceTypeC__c, 
                            currentMileageC__c, serviceRecipientC__c, srLastNameBusinessNameC__c, srFirstNameC__c, 
                            status__c, lastModifiedById__c, lastModifiedDate__c, transferReasonC__c, dealerC__c
                         FROM SfCase__x 
                         WHERE financialAccountC__c = :faId
                         ORDER BY sourceCreatedDateC__c DESC
                         LIMIT 500];
        System.Debug('Sf Case size:' + listToReturn.size());
        return listToReturn;
        
    }
    
    @remoteAction
    global static List<SfActivity__x> queryArchivedActivities(String faId) {
        
        List<SfActivity__x> listToReturn;
        listToReturn = [SELECT id__c, sourceCreatedDateC__c, serviceRequestUserGroupC__c, actionC__c,    
                            serviceRequestTypeC__c, descriptionC__c,  starsSrNumberC__c, sourceCreatedByC__c,
                            sourceSystemCreatedByC__c, serviceRequestCategoryC__c, serviceResultC__c, serviceTypeC__c, 
                            currentMileageC__c, serviceRecipientC__c, srLastNameBusinessNameC__c, srFirstNameC__c, 
                            statusC__c, lastModifiedById__c, lastModifiedDate__c, confirmationNumberC__c, dealerC__c
                         FROM SfActivity__x
                         WHERE financialAccountC__c = :faId
                         ORDER BY sourceCreatedDateC__c DESC
                         LIMIT 500];
        System.Debug('Sf Activity size:' + listToReturn.size());
        return listToReturn;
        
    }    */

    // Consolidate Notes - Refactor by Venkata - End
}