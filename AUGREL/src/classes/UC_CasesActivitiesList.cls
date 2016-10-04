public with sharing class UC_CasesActivitiesList {
  public Financial_Account__c FA  {get; set;}
  public List<item> dataList {get; set;}  
  
  public UC_CasesActivitiesList(apexPages.standardController controller) {
    FA = [select Id, name, recordTypeId, recordType.name, code_edit_message__c, type_code_description__c, Dealership__c from Financial_Account__c where Id = : controller.getId() limit 1 ];
    LoadCasesAndActivities();
  }
  
  public void LoadCasesAndActivities(){
    dataList = new List<item>();
    
    String soqlLimit = System.Label.Case_Activity_Limit;
    System.debug('**** loading Cases and Activities, dataList count: '+dataList.size());
    for (Case c : [Select Id, CaseNumber, Category__c, Service_Recipient__c, CreatedBy.Name, CreatedDate, Description, subject,
                LastModifiedBy.Name, LastModifiedDate, Service_Result__c, Status, Service_Request_Type__c, Service_Request_User_Group__c 
            from Case where financial_account__c = :FA.Id
            order by createdDate desc limit :Integer.ValueOf(System.Label.Case_Activity_Limit) ]) {
            if(dataList.size()<1000)
      dataList.add(new item('/'+c.Id, c.Id, c.caseNumber, c.CreatedBy.Name, c.CreatedDate, c.Subject, c.Service_Request_User_Group__c, c.description, c.LastModifiedBy.Name, c.lastModifiedDate, c.category__c, 'case', c.Status, c.Service_Request_Type__c, c.Service_Result__c, c.Service_Recipient__c));
    }
    
    for (TFS_Activity__c a : [select Id, Name, Subject__c, CreatedBy.Name, CreatedDate, description__c, lastModifiedDate, status__c, Category__c, Service_Recipient__c, 
                                         LastModifiedBy.Name, Service_Result__c, Service_Request_Type__c, Service_Request_User_Group__c, Topic__c            
                                         from TFS_Activity__c 
            where financial_account__c = :FA.Id
            order by createdDate desc limit :Integer.ValueOf(System.Label.Case_Activity_Limit) ]) {
      
      if(dataList.size()<1000)
      dataList.add(new item('/'+a.Id, a.Id, a.Name, a.CreatedBy.Name, a.CreatedDate, a.Subject__c, a.Service_Request_User_Group__c, a.description__c, a.LastModifiedBy.Name, a.lastModifiedDate, a.Category__c, 'activity', a.status__c, a.Topic__c, a.Service_Result__c, a.Service_Recipient__c));
    }
    
    // User Story W-001179   changes to display Tasks under Case and Activites - Start
    
    for (Task t : [Select Id, Subject, Source_Created_Date__c,   Source_Created_By__c, Service_Request_User_Group__c,  Description, Service_Request_Category__c,
                Collection_Activity_Code__c,  Service_Result__c, Service_Recipient__c,LastModifiedBy.Name,lastModifiedDate,Status 
            from Task where financial_account__c = :FA.Id
            order by Source_Created_Date__c desc limit :Integer.ValueOf(System.Label.Case_Activity_Limit) ]) {
      if(dataList.size()<1000)
      dataList.add(new item('/'+t.Id, t.Id, t.Collection_Activity_Code__c, t.Source_Created_By__c, t.Source_Created_Date__c, t.Subject, t.Service_Request_User_Group__c, t.description, 
                    t.LastModifiedBy.Name, t.lastModifiedDate, t.Service_Request_Category__c, 'task', t.Status, t.Subject, t.Service_Result__c, t.Service_Recipient__c));
    }
    
    // User Story W-001179   changes to display Tasks under Case and Activites - End
    
    
  }
  //'0016716341' 
  public void LoadArchivedSRs(){
    
    dataList = new List<item>();
    dataList.clear();
    System.debug('**** loading Archive SRs, dataList count: '+dataList.size());
    try{
      LIST<SfArchivedStarsSR__x> aSRs = new LIST<SfArchivedStarsSR__x>();
      if(!Test.isRunningTest()){
        aSRs = [Select Id, srNumber__c, srCreatedDate__c, srCreatedBy__c, userGroup__c, srDescriptionText__c, srCategory__c,srType__c, 
                    serviceResult__c, srRecipient__c, lastUpdatedBy__c, lastUpdatedDate__c, srStatus__c 
            from SfArchivedStarsSR__x 
            where financialAccountNumber__c =: FA.name 
            limit :Integer.ValueOf(System.Label.Case_Activity_Limit)];
        for(SfArchivedStarsSR__x SRs : aSRs){
          if(dataList.size()<1000)
          dataList.add(new item('/x/SfArchivedStarsSR__x/'+SRs.srNumber__c, SRs.Id, SRs.srNumber__c, SRs.srCreatedBy__c, 
              SRs.srCreatedDate__c,'', SRs.userGroup__c, SRs.srDescriptionText__c, SRs.lastUpdatedBy__c, SRs.lastUpdatedDate__c,
              SRs.srCategory__c, '', srs.srStatus__c, SRs.srType__c, SRs.serviceResult__c, SRs.srRecipient__c));
        }
      }
    }catch(Exception se){
      System.debug('*** error attempting to retrieve SfArchivedStarsSR__x: '+se.getMessage());
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Unable to connect with external object. please try again later'));
    }
  }
  public void LoadSysEvents(){
    
    LoadCasesAndActivities();
    System.debug('**** loading Cases and Activities, dataList count: '+dataList.size());
    try{
      if(!Test.isRunningTest()){
        LIST<SfSysEvent__x> aSE =[Select Id, id__c, sourceCreatedBy__c, sourceCreatedDate__c, serviceRequestUserGroup__c, description__c, Category__c, serviceRequestType__c, 
                serviceResult__c, serviceRecipient__c, lastModifiedBy__c, lastModifiedDate__c, status__c 
              from SfSysEvent__x
              where financialAccountNumber__c =: FA.name
              limit :Integer.ValueOf(System.Label.Case_Activity_Limit)];
        for(SfSysEvent__x SysEvt : aSE){
          Datetime useCreatedLastModDate;
          if(SysEvt.sourceCreatedDate__c == null){
            useCreatedLastModDate = Datetime.now();
          }else{
            useCreatedLastModDate = SysEvt.sourceCreatedDate__c;
          }
          if(dataList.size()<1000)
          dataList.add(new item('/x/SfSysEvent__x/'+SysEvt.id__c, SysEvt.id, SysEvt.id__c, SysEvt.sourceCreatedBy__c, 
              useCreatedLastModDate,'', SysEvt.serviceRequestUserGroup__c, SysEvt.description__c, SysEvt.lastModifiedBy__c, useCreatedLastModDate,
              SysEvt.Category__c, '', SysEvt.status__c, SysEvt.serviceRequestType__c, SysEvt.serviceResult__c, SysEvt.serviceRecipient__c));
        }  
      }
    }catch (Exception se){
      System.debug('*** error attempting to retrieve SfSysEvent__x: '+se.getMessage());
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Unable to connect with external object. please try again later'));
    }
  }
  
  public class item {
    public Id recId  {get; set;}
    public String DetailURL  {get; set;}
    public String name  {get; set;}
    public String createdBy {get; set;}
    public String createdDate {get; set;}
    public string subject {get; set;}
    public string userGroup {get; set;}
    public string description {get; set;}
    public string lastModifiedUser {get; set;}
    public string lastModifiedDate {get; set;}
    public string category {get; set;}
    public string type {get; set;}
    public string status {get; set;}
    public String topic {get; set;}
    public String serviceResult {get; set;}
    public String Contact {get; set;}
    
    
    public item(string DetailURL, Id rId, string Name, string createdBy, Datetime createdDate, string sub, String userGroup, string description, 
            String LMU, dateTime LMD, string category, string type, String status, String Topic, String serviceResult, String Contact) {
      this.DetailUrl = DetailURL;
      this.recId = rId;
      this.Name = name;
      this.createdBy = createdBy;
      this.createdDate = createdDate.format();
      this.subject = sub;
      this.userGroup = userGroup;
      this.description = description;
      this.lastModifiedUser = LMU;
      if(LMD != null){
        this.lastModifiedDate = LMD.format();  
      }      
      this.category = category;
      this.type = type;
      this.status = status;
      this.Topic = Topic;
      this.serviceResult = serviceResult;
      this.Contact = Contact;
    }
      
    
  } 
  public boolean isUrlpopup{get;set;}
  public string copytext{get;set;}
  public void openPopup()
    {
        isUrlpopup=true;       
    }
    public void urlpopupclose()
    {
        isUrlpopup=false;       
    }
}