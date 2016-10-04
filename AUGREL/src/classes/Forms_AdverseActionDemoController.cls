public Class Forms_AdverseActionDemoController{

Public static Form_Request__c frmReq;

public List<SelectOption> dispatchSelectOptions{get;set;}

    public Forms_AdverseActionDemoController() {
        sourceSystem = 'SFDC';
        populateDispatchSelectOptions();
       
    }

public String formNumber{get;set;}
public String creationDate{get;set;}
public String accountNumber{get;set;}
public String deviceName{get;set;}
public List<String> dispatchName{get;set;}
public String sourceSystem{get;set;}
public String requestId{get;set;}
public String recipient{get;set;}
String dispatchNm;

   public PageReference submit(){ 
      try{
         frmReq  = new Form_Request__c ();
         frmReq.Form_Number__c = formNumber;
         frmReq.Account_Number__c = accountNumber;
    
         if(creationDate!=null && creationDate!=''){
           frmReq.CreationDate__c= Date.valueof(creationDate);
         }     
         frmReq.Device_Name__c = deviceName;
         if(dispatchName.size()>0){
            dispatchNm=String.join(dispatchName,';');
         }
         frmReq.Dispatch_Name__c =dispatchNm;
         frmReq.SourceSystem__c = sourceSystem;
         frmReq.RequestID__c =requestId;
         if(recipient!=null && recipient!=''){
           frmReq.Recipient__c = recipient;
         }    
    
         
        
     invokeDAE();       
    
    
    }Catch(Exception e){
      ApexPages.Message apexMseg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()) ;
      ApexPages.addMessage(apexMseg);
      return null;
    }
    return null;
  }
 
  
 private static void invokeDAE(){
    Forms_RequestProcesser reqprocess = new Forms_RequestProcesser();
    Forms_Validation_Result__c validationresult = new Forms_Validation_Result__c();
    List<Form_Request_Line_Item__c> frmReqLineItems = new List<Form_Request_Line_Item__c>();
    Form_Request_Line_Item__c li = new Form_Request_Line_Item__c();
    li.FormAttributeKey__c='tmpkey####';
	li.FormAttributeValue__c = '1111';
    frmReqLineItems.add(li);
     
    validationresult = reqprocess.processInternalFormRequest(frmReq,frmReqLineItems);
     
     if(validationresult.Status__c=='Success'){
        ApexPages.Message apexMsg = new ApexPages.Message(ApexPages.Severity.Info,'Form Submitted Successfully') ;
        ApexPages.addMessage(apexMsg);
     }else{
        ApexPages.Message apexMsg1 = new ApexPages.Message(ApexPages.Severity.ERROR,validationresult.ErrorMessage__c);
        ApexPages.addMessage(apexMsg1);
     }
 }
private void populateDispatchSelectOptions() {
        dispatchSelectOptions = new List<SelectOption>();             
         dispatchSelectOptions.add( new SelectOption('Print Local', 'Print Local') );
         dispatchSelectOptions.add( new SelectOption('Network Print', 'Network Print') );
         dispatchSelectOptions.add( new SelectOption('Email', 'Email') );
         dispatchSelectOptions.add( new SelectOption('Fax', 'Fax') );
        }       
    
}