/**

Change Request History:
##########################################################################################

***/
@isTest
public class Forms_TestDataUtil{

    public static Form__c form;
    //insert records in customSetting Forms_ErrorMessages as they are being used in all the classes.
    public static void insertForms_ErrorMessages()
    {
        List<Forms_ErrorMessages__c> errorMsgsList = new List<Forms_ErrorMessages__c>();
        Forms_ErrorMessages__c sysException = new Forms_ErrorMessages__c();
         sysException.Name = 'System Exception';
         sysException.Error_code__c= '522';
         sysException.Error_Message__c= 'internal error occured';
         sysException.Error_Description__c= 'TestDescription';
         errorMsgsList.add(sysException);
         
        Forms_ErrorMessages__c serviceFail = new Forms_ErrorMessages__c();
         serviceFail.Name = 'ServiceFailure';
         serviceFail.Error_code__c= '511';
         serviceFail.Error_Message__C= 'The service call has encountered an error.';
         serviceFail.Error_Description__c= 'TestDescription';
         errorMsgsList.add(serviceFail);
         
        Forms_ErrorMessages__c invalidInput = new Forms_ErrorMessages__c();
         invalidInput.Name = 'Invalid Input';
         invalidInput.Error_code__c= '411';
         invalidInput.Error_Message__C= 'Invalid input data. Please ensure data is available';
         invalidInput.Error_Description__c= 'TestDescription';         
         errorMsgsList.add(invalidInput);
         
         Forms_ErrorMessages__c inSufficientData = new Forms_ErrorMessages__c();
         inSufficientData.Name = 'Insufficient Data';
         inSufficientData.Error_code__c= '711';
         inSufficientData.Error_Message__C= 'Insufficient data to process form request. Please reach out to support for details';
         inSufficientData.Error_Description__c= 'TestDescription';         
         errorMsgsList.add(inSufficientData);
         
         Forms_ErrorMessages__c misssingfields = new Forms_ErrorMessages__c();
         misssingfields.Name = 'Missing Fields';
         misssingfields.Error_code__c= '411';
         misssingfields.Error_Message__C= 'Missing Fields:';
         misssingfields.Error_Description__c= 'TestDescription';         
         errorMsgsList.add(misssingfields);
         
         Forms_ErrorMessages__c InvalidDataType = new Forms_ErrorMessages__c();
         InvalidDataType.Name = 'Invalid Datatype';
         InvalidDataType.Error_code__c= '411';
         InvalidDataType.Error_Message__C= 'Invalid Data Type:';
         InvalidDataType.Error_Description__c= 'TestDescription';         
         errorMsgsList.add(InvalidDataType);
         
         insert errorMsgsList;
         System.assertEquals(errorMsgsList.size(),6);   
       
    }
    public static Form__c insertForm(String formNumber,String entityKey){
        form = new Form__c();
        form.Form_Number__c = formNumber;
        form.Form_Type__c = 'Automated';
        form.Name = 'Test Form'+formNumber;
        form.certifiedmail__c=true;
        form.legalEnvelop__c=true;
        form.NumberOfCopies__c=2;
        form.returnEnvelopRequired__c=true;
        form.Entity_Key__c = entityKey;
        Insert form;
        system.assertNotEquals(form,null);
        return form;
    }
    
    //inserting form with recieved formNumber  as parameter.
    public static Form__c insertForm(String formNumber){
        form = new Form__c();
        form.Form_Number__c = formNumber;
        form.Form_Type__c = 'Automated';
        form.Name = 'Test Form'+formNumber;
        form.certifiedmail__c=true;
        form.legalEnvelop__c=true;
        form.NumberOfCopies__c=2;
        form.returnEnvelopRequired__c=true;
        form.Entity_Key__c = 'RescheduleSequenceNumber';
        Insert form;
        system.assertNotEquals(form,null);
        return form;        
    }
    
    // inserts formFieldJunction Records with sent form and formFields.
    public static void insertFormFieldJunction(Form__c formobj, List<Form_Field__c> formFieldsList){
        List<Form_Field_Junction__c> formFieldjunctionList = new List<Form_Field_Junction__c>();
        Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
        for(Form_Field__c formFieldObj :formFieldsList){
            formFieldJunction = new Form_Field_Junction__c();
            formFieldJunction.Form__c = formobj.Id;
            formFieldJunction.Form_Field__c = formFieldObj.Id;
            formFieldJunction.required__c =true;
            formFieldjunctionList.add(formFieldJunction);
        }
        if(formFieldjunctionList.size() > 0) insert formFieldjunctionList;
        system.assertEquals(formFieldjunctionList.size(),formFieldsList.size());        
    }
    
