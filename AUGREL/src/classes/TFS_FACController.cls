public  With sharing  class TFS_FACController {
    public Financial_Account_Customer__c contextFAC {get;set;}
    
    private final Financial_Account_Customer__c fac;
      private final Financial_Account_Customer__c oldFAC;
    public Boolean isAllUpdate{get;set;}
    public Boolean isSuccess{get;set;}
    public string overallConsentSelectedController{get;set;}
    public string overallConsentSelected{get;set;}
    public  string OldEmailId{get;set;}
    public string NewEmailId{get;set;}
    Public  string OldgarageHomePhone{get;set;}
    Public  string OldGarageWorkPhone{get;set;}
    Public   string OldBillToHomePhone{get;set;}
    Public   string OldBilltoWorkPhone{get;set;}
    Public   string OldMobilePhone{get;set;}
    public boolean IsChangedEmail{get;set;}
        Public final string NewgarageHomePhone{get;set;}
    Public final string NewGarageWorkPhone{get;set;}
    Public final  string NewBillToHomePhone{get;set;}
    Public final  string NewBilltoWorkPhone{get;set;}
    Public final  string NewMobilePhone{get;set;}
    Public string PhoneNumStringforWS{get;set;}
    public ConstructPhoneNumberValidation.values val = new ConstructPhoneNumberValidation.values();
    
        
     private final Id contextFAId;
        public List<SelectOption> getpaymentNotRecvdTxt() {
        List<SelectOption> options = new List<SelectOption>();
        if(overallConsentSelectedController == null){
                options.add(new SelectOption('','--None--'));
        }else if(overallConsentSelectedController == 'Y'){
                options.add(new SelectOption('','--None--'));
                options.add(new SelectOption('Y','Y'));    
                options.add(new SelectOption('N','N'));            
        }else if(overallConsentSelectedController == 'N'){
                options.add(new SelectOption('','--None--'));
                options.add(new SelectOption('N','N'));
                
        }
        return options;
    }
    public List<SelectOption> getPaymentNotRecvdEmail() {
        List<SelectOption> options = new List<SelectOption>();
        system.debug('**dd1:'+overallConsentSelectedController );
        if(overallConsentSelectedController == null){
                options.add(new SelectOption('','--None--'));
        }else if(overallConsentSelectedController == 'Y'){
                options.add(new SelectOption('','--None--'));
                options.add(new SelectOption('Y','Y'));    
                options.add(new SelectOption('N','N'));            
        }else if(overallConsentSelectedController == 'N'){
                options.add(new SelectOption('','--None--'));
                options.add(new SelectOption('N','N'));
                
        }
        return options;
    }


    Public  TFS_FACController(Apexpages.StandardController controller)
    {
        fac = (Financial_Account_Customer__c)controller.getRecord();
        If(fac!= null){
            contextFAC = getFACByDynamicSOQL((String)fac.Id);
            overallConsentSelectedController = contextFAC.Election_Overall_Consent__c;


          OldEmailId = contextFAC.Servicing_Email__c;
    val.OldgarageHomePhone = contextfac.Home_Phone_Garage__c;
     val.OldGarageWorkPhone = Contextfac.Work_Phone_Garage__c;
     val.OldBillToHomePhone = contextfac.HomePhone_BillTo__c;
    val.OldBilltoWorkPhone=contextfac.Work_Phone_Bill_To__c;
     val.OldMobilePhone=Contextfac.Mobile_Phone__c;
            
            System.debug('***Constructor - OldEmailId: '+OldEmailId);
            system.debug('print overall consetn'+overallConsentSelectedController);
            contextFAId = contextFAC.Financial_Account__c;
        }
                   
        
    }


    Private Financial_Account_Customer__c getFACByDynamicSOQL(String facId)
{
        try
        {
            String query = 'SELECT  Borrower_Position__c, Financial_Account_Customer__c,Account__r.IsPersonAccount, Account__r.PersonContactId, Account__r.LastName, Account__r.Name, Account__r.FirstName,';
            for(Schema.FieldSetMember f : this.getFACFields()) {
                query += f.getFieldPath() + ', ';
            }
            query += ' Election_Payment_NotReceivedText__c,Election_Payment_NotReceivedEmail__c ,Election_Overall_Consent__c,Election_Abbreviated_Consent__c,Id,CreatedById, LastModifiedById  FROM Financial_Account_Customer__c WHERE Id =\''+facId+'\'';
            
            System.debug('****'+query);
            return Database.query(query);
        }
        catch(Exception e)
        {
            //Utility.addError('There is error while Fetching existing Question using Dynamic SOQL in Field Set. Error Detail - '+e.getMessage()); //This is Utility Method to display error message on VF Page
        }
        return null;
    }
            /**
        *
        * Get Fields from Field Set. It is not used on VF, It used to create Dynamic SOQL.
        */
        Private List<Schema.FieldSetMember> getFACFields() {
            //SObjectType.Financial_Account_Customer__c.FieldSets.Mailing_Address_Phones.getFields();
            List<Schema.FieldSetMember> masterFACFlds4Query = new List<Schema.FieldSetMember>();
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Information.getFields());
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Garage_Address_Phones.getFields());
           masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Account_Servicing_Preferences.getFields());
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Billing_Address_Phones.getFields());
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Customer_Consents_Language.getFields());  
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Marketing_Preferences.getFields()); 
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Privacy_Elections.getFields()); 
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.System_Information.getFields());  
            masterFACFlds4Query.addAll( SObjectType.Financial_Account_Customer__c.FieldSets.Bankruptcy_and_SCRA_Information.getFields());  
            System.debug('******GetFACFields'+masterFACFlds4Query);
            return masterFACFlds4Query;
        }
    
    public pagereference Save()
    {
                    
        try
        {
         
        system.debug('****in SAVE context Update Context FAC');
           NewEmailId = contextfac.Servicing_Email__c;
          
            System.debug('***NewEmailId: '+NewEmailId);
            System.debug('***OldEmailId: '+OldEmailId);
            if(!TFSC_Utils.isNullOrEmpty(NewEmailId) && contextfac.Servicing_Email_Confirmed__c != true)
            {
            IsChangedEmail = TFSC_Utils.CompareValues(OldEmailId,NewEmailId);
            system.debug('***IsChangedEmail: ' + IsChangedEmail);
            if(IsChangedEmail)
            {
               emailValidation(NewEmailId);
            }
             }
            
                      
              if(!TFSC_Utils.isNullOrEmpty(contextfac.Home_Phone_Garage__c))
     val.NewgarageHomePhone = contextfac.Home_Phone_Garage__c;
            
                      if(!TFSC_Utils.isNullOrEmpty(Contextfac.Work_Phone_Garage__c))
     val.NewGarageWorkPhone = Contextfac.Work_Phone_Garage__c;
                        
                 if(!TFSC_Utils.isNullOrEmpty(contextfac.HomePhone_BillTo__c))
     val.NewBillToHomePhone = contextfac.HomePhone_BillTo__c;
            
              if(!TFSC_Utils.isNullOrEmpty(contextfac.Work_Phone_Bill_To__c))
                val.NewBilltoWorkPhone=contextfac.Work_Phone_Bill_To__c;
            
            if(!TFSC_Utils.isNullOrEmpty(Contextfac.Mobile_Phone__c))
     val.NewMobilePhone=Contextfac.Mobile_Phone__c;
     
            
            val.homephoneGarageConfirmed = contextFac.Invalid_Home_Phone_Acknowledged_Garage__c;
            val.WorkphoneGarageConfirmed = contextFac.Invalid_Work_Phone_Acknowledged_Garage__c;
            val.MobilePhoneConfirmed = contextfac.Invalid_Mobile_Phone_Acknowledged__c;
            val.HomephoneBilltoConfirmed = Contextfac.Invalid_Home_Phone_Acknowledged_BillTo__c;
            val.WorkphoneBilltoConfirmed = Contextfac.Invalid_Work_Phone_Acknowledged_BillTo__c;
     system.debug('NewgarageHomePhone: '+ val.NewgarageHomePhone);
     system.debug('OldgarageHomePhone: '+ val.OldgarageHomePhone);
          system.debug('NewgarageWorkPhone: '+  val.OldGarageWorkPhone);
     system.debug('OldgarageWorkPhone: '+  val.NewGarageWorkPhone);       
            
      PhoneNumStringforWS = ConstructPhoneNumberValidation.changeinPhoneValues(val);
      system.debug('PhoneNumStringforWS: '+ PhoneNumStringforWS);
            if(!TFSC_Utils.isNullOrEmpty(PhoneNumStringforWS))
            {
       TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_RequestParams WS_request = New TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_RequestParams();
         TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams WS_response = new TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams();
         WS_request.phoneNumber = PhoneNumStringforWS;
            WS_response = TFSC_WS_ValidatePhoneNumber.validatePhoneNumber(WS_request);
system.debug('WebservcieResponse: '+WS_response); 
            system.debug('WebservcieResponseRecordList: '+WS_response.ResponseRecordList); 
          if(WS_response!= null && WS_response.ResponseRecordList != null)
           {
            if(WS_response.StatusParams.ResultCode == 0 )
           {
               List<TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseRecord> ResponseList = new List<TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseRecord>();
               ResponseList = WS_response.ResponseRecordList ;
               for(Integer i=0 ; i<ResponseList.size() ; i++ )
               {
                   TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseRecord responserecord = ResponseList.Get(i);
                   system.debug('***responserecord: '+responserecord);
                   system.debug('***Number: '+responserecord.Number_x);

                 //  system.debug('***val.NewgarageHomePhone: '+long.valueof(val.NewgarageHomePhone.replaceAll('[^0-9]', '')));
                  if(val.NewgarageHomePhone!=null && TFSC_Utils.CompareValues(val.OldgarageHomePhone,val.NewgarageHomePhone) == true && string.valueOf(responserecord.Number_x)== '1' + val.NewgarageHomePhone.replaceAll('[^0-9]', ''))
                   {
                       system.debug('GarageHome');
                       Contextfac.Garage_Home_Phone_Status__c =responserecord.StatusNbr + ' '+responserecord.StatusDescription;
                       if( Contextfac.Flag_Home_Phone_IsMobile_Garage__c!=true &&  ('mobile'.equals(responserecord.Number_Type.Tolowercase()) || 'voip'.equals(responserecord.Number_Type.Tolowercase())) )
                           ContextFac.Flag_Home_Phone_IsMobile_Garage__c=True;
                       system.debug('****Contextfac.Garage_Home_Phone_Status__c: '+Contextfac.Garage_Home_Phone_Status__c);
                   }
                      if(val.NewGarageWorkPhone!= null && TFSC_Utils.CompareValues(val.OldGarageWorkPhone,val.NewGarageWorkPhone)== true &&string.valueof(responserecord.Number_x) ==  '1' +val.NewGarageWorkPhone.replaceAll('[^0-9]', ''))
                   {
                       system.debug('garageWork');
                       Contextfac.Garage_Work_Phone_Status__c =String.Valueof(responserecord.StatusNbr) + ' '+responserecord.StatusDescription;
                                              if( Contextfac.Flag_Work_Phone_IsMobile_Garage__c!=true &&  ('mobile'.equals(responserecord.Number_Type.Tolowercase()) || 'voip'.equals(responserecord.Number_Type.Tolowercase())) )
                           ContextFac.Flag_Work_Phone_IsMobile_Garage__c=True;
                   }
                     if(val.NewMobilePhone!=null && TFSC_Utils.CompareValues(val.OldMobilePhone,val.NewMobilePhone) == true &&string.valueof(responserecord.Number_x) == '1' + val.NewMobilePhone.replaceAll('[^0-9]', ''))
                   {
                        system.debug('MobilePhone');
                       Contextfac.Garage_Mobile_Phone_Status__c =String.Valueof(responserecord.StatusNbr) + ' '+responserecord.StatusDescription;
                        if( Contextfac.Flag_Mobile_Phone_IsMobile__c!=true &&  ('mobile'.equals(responserecord.Number_Type.Tolowercase()) || 'voip'.equals(responserecord.Number_Type.Tolowercase())) )
                           ContextFac.Flag_Mobile_Phone_IsMobile__c=True;
                        system.debug('MobilePhone'+ Contextfac.Garage_Mobile_Phone_Status__c);
                   }
                       if(val.NewBillToHomePhone!= null && TFSC_Utils.CompareValues(val.OldBillToHomePhone,val.NewBillToHomePhone) == true &&string.valueof(responserecord.Number_x) == '1' +val.NewBillToHomePhone.replaceAll('[^0-9]', ''))
                   {
                       system.debug('BilltoHome');
                       Contextfac.Bill_To_Home_Phone_Status__c =String.Valueof(responserecord.StatusNbr) + ' '+responserecord.StatusDescription;
                        if( Contextfac.Flag_Home_Phone_IsMobile_BillTo__c!=true &&  ('mobile'.equals(responserecord.Number_Type.Tolowercase()) || 'voip'.equals(responserecord.Number_Type.Tolowercase())) )
                           ContextFac.Flag_Home_Phone_IsMobile_BillTo__c=True;
                   }
                      if(val.NewBilltoWorkPhone!= null && TFSC_Utils.CompareValues(val.OldBilltoWorkPhone,val.NewBilltoWorkPhone)==true &&string.valueof(responserecord.Number_x) ==  '1'  +val.NewBilltoWorkPhone.replaceAll('[^0-9]', ''))
                   {
                        system.debug('BilltoWork');
                       Contextfac.Bill_To_Work_Phone_Status__c =String.Valueof(responserecord.StatusNbr) + ' '+responserecord.StatusDescription;
                                            if( Contextfac.Flag_Work_Phone_Is_Mobile_BillTo__c!=true &&  ('mobile'.equals(responserecord.Number_Type.Tolowercase()) || 'voip'.equals(responserecord.Number_Type.Tolowercase())) )
                           ContextFac.Flag_Work_Phone_Is_Mobile_BillTo__c=True;
                   }
               }
           }
           }
                }
               
         update  contextFAC;//This is to pass control to FAC Trigger
       PageReference facPage = new PageReference('/apex/TFS_FACPage_VF?id=' + fac.Id);
        facPage.setRedirect(true);
        return facPage; 
        }
        catch(Exception e)
        {
            return null;
        }
   }
    

    
    Private  TFSC_WS_EmailValidation.EmailValidation_ResponseParams emailValidation(string email)
    {
        TFSC_WS_EmailValidation.EmailValidation_RequestParams request = new TFSC_WS_EmailValidation.EmailValidation_RequestParams();
        TFSC_WS_EmailValidation.EmailValidation_ResponseParams WSCallResponse = new TFSC_WS_EmailValidation.EmailValidation_ResponseParams();
        request.email = email;
        System.debug('before call');
        WSCallResponse = TFSC_WS_EmailValidation.ValidateEmail(request);
        System.debug('Call Success');
        system.debug('***StatusCode: '+WSCallResponse.statusParams.ServiceStatusNbr );
        contextfac.Servicing_Email_Hygiene_Result__c = WSCallResponse.responseValues.HygieneResult;
        system.debug('*****WSCallResponse.responseValues.IronStdTimeStam: ' +WSCallResponse.responseValues.IronStdTimeStamp);
        contextfac.Servicing_Email_Validated_Time_Stamp__c = WSCallResponse.responseValues.IronStdTimeStamp;
        contextfac.Servicing_Email_Status__c = WSCallResponse.statusParams.ServiceStatusNbr +' '+WSCallResponse.statusParams.ServiceStatusDescription;
        return WSCallResponse;
    }
    
    

}