    //insert formFields for Initial Request.
    public static void insertFormFieldsForRequest(){    
                    
        /*
        Configuring FormFields for initial Request for which sourceSystem will be null
        */
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        Form_Field__c formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Form_Number__c';
        formField.Target_Field__c = 'FormId__c';        
        formField.Source_Field__c = '';
        formField.Input_Fields__c = '';
        formField.WS_Sequence__c = 150;
        formField.WS_DestinationNode__c='forms.form';
        formField.Line_item_field__c=false;
        formField.Line_item_type__c = null;
        formField.Display_Name__c = 'Form Number';
        formFieldsList.add(formField);
            
        Form_Field__c formField1 = new Form_Field__c();
        formField1.Data_Type__c = 'Integer';
        //formField1.Name = 'Account_Reference_Number__c';
        formField1.Name = 'Account_Number__c';
        formField1.Target_Field__c = 'AccountNumber__c';       
        formField1.Display_Name__c = 'Account Number';
        formField1.Source_Field__c = '';
        formField1.Input_Fields__c = '';
        formField1.WS_Sequence__c = 1715;
        formField1.WS_DestinationNode__c='account.accountNumber';
        formField1.Line_item_field__c=false;
        formField1.Line_item_type__c = null;
        formFieldsList.add(formField1);
        
        Form_Field__c formField2 = new Form_Field__c();
        formField2.Data_Type__c = 'String';
        formField2.Name = 'Dispatch_Mode__c';
        formField2.Target_Field__c = '';     
        formField2.Display_Name__c = 'Dispatch Name';
        formField2.Source_Field__c = '';
        formField2.Input_Fields__c = '';
        formField2.Line_item_field__c=false;
        formField2.Line_item_type__c = null;
        formFieldsList.add(formField2);
        
        Form_Field__c formField3 = new Form_Field__c();
        formField3.Data_Type__c = 'String';
        formField3.Name = 'entitykey';
        formField3.Target_Field__c = '';       
        formField3.Source_Field__c = '';
        formField3.Input_Fields__c = '';
        formField3.Line_item_field__c=false;
        formField3.Line_item_type__c = null;
        formFieldsList.add(formField3);
        
        Form_Field__c formField4 = new Form_Field__c();
        formField4.Data_Type__c = 'String';
        formField4.Name = 'externalid';
        formField4.Target_Field__c = '';        
        formField4.Source_Field__c = '';
        formField4.Input_Fields__c = '';
        formField4.Line_item_field__c=false;
        formField4.Line_item_type__c = null;
        formField4.Display_Name__c = 'External ID';
        formFieldsList.add(formField4);

        Form_Field__c formField5 = new Form_Field__c();
        formField5.Data_Type__c = 'Date';
        formField5.Name = 'CreationDate__c';
        formField5.Target_Field__c = 'CustomDate__c';        
       formField5.Source_Field__c = '';
        formField5.Input_Fields__c = '';
        formField5.WS_Sequence__c = 10;
        formField5.WS_DestinationNode__c='request.creationDate';
        formField5.Line_item_field__c=false;
        formField5.Line_item_type__c = null;
        formField5.Display_Name__c = 'Creation Date';
        formFieldsList.add(formField5);

        Form_Field__c formField6 = new Form_Field__c();
        formField6.Data_Type__c = 'String';
        formField6.Name = 'Form_Type__c';
        formField6.Target_Field__c = 'formType__c';        
        formField6.Source_Field__c = '';
        formField6.Input_Fields__c = '';
        formField6.WS_Sequence__c = 15;
        formField6.WS_DestinationNode__c='request.formType';
        formField6.Line_item_field__c=false;
        formField6.Line_item_type__c = null;
        formField6.Display_Name__c = 'Form Type';
        formFieldsList.add(formField6); 
        
        Form_Field__c formField7 = new Form_Field__c();
        formField7.Data_Type__c = 'Integer';
        formField7.Name = 'Recipient__c';
        formField7.Target_Field__c = 'CustomString1__c';        
        formField7.Source_Field__c = '';
        formField7.Input_Fields__c = '';
        formField7.Line_item_field__c=false;
        formField7.Line_item_type__c = null;
        formField7.Display_Name__c = 'Recipient';
       formFieldsList.add(formField7);
       
        Form_Field__c formField8 = new Form_Field__c();
        formField8.Data_Type__c = 'String';
        formField8.Name = 'Dispatch_Name__c';
        formField8.Target_Field__c = 'DispatchName__c';
        formField8.Source_Field__c = '';
        formField8.Input_Fields__c = '';
        formField8.WS_Sequence__c = 25;
        formField8.WS_DestinationNode__c='request.dispatches|dispatch.name';
        formField8.Line_item_field__c=true;
        formField8.Line_item_type__c = 'Dispatch';
        formField8.Display_Name__c = 'Dispatch';
        formFieldsList.add(formField8);
        
        Form_Field__c formField9 = new Form_Field__c();
        formField9.Data_Type__c = 'Boolean';
        formField9.Name = 'LegalEnvelop__c ';
        formField9.Target_Field__c = 'isLegalEnvelop__c ';
        formField9.Source_Field__c = '';
        formField9.Input_Fields__c = '';
        formField9.WS_Sequence__c = 45;
        formField9.WS_DestinationNode__c='request.dispatches|dispatch.isLegalEnvelop';
        formField9.Line_item_field__c=true;
        formField9.Line_item_type__c = 'Dispatch';
        formField9.Display_Name__c = 'Legal Envelope';
        formFieldsList.add(formField9);
        
        Form_Field__c formField10 = new Form_Field__c();
        formField10.Data_Type__c = 'String';
        formField10.Name = 'returnEnvelop__c';
        formField10.Target_Field__c = 'returnEnvelop__c';
        formField10.Source_Field__c = '';
        formField10.Input_Fields__c = '';
        formField10.WS_Sequence__c = 40;
        formField10.WS_DestinationNode__c='request.dispatches|dispatch.returnEnvelop';
        formField10.Line_item_field__c=true;
        formField10.Line_item_type__c = 'Dispatch';
        formField10.Display_Name__c = 'Return Envelope';
        formFieldsList.add(formField10);
                            
        insert formFieldsList;
        system.assertEquals(formFieldsList.size(),11);       
        insertFormFieldJunction(form,formFieldsList);

    }
    
    /*FormFields for Response where sourceSystem is ALFA. These fields names should be similar 
    to metadata fields names of DocumentRequest__c Object.*/
    public static void insertFormFieldsForResponse()
    {
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        Form_Field__c formFieldObj= new Form_Field__c();
        formFieldObj.Name='FormId__c';
        formFieldObj.Target_Field__c = 'FormId__c';
        formFieldObj.Data_Type__c = 'String';
        formFieldObj.source_system__c='ALFA';
        formFieldObj.WS_Sequence__c = 150;
        formFieldObj.WS_DestinationNode__c='forms.form';
        formFieldObj.Line_item_field__c=false;
        formFieldObj.Line_item_type__c = null;
        formFieldObj.Display_Name__c = 'Form Number';
        formFieldsList.add(formFieldObj);       
        
        Form_Field__c formFieldObj1= new Form_Field__c();
        formFieldObj1.Name='Recipient_Address1__c';
        formFieldObj1.Target_Field__c = 'Recipient_Address1__c';
        formFieldObj1.Data_Type__c = 'String';
        formFieldObj1.source_system__c='ALFA';
        formFieldObj1.WS_Sequence__c = 220;
        formFieldObj1.WS_DestinationNode__c='RecipientAddress';
        formFieldObj1.Line_item_field__c=false;
        formFieldObj1.Line_item_type__c = null;
        formFieldObj1.Display_Name__c = 'RecipientAddress';
        formFieldsList.add(formFieldObj1);
        
        Form_Field__c formFieldObj2= new Form_Field__c();
        formFieldObj2.Name='AccountNumber__c';
        formFieldObj2.Target_Field__c = 'AccountNumber__c';
        formFieldObj2.Data_Type__c = 'String';
        formFieldObj2.source_system__c='ALFA';
        formFieldObj2.WS_Sequence__c = 1715;
        formFieldObj2.WS_DestinationNode__c='account.accountNumber';
        formFieldObj2.Line_item_field__c=false;
        formFieldObj2.Line_item_type__c = null;
        formFieldObj2.Display_Name__c = 'Account Number';
        formFieldsList.add(formFieldObj2);
        
        Form_Field__c formFieldObj3= new Form_Field__c();
        formFieldObj3.Name='NextMonthPaymentAmount__c';
        formFieldObj3.Target_Field__c = 'NextMonthPaymentAmount__c';
        formFieldObj3.Data_Type__c = 'Decimal';
        formFieldObj3.source_system__c='ALFA';
        formFieldObj3.WS_Sequence__c = 1750;
        formFieldObj3.WS_DestinationNode__c='account.NextMonthPaymentAmount';
        formFieldObj3.Line_item_field__c=false;
        formFieldObj3.Line_item_type__c = null;
        formFieldObj3.Display_Name__c = 'Next Month Payment Amount';
        formFieldsList.add(formFieldObj3);
        
        Form_Field__c formFieldObj4= new Form_Field__c();
        formFieldObj4.Name='CurrentDueDate__c';
        formFieldObj4.Target_Field__c = 'CurrentDueDate__c';
        formFieldObj4.Data_Type__c = 'Date';
        formFieldObj4.source_system__c='ALFA';
        formFieldObj4.WS_Sequence__c = 3415;
        formFieldObj4.WS_DestinationNode__c='account.extension.extensionPayments.extDueItem.currentduedate';
        formFieldObj4.Line_item_field__c=false;
        formFieldObj4.Line_item_type__c = null;
        formFieldObj4.Display_Name__c = 'Current Due Date';
        formFieldsList.add(formFieldObj4);
        
        Form_Field__c formFieldObj5= new Form_Field__c();
        formFieldObj5.Name='Dealer_Number__c';
        formFieldObj5.Target_Field__c ='Dealer_Number__c'; 
        formFieldObj5.Data_Type__c = 'String';
        formFieldObj5.source_system__c='ALFA';
        formFieldObj5.WS_Sequence__c = 5830;
        formFieldObj5.WS_DestinationNode__c='dealer.dealerNumber';
        formFieldObj5.Line_item_field__c=false;
        formFieldObj5.Line_item_type__c = null;
        formFieldObj5.Display_Name__c = 'Dealer Number';
        formFieldsList.add(formFieldObj5);
        
        Form_Field__c formFieldObj6= new Form_Field__c();
        formFieldObj6.Name='CoCustomer_FirstName__c';
        formFieldObj6.Target_Field__c = 'CoCustomer_FirstName__c';
        formFieldObj6.Data_Type__c = 'String';
        formFieldObj6.source_system__c='ALFA';
        formFieldObj6.Line_item_field__c=false;
        formFieldObj6.Line_item_type__c = null;
        formFieldObj6.Display_Name__c = 'CoCustomer FirstName';
        formFieldsList.add(formFieldObj6);       
        
            
        insert formFieldsList;
        system.assertEquals(formFieldsList.size(),7);       
        insertFormFieldJunction(form,formFieldsList);   
    
    }

    public static void insertFormFieldsForALFAandSFDC(){    
                    
        /*
        Configuring FormFields to request ALFA and SFDC
        */
        List<FromServices__c> formServiceList = insertService();
        Map<String, FromServices__c> formServiceNameObjectMap = new Map<String, FromServices__c>();
        for(FromServices__c formService :formServiceList){
            formServiceNameObjectMap.put(formService.Name, formService);
        }
        
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        Form_Field__c formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Make Name';
        formField.Target_Field__c = 'Make';
        formField.Source_System__c = 'ALFA';
        formField.Form_Service__c = formServiceNameObjectMap.get('TerminationQuoteService.loadQuote').Id;
        formField.Service_Level__c = '1';
        formField.Input_Fields__c = 'TerminationQuoteIdentifier';
        formField.Display_Name__c = 'Make Name';
        formFieldsList.add(formField);
        
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Make Name';
        formField.Target_Field__c = 'Make';
        formField.Source_System__c = 'ALFA';
        formField.Form_Service__c = formServiceNameObjectMap.get('AssetService.loadAsset').Id;
        formField.Service_Level__c = '2';
        formField.Input_Fields__c = 'assetIdentifier';
        formField.Display_Name__c = 'assetIdentifier';
        formField.DependantService__c = formServiceNameObjectMap.get('TerminationQuoteService.loadQuote').Id;
        formFieldsList.add(formField);
        
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Customer Name';
        formField.Target_Field__c = 'Customer';
        formField.Source_System__c = 'ALFA';
        formField.Form_Service__c = formServiceNameObjectMap.get('ThirdPartyService.loadThirdParty').Id;
        formField.Service_Level__c = '2';
        formField.Input_Fields__c = 'assetIdentifier';
        formField.Display_Name__c = 'assetIdentifier';
        //formField.DependantService__c = formServiceNameObjectMap.get('TerminationQuoteService.loadQuote').Id;
        formFieldsList.add(formField);
        
        if(form.Form_Number__c == '5001' || form.Form_Number__c == '5002'){
            formField = new Form_Field__c();
            formField.Data_Type__c = 'String';
            formField.Name = 'Make Year';
            formField.Target_Field__c = 'MakeYear';
            formField.Source_System__c = 'ALFA';
            formField.Form_Service__c = formServiceNameObjectMap.get('AssetService.loadAssetDummy').Id;
            formField.Service_Level__c = '1';
            formField.Input_Fields__c = 'assetIdentifier';
            formField.Display_Name__c = 'assetIdentifier';
            formFieldsList.add(formField);
        }
        
        List<Forms_QueryConfig__c> queryConfigList = insertQueryConfigRecords();
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Effective State Name';
        formField.Target_Field__c = 'effectivestatename';
        formField.Source_System__c = 'SFDC';
        formField.Source_Object__c = 'Forms_EffectiveState__c';
        formField.Source_Field__c = 'State_Name__c';
        formField.Display_Name__c = 'Effective State Name';
        formField.Forms_QueryConfig__c = queryConfigList[0].Id;
        formFieldsList.add(formField);
        
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Late Charge Due';
        formField.Target_Field__c = 'latechargedue';
        formField.Source_System__c = 'SFDC';
        formField.Source_Object__c = 'Financial_Account__c';
        formField.Source_Field__c = 'Charges_Late__c';
        formField.Display_Name__c = 'Late Charge Due';
        formField.Forms_QueryConfig__c = queryConfigList[1].Id;
        formFieldsList.add(formField);
        
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Exchange Account Number';
        formField.Target_Field__c = 'exchangeaccountnumber';
        formField.Source_System__c = 'SFDC';
        formField.Source_Object__c = 'Financial_Account__c';
        formField.Source_Field__c = 'Exchange_Account_Number__c';
        formField.Display_Name__c = 'Exchange Account Number';
        formField.Forms_QueryConfig__c = queryConfigList[1].Id;
        formFieldsList.add(formField);        

        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Payoff Amount';
        formField.Target_Field__c = 'payoffamount';
        formField.Source_System__c = 'SFDC';
        formField.Source_Object__c = 'Financial_Account__c';
        formField.Source_Field__c = 'Payoff_Amount_Gross__c';
        formField.Forms_QueryConfig__c = queryConfigList[2].Id;
        formFieldsList.add(formField);  
        
        formField = new Form_Field__c();
        formField.Data_Type__c = 'String';
        formField.Name = 'Phone number';
        formField.Target_Field__c = 'customerphone';
        formField.Source_System__c = 'SFDC';
        formField.Source_Object__c = 'Contact';
        formField.Source_Field__c = 'Phone';
        formField.Display_Name__c = 'Phone number';
        formField.Forms_QueryConfig__c = queryConfigList[2].Id;
        formFieldsList.add(formField);
              
        Insert formFieldsList;
        if(form.Form_Number__c == '5001' || form.Form_Number__c == '5002')
            system.assertEquals(formFieldsList.size(),9);
        else
            system.assertEquals(formFieldsList.size(),8);       
        insertFormFieldJunction(form,formFieldsList);

    }
    public static Form_Request__c getFormRequest(String formNumber){   
        //Success Scenario giving all valid values without null
        Form_Request__c formReq = new Form_Request__c();
        
        formReq.Dispatch_Name__c='Print Central;Print Local;Network print;Email;Fax';//TC_005,TC_019
        formReq.Form_Type__c='Automated';//TC_005
        formReq.Form_Number__c=formNumber;//TC_005,TC_009
        formReq.CreationDate__c=Date.VAlueOf('2015-10-29 00:00:00');//TC_005,TC_009,TC_017
        formReq.Device_Name__c = 'TFSW3F2018A';//TC_005,TC_019
        formReq.SourceSystem__c = 'ALFA';//TC_005,TC_019
        formReq.Target_System__c = 'FILENET';//TC_005,TC_019
        formReq.Recipient__c = '12345';//TC_005,TC_009
        formReq.Effective_State_Code__c = 'CA';//TC_005,TC_019
        system.assertNotEquals(formReq,null);       
        return formReq;     
    }
    //get valid FormRequest with all valid values assigned to fields.
    public static Form_Request__c getValidFormRequest(String formNumber){   
        //Success Scenario giving all valid values without null
        Form_Request__c formReq = new Form_Request__c();
        //formReq.Account_Reference_Number__c='70400100000010001';//TC_005
        formReq.Account_Number__c='70400100000010001';//TC_005,TC_009
        formReq.Dispatch_Name__c='Print Central;Print Local;Network print;Email;Fax';//TC_005,TC_019
        formReq.Form_Type__c='Automated';//TC_005
        formReq.Form_Number__c=formNumber;//TC_005,TC_009
        formReq.CreationDate__c=Date.VAlueOf('2015-10-29 00:00:00');//TC_005,TC_009,TC_017
        formReq.Device_Name__c = 'TFSW3F2018A';//TC_005,TC_019
        formReq.SourceSystem__c = 'ALFA';//TC_005,TC_019
        formReq.Target_System__c = 'FILENET';//TC_005,TC_019
        formReq.Recipient__c = '12345';//TC_005,TC_009
        formReq.Effective_State_Code__c = 'CA';//TC_005,TC_019
        system.assertNotEquals(formReq,null);       
        return formReq;     
    }
    
    //get Invalid FormRequest with mandatory values as null and wrong type and format.
    public static Form_Request__c getInvalidFormRequest(String formNumber)
    {   
        //Failure Scenario giving  values as null for mandatory fields and invalid data.
        Form_Request__c formReq = new Form_Request__c();
       // formReq.Account_Reference_Number__c='Acc70400100000010001';//Assigning string for field which is configured as Integer in Form_Field__c
       formReq.Account_Number__c='Acc70400100000010001';//TC_006,TC_010
        //formReq.Dispatch_Mode__c=null;//Mandatory Field Giving Null,TC_010,TC_020
        formReq.Form_Type__c=null;//TC_006
        formReq.Form_Number__c=formNumber;//TC_005,TC_010
        //formReq.CreationDate__c=Date.VAlueOf('');//MAndatory Field giving Null,TC_005,TC_011,TC_018
        formReq.Device_Name__c = 'TFSW3F2018A';//TC_005
        formReq.SourceSystem__c = 'ALFA';//TC_005
        formReq.Target_System__c = 'FILENET';//TC_005
        formReq.Recipient__c = 'CUSTOMER';//TC_005,TC_009
        formReq.Effective_State_Code__c = 'CA';//TC_005
        system.assertNotEquals(formReq,null);
        return formReq;     
    }
    
    //get valid DocumentRequest with all valid values assigned to fields.
    public static Document_Request__c getDocumentRequest(String formId){
        case caseobj = getCase();
        Document_Request__c docRequest = new Document_Request__c();
        docRequest.AccountNumber__c='70400100000010001';//TC_027,TC_037
        docRequest.CurrentDueDate__c=date.ValueOf('2015-10-29 00:00:00');//TC_027,TC_035
        docRequest.Dealer_Number__c='Dealer123';//TC_027,TC_037
        docRequest.FormId__c=formId;
        docRequest.Case__c= caseobj.id;//TC_029,TC_031
        docRequest.NextMonthPaymentAmount__c=2000.0;//TC_027,TC_041,TC_043
        docRequest.Recipient_Address1__c='North California';//TC_027,TC_037
        docRequest.Dispatch_Name__c='Print Central,Print Local,Network print,Email,Fax';//TC_027,TC_037
        system.assertNotEquals(docRequest,null);
        return docRequest;//TC_033
    }
    
    //get Invalid DocumentRequest with mandatory values as null and wrong type and format.
    public static Document_Request__c getInvalidDocReq(String formId)
    {
        case caseobj = getCase();
        Document_Request__c docRequest = new Document_Request__c();
        docRequest.AccountNumber__c='Account123';//TC_028,TC_038
        //docRequest.CurrentDueDate__c;//skipping mandatory field null,TC_036
        docRequest.Dealer_Number__c='';//assigning null for mandatory field.TC_028,TC_038
        docRequest.FormId__c=formId;
        docRequest.Case__c= caseobj.id;//TC_029,TC_031
        docRequest.NextMonthPaymentAmount__c=2014;//TC_027,TC_041,TC_044
        docRequest.Recipient_Address1__c='North California';//TC_027,TC_037
        system.assertNotEquals(docRequest,null);
        return docRequest;//TC_034
    }
    
    //case is mandatory field for DocumentRequest so, insert case and use this Id.
    public static case getCase()
    {
        case caseobj = new case();
        caseobj.Status='New';
        caseobj.Origin='Email';
        caseobj.KM_Department__c='TestDepartment';
        caseobj.KM_Change_Category__c = 'TestCategory';
        caseobj.KM_Documentation_Impacted__c='TestDocumentation';
        insert caseobj;
        system.assertNotEquals(caseobj,null);      
        return caseobj;    
    }
    
    //get List of formRequest Attributes with one valid and one invalid
    public static List<Form_Request_Line_Item__c> getFormReqLineItems()
    {
        List<Form_Request_Line_Item__c> lineItems = new List<Form_Request_Line_Item__c>();
        
        Form_Request_Line_Item__c formReqLineItem = new Form_Request_Line_Item__c();        
        formReqLineItem.FormAttributeKey__c='entitykey';//TC_007,TC_011,TC_021
        formReqLineItem.FormAttributeValue__c='5555';//TC_007,TC_011,TC_021
        
        Form_Request_Line_Item__c formReqLineItem1 = new Form_Request_Line_Item__c();        
        formReqLineItem1.FormAttributeKey__c='externalid';//TC_007,TC_011,TC_021
        formReqLineItem1.FormAttributeValue__c='';//assigning null for mandatory field,TC_008,TC_012,TC_022
         
        
        lineItems.add(formReqLineItem);
        lineItems.add(formReqLineItem1);
        
        system.assertEquals(lineItems.size(),2);       
        return lineItems;       
    
    }
    
    //get List of formRequest Attributes with one all valid 
    public static List<Form_Request_Line_Item__c> getvalidFormReqLineItems()
    {
        List<Form_Request_Line_Item__c> lineItems = new List<Form_Request_Line_Item__c>();
        
        Form_Request_Line_Item__c formReqLineItem = new Form_Request_Line_Item__c();        
        formReqLineItem.FormAttributeKey__c='entitykey';
        formReqLineItem.FormAttributeValue__c='5555';
        
        Form_Request_Line_Item__c formReqLineItem1 = new Form_Request_Line_Item__c();        
        formReqLineItem1.FormAttributeKey__c='externalid';
        formReqLineItem1.FormAttributeValue__c='8888';
        
        lineItems.add(formReqLineItem);
        lineItems.add(formReqLineItem1);
        system.assertEquals(lineItems.size(),2);        
        return lineItems;       
    
    }
    
    public static Document_Request_Line_Item__c getDocREqLineItem(Document_Request__C docRequest)
    {
        Document_Request_Line_Item__c docReqLineItem = new Document_Request_Line_Item__c();
        docReqLineItem.name='TestDocReqLineItem';//TC_039
        docReqLineItem.Document_Request__c=docRequest.id;//TC_032
        docReqLineItem.Type__c = '1234';//TC_039
        docReqLineItem.CoCustomer_FirstName__c = 'testName';//TC_039
        system.assertNotEquals(docReqLineItem,null);
        return docReqLineItem;  
    
    }
    public static List<FromServices__c> insertService(){
        List<Attachment> attachmentList = new List<Attachment>();
        List<FromServices__c> formServiceList = new List<FromServices__c>();
        FromServices__c formService = new FromServices__c();
        formService.Name = 'TerminationQuoteService.loadQuote';
        formService.ServiceProvider__c = 'ALFA';
        formServiceList.add(formService);
        
        formService = new FromServices__c();
        formService.Name = 'AssetService.loadAsset';
        formService.ServiceProvider__c = 'ALFA';
        formService.MultiNode__c = true;
        formServiceList.add(formService);
        
        formService = new FromServices__c();
        formService.Name = 'AssetService.loadAssetDummy';
        formService.ServiceProvider__c = 'ALFA';
        formServiceList.add(formService);
        
        formService = new FromServices__c();
        formService.Name = 'ThirdPartyService.loadThirdParty';
        formService.ServiceProvider__c = 'ALFA';
        formService.MultiNode__c = true;
        formServiceList.add(formService);
        
        if(formServiceList.size() > 0) Insert formServiceList;
        
        String loadQuoteXML = '<vehicle>'+
                            '<accountnumber></accountnumber>'+
                            '<formid></formid>'+
                            '</vehicle>';
        Attachment attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[0].Id;
        attachment.Body = Blob.valueOf(loadQuoteXML); 
        attachmentList.add(attachment);
                  
        String loadAssetXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" >'+
                                '<soapenv:body>'+
                                +'<sec:vehicle xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:sec="http://ws.chpconsulting.com/alfa/agreement/v1/security">'+
                                '<v1:assetidentifier></v1:assetidentifier>'+
                               '<v1:make></v1:make>'+
                                '<v1:model></v1:model>'+
                                '<v1:year></v1:year>'+
                               '</sec:vehicle>'+
                                '</soapenv:body>'+
                                +'</soapenv:Envelope>';
                                
        attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[1].Id;
        attachment.Body = Blob.valueOf(loadAssetXML); 
        attachmentList.add(attachment);
        if(form.Form_Number__c == '5002'){
            loadAssetXML = 'Dummy String';
        }
        attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[2].Id;
        attachment.Body = Blob.valueOf(loadAssetXML); 
        attachmentList.add(attachment);
        
        if(attachmentList.size() > 0) Insert attachmentList;   
        insertServiceConfig(formServiceList);
        return formServiceList;
    }
    public static void insertServiceConfig(List<FromServices__c> formServiceList){
        FormServiceConfig__c formServiceConfig = new FormServiceConfig__c();
         List<FormServiceConfig__c> formServiceConfigList = new List<FormServiceConfig__c>();
        Map<String, List<String>> requestFields = new Map<String, List<String>>();
        requestFields.put('TerminationQuoteService.loadQuote', 
                new List<String>{'accountnumber', 'formid'});
                
        requestFields.put('AssetService.loadAsset', 
                new List<String>{'v1:assetidentifier', 'v1:make', 'v1:model', 'v1:year'});  
                
         requestFields.put('AssetService.loadAssetDummy', 
                new List<String>{'assetidentifier', 'make', 'model', 'year'});  
                
                                             
        Map<String, List<String>> responseFields = new Map<String, List<String>>();
        responseFields.put('TerminationQuoteService.loadQuote', 
                new List<String>{'assetidentifier'});
                
        responseFields.put('AssetService.loadAsset', 
                new List<String>{'v1:assetidentifier', 'v1:make', 'v1:model', 'v1:year', 'v1:name'});                
        
        responseFields.put('AssetService.loadAssetDummy', 
                new List<String>{'assetidentifier', 'make', 'model', 'year'}); 
        
        for(FromServices__c formServices :formServiceList){
            if(requestFields.containsKey(formServices.Name)){
                for(String requestField : requestFields.get(formServices.Name)){
                    formServiceConfig = new FormServiceConfig__c();
                    formServiceConfig.FormService__c = formServices.Id;
                    formServiceConfig.AttributeType__c = 'Request';
                    formServiceConfig.ChildNode__c = requestField;
                    if(formServices.Name == 'AssetService.loadAsset'){
                        formServiceConfig.ParentNode__c = 'soapenv:Envelope.soapenv:Body.sec:vehicle';
                    } else {
                        formServiceConfig.ParentNode__c = 'vehicle';
                    }
                    formServiceConfig.ReferenceAttribute__c = requestField;
                    formServiceConfigList.add(formServiceConfig);
                }
                for(String responseField : responseFields.get(formServices.Name)){
                    formServiceConfig = new FormServiceConfig__c();
                    formServiceConfig.FormService__c = formServices.Id;
                    formServiceConfig.AttributeType__c = 'Response';
                    formServiceConfig.ChildNode__c = responseField;
                    if(formServices.Name == 'AssetService.loadAsset'){
                        formServiceConfig.ParentNode__c = 'soapenv:Envelope.soapenv:Body.sec:vehicle';
                        
                    } else {
                        formServiceConfig.ParentNode__c = 'vehicle';
                    }
                    formServiceConfig.ReferenceAttribute__c = responseField;
                    formServiceConfig.allFields__c = true;
                    formServiceConfigList.add(formServiceConfig);
                    if(formServices.Name == 'AssetService.loadAsset' && responseField == 'v1:make'){
                        formServiceConfig = new FormServiceConfig__c();
                        formServiceConfig.FormService__c = formServices.Id;
                        formServiceConfig.AttributeType__c = 'Response';
                        formServiceConfig.ChildNode__c = responseField;
                        if(formServices.Name == 'AssetService.loadAsset'){
                            formServiceConfig.ParentNode__c = 'soapenv:Envelope.soapenv:Body.sec:vehicle';
                        } else {
                            formServiceConfig.ParentNode__c = 'vehicle';
                        }
                        formServiceConfig.ReferenceAttribute__c = responseField;
                        formServiceConfig.Seperator__c = ',';
                        formServiceConfig.allFields__c = false;
                        formServiceConfigList.add(formServiceConfig);
                    }
                    if(formServices.Name == 'AssetService.loadAsset' && responseField == 'v1:name'){
                        formServiceConfig = new FormServiceConfig__c();
                        formServiceConfig.FormService__c = formServices.Id;
                        formServiceConfig.AttributeType__c = 'Response';
                        formServiceConfig.ChildNode__c = responseField;
                        if(formServices.Name == 'AssetService.loadAsset'){
                            formServiceConfig.ParentNode__c = 'soapenv:Envelope.soapenv:Body.sec:vehicle.v1:variants.v1:variant';
                        } else {
                            formServiceConfig.ParentNode__c = 'vehicle';
                        }
                        formServiceConfig.IsAttribute__c = true;
                        formServiceConfig.AttributeKey__c = 'v1:name';
                        formServiceConfig.AttributeValue__c = 'LX';
                        formServiceConfig.Multiple_Elements_Node__c = true;
                        formServiceConfig.isMultipleAttribute__c = true;
                        formServiceConfig.Type__c = 'variant';
                        formServiceConfig.Key__c = 'variantname';
                        
                        formServiceConfig.ReferenceAttribute__c = responseField;
                        formServiceConfigList.add(formServiceConfig);
                    }
                    if(formServices.Name == 'AssetService.loadAsset' && responseField == 'v1:name'){
                        formServiceConfig = new FormServiceConfig__c();
                        formServiceConfig.FormService__c = formServices.Id;
                        formServiceConfig.AttributeType__c = 'Response';
                        formServiceConfig.ChildNode__c = responseField;
                        if(formServices.Name == 'AssetService.loadAsset'){
                            formServiceConfig.ParentNode__c = 'soapenv:Envelope.soapenv:Body.sec:vehicle.v1:variants.v1:variant';
                        } else {
                            formServiceConfig.ParentNode__c = 'vehicle';
                        }
                        formServiceConfig.Multiple_Elements_Node__c = true;
                        
                        formServiceConfig.Key__c = 'variantname';
                        formServiceConfig.ReferenceAttribute__c = responseField;
                        formServiceConfigList.add(formServiceConfig);
                    }
                }      
            }      
        }
        if(formServiceConfigList.size() > 0) insert formServiceConfigList;
    }
    
    public static List<FromServices__c> insertServiceXMLBuilder(){
        List<Attachment> attachmentList = new List<Attachment>();
        List<FromServices__c> formServiceList = new List<FromServices__c>();
        FromServices__c formService = new FromServices__c();
        formService.Name = 'ThirdPartyService.listThirdPartysForExternalReference';
        formService.ServiceProvider__c = 'ALFA';
        formServiceList.add(formService);
        
        formService = new FromServices__c();
        formService.Name = 'ScheduleEnquiryService.Loadschedule';
        formService.ServiceProvider__c = 'ALFA';
        formServiceList.add(formService);
        
        formService = new FromServices__c();
        formService.Name = 'ScheduleEnquiryService.LoadscheduleDummy';
        formService.ServiceProvider__c = 'ALFA';
        formServiceList.add(formService);
        
        if(formServiceList.size() > 0) Insert formServiceList;
        
        String loadQuoteXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:thir="http://ws.chpconsulting.com/alfa/thirdparty/v1/thirdparty">'+
                       '<soapenv:Header>'+
                          '<v1:context>'+
                             '<v1:data></v1:data>'+
                             '<v1:realmId></v1:realmId>'+
                             '<v1:sessionId></v1:sessionId>'+
                             '<v1:systemId></v1:systemId>'+
                             '<v1:uniqueInterfaceId></v1:uniqueInterfaceId>'+
                             '<v1:userId></v1:userId>'+
                          '</v1:context>'+
                       '</soapenv:Header>'+
                       '<soapenv:Body>'+
                          '<thir:listThirdPartysForExternalReference>'+
                             '<externalSystemCode></externalSystemCode>'+
                             '<externalId></externalId>'+
                          '</thir:listThirdPartysForExternalReference>'+
                       '</soapenv:Body>'+
                    '</soapenv:Envelope>';
        Attachment attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[0].Id;
        attachment.Body = Blob.valueOf(loadQuoteXML); 
        attachmentList.add(attachment);
                  
        String loadAssetXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:enq="http://ws.chpconsulting.com/alfa/schedule/v1/enquiry" xmlns:v11="http://ws.chpconsulting.com/alfa/contract/v1">'+
                         '<soapenv:Header>'+  
                            '<v1:context>'+
                                '<v1:data></v1:data>'+
                                '<v1:realmId></v1:realmId>'+
                                '<v1:sessionId></v1:sessionId>'+
                                '<v1:systemId></v1:systemId>'+
                                '<v1:uniqueInterfaceId></v1:uniqueInterfaceId>'+
                                '<v1:userId></v1:userId>'+
                            '</v1:context>'+
                        '</soapenv:Header>'+
                        '<soapenv:Body>'+
                            '<enq:loadSchedule>'+
                                '<scheduleIdentifier> '+
                                    '<v11:agreementNumber></v11:agreementNumber>'+
                                    '<v11:scheduleNumber></v11:scheduleNumber>'+  
                                '</scheduleIdentifier>'+
                            '</enq:loadSchedule>'+
                        '</soapenv:Body>'+
                '</soapenv:Envelope>';
        attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[1].Id;
        attachment.Body = Blob.valueOf(loadAssetXML); 
        attachmentList.add(attachment);
        if(form.Form_Number__c == '5002'){
            loadAssetXML = 'Dummy String';
        }
        attachment = new Attachment();
        attachment.Name = 'request.xml';
        attachment.ParentId = formServiceList[2].Id;
        attachment.Body = Blob.valueOf(loadAssetXML); 
        attachmentList.add(attachment);
        
        if(attachmentList.size() > 0) Insert attachmentList;   
        insertServiceConfigForXMLBuilder(formServiceList);
        return formServiceList;
    }
    
     public static void insertServiceConfigForXMLBuilder(List<FromServices__c> formServiceList){
        FormServiceConfig__c formServiceConfig = new FormServiceConfig__c();
         List<FormServiceConfig__c> formServiceConfigList = new List<FormServiceConfig__c>();
        Map<String, List<String>> requestFields = new Map<String, List<String>>();
        Map<String, List<String>> requestChildFields = new Map<String, List<String>>();
        Map<String, List<String>> requestParentFields = new Map<String, List<String>>();
         List<string> strList= new List<string>();
         
         
          //Request reference attribute
           requestFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
            new List<String>{'externalid','externalsystemcode'});
          
          //Request Parent
          requestParentFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
            new List<String>{'soapenv:Envelope.soapenv:Body.thir:listThirdPartysForExternalReference','soapenv:Envelope.soapenv:Body.thir:listThirdPartysForExternalReference'});
         
          //Request Child   
           requestChildFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
            new List<String>{'externalId','externalSystemCode'});  
             requestFields.keyset();

                                           
        Map<String, List<String>> responseFields = new Map<String, List<String>>();
        Map<String, List<String>> responseParentFields = new Map<String, List<String>>();
        Map<String, List<String>> responseChildFields = new Map<String, List<String>>();
        
       //Response Reference
        responseFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
                new List<String>{'RecipientAddress1','CityStateZipCode','CityStateZipCode','CityStateZipCode','displayname','RecipientAddress2'});
        //Response Parent
        responseParentFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
                new List<String>{'S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return.ns6:billingAddress','S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return.ns6:billingAddress','S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return.ns6:billingAddress','S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return.ns6:billingAddress','S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return','S:Envelope.S:Body.ns2:listThirdPartysForExternalReferenceResponse.return.ns6:billingAddress'});                       
        //Response Child
        responseChildFields.put('ThirdPartyService.listThirdPartysForExternalReference', 
                new List<String>{'ns5:line1','ns5:line3','ns5:line5','ns5:line6','ns6:displayName','ns5:line2'});
         
        for(FromServices__c formServices :formServiceList){
            if(requestFields.containsKey(formServices.Name)&& requestParentFields.containsKey(formServices.Name) && requestChildFields.containsKey(formServices.Name)){
                for(String requestField : requestFields.get(formServices.Name)){
                    for(String requestChildField: requestChildFields.get(formServices.Name)){
                        for(String requestParentField: requestParentFields.get(formServices.Name)){
                            formServiceConfig = new FormServiceConfig__c();
                            formServiceConfig.FormService__c = formServices.Id;
                            formServiceConfig.AttributeType__c = 'Request';
                            formServiceConfig.ChildNode__c = requestChildField;
                            formServiceConfig.ParentNode__c = requestParentField;
                            formServiceConfig.ReferenceAttribute__c = requestField;
                            formServiceConfigList.add(formServiceConfig);
                            system.debug('Child ::'+requestChildField + 'Parent'+requestParentField + 'Reference' +requestField);
                          }
                      }
                }
               
                for(String responseField : responseFields.get(formServices.Name)){
                    for(String responseParentField : responseParentFields.get(formServices.Name)){
                        for(String responseChildField : responseChildFields.get(formServices.Name)){
                            formServiceConfig = new FormServiceConfig__c();
                            formServiceConfig.FormService__c = formServices.Id;
                            formServiceConfig.AttributeType__c = 'Response';
                            formServiceConfig.ChildNode__c = responseChildField ;
                            formServiceConfig.ParentNode__c = responseParentField ;
                            formServiceConfig.ReferenceAttribute__c = responseField;
                            formServiceConfigList.add(formServiceConfig);
                            system.debug('Child ::'+ResponseChildField + 'Parent'+ResponseParentField + 'Reference' +ResponseField);
                            
                        }
                    }
                }      
            }      
        }
        if(formServiceConfigList.size() > 0) insert formServiceConfigList;
    }
    public static void insertEndPoints(){
        List<Forms_EndPointConfig__c> endpointService = new List<Forms_EndPointConfig__c>();
        Forms_EndPointConfig__c endpoint = new Forms_EndPointConfig__c();
        endpoint.Name= 'loadQuote';
        endpoint.Service_Name__c ='TerminationQuoteService.loadQuote';
        endpoint.EndPointURL__c ='https://salesforce.com/';
        endpoint.ServiceURL__c ='TerminationQuoteService.loadQuote';  
        endpointService.add(endpoint);
        
        endpoint = new Forms_EndPointConfig__c();
        endpoint.Name= 'loadAsset';
        endpoint.Service_Name__c ='AssetService.loadAsset';
        endpoint.EndPointURL__c ='https://salesforce.com/';
        endpoint.ServiceURL__c ='AssetService.loadAsset';  
        endpointService.add(endpoint);
        
        endpoint = new Forms_EndPointConfig__c();
        endpoint.Name= 'DummyService';
        endpoint.Service_Name__c ='AssetService.loadAssetDummy';
        endpoint.EndPointURL__c ='https://salesforce.com/';
        endpoint.ServiceURL__c ='AssetService.loadAssetDummy';  
        endpointService.add(endpoint);
        
        endpoint = new Forms_EndPointConfig__c();
        endpoint.Name= 'loadThirdParty';
        endpoint.Service_Name__c ='ThirdPartyService.LoadThirdParty';
        endpoint.EndPointURL__c ='https://intsvcs-dev.services.toyotafinancial.com/EIP/ProxyServices/CSS/';
        endpoint.ServiceURL__c ='ThirdPartyService';  
        endpointService.add(endpoint);
        
        endpoint = new Forms_EndPointConfig__c();
        endpoint.Name= 'listActiveBillingAddressAlerts';
        endpoint.Service_Name__c ='ThirdPartyAlertService.listActiveBillingAddressAlerts';
        endpoint.EndPointURL__c ='https://intsvcs-dev.services.toyotafinancial.com/EIP/ProxyServices/CSS/';
        endpoint.ServiceURL__c ='ThirdPartyAlertService';  
        endpointService.add(endpoint);
        insert endpointService;
        system.assertEquals(endpointService.size(), 5);
    }
    public static List<Forms_QueryConfig__c> insertQueryConfigRecords(){
      
        List<Forms_QueryConfig__c> formsQueryConfigList = new List<Forms_QueryConfig__c>();
        Forms_QueryConfig__c formsQueryConfig = new Forms_QueryConfig__c();
        formsQueryConfig.Field_APIName__c = 'State_Code__c';
        formsQueryConfig.Object_ApiName__c = 'Forms_EffectiveState__c';
        formsQueryConfig.Filter_Field__c ='State_Code__c';
        formsQueryConfig.Document_Object_Field__c='CustomString4__c';
        formsQueryConfig.DataType__c='String';
        formsQueryConfig.ReferenceAttribute__c = 'effectivestatecode';
        formsQueryConfigList.add(formsQueryConfig);
        
        formsQueryConfig = new Forms_QueryConfig__c();
        formsQueryConfig.Field_APIName__c = 'Payoff_Amount_Gross__c';
        formsQueryConfig.Object_ApiName__c = 'Financial_Account__c';
        formsQueryConfig.Filter_Field__c ='Financial_Account_Number__c';
        formsQueryConfig.Document_Object_Field__c='';
        formsQueryConfig.DataType__c='String';
        formsQueryConfig.ReferenceAttribute__c = 'accountnumber';
        formsQueryConfigList.add(formsQueryConfig);
        
        formsQueryConfig = new Forms_QueryConfig__c();
        formsQueryConfig.Field_APIName__c = 'Name';
        formsQueryConfig.Object_ApiName__c = 'Financial_Account__c';
        formsQueryConfig.Filter_Field__c ='Name';
        formsQueryConfig.Document_Object_Field__c='';
        formsQueryConfig.DataType__c='String';
        formsQueryConfig.ReferenceAttribute__c = 'name';
        formsQueryConfigList.add(formsQueryConfig);
        
        insert formsQueryConfigList;
        
        
        return formsQueryConfigList;
    }
}