@isTest

Global class TFSC_WS_PhoneNumValidMockGeneTest implements webServiceMock{
    
    global void doInvoke(
        Object stub,
        Object request,
        Map<String,object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {

        TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element phoneSync = new TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element();
        phoneSync.ProcessService = new TFSC_WS_PhoneNumberValidationReq.ProcessService_element();
        phoneSync.ProcessService.PhoneNumberValidationReqBOD = new TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqBODType();
        phoneSync.ProcessService.PhoneNumberValidationReqBOD.PhoneNumber = '19154008138';
        
        TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element responseDoc = new TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element();
        TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element responseDoc1 = new TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element();
        
        if(phoneSync.ProcessService.PhoneNumberValidationReqBOD.PhoneNumber != Null){
            TFSC_WS_PhoneNumberValidationResult.ResultBODType  resultInput= new TFSC_WS_PhoneNumberValidationResult.ResultBODType();    
            resultInput.ResultCode = 0;
            resultInput.ResultDesc='test';
            resultInput.ResultString='test';
            
            TFSC_WS_PhoneNumberValidationResult.ResultBODType  resultInput1= new TFSC_WS_PhoneNumberValidationResult.ResultBODType();    
            resultInput1.ResultCode = 10;
            resultInput1.ResultDesc='test';
            resultInput1.ResultString='test';
            
        
            list<TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element> globalPhonelist= new list<TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element>();
            TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element globalphone = new TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element();

            TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element globalphone2 = new TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element();

            globalPhone.Listing = new TFSC_WS_PhoneNumberValidationResp.Listing_element();
            globalPhone.ItemStatus = new TFSC_WS_PhoneNumberValidationResp.ItemStatus_element();
            globalPhone.ItemStatus.StatusNbr = 201;
            globalPhone.ItemStatus.StatusDescription ='test';
            globalPhone.Listing.Number_x=100;
            globalPhone.Listing.CountryCode=1;
            globalPhone.Listing.InternationalPrefix=1;
            globalPhone.Listing.NationalPrefix=100;
            globalPhone.Listing.CellPrefix='test';
            globalPhone.Listing.NDC=100;
            globalPhone.Listing.SN_From=100;
            globalPhone.Listing.SN_To=100;
            globalPhone.Listing.Uses_NDC=false;
            globalPhone.Listing.Number_Type='test';
            globalPhone.Listing.CarrierName='test';
            globalPhone.Listing.Language='test';
            globalPhone.Listing.Country=100;
            globalPhone.Listing.ISO='test';
            globalPhone.Listing.RegionCode='test';
            globalPhone.Listing.RegionName='test';
            globalPhone.Listing.City='test';
            globalPhone.Listing.TimeZone='test';
            globalPhone.Listing.UTC='test';
            globalPhone.Listing.DST=false;
            globalPhone.Listing.Latitude=0.1;
            globalPhone.Listing.Longitude=1.1;
            globalPhone.Listing.ErrorCode='test';
            globalPhonelist.add(globalPhone);


            globalPhone2.Listing = new TFSC_WS_PhoneNumberValidationResp.Listing_element();
            globalPhone2.ItemStatus = new TFSC_WS_PhoneNumberValidationResp.ItemStatus_element();
            globalPhone2.ItemStatus.StatusNbr = 201;
            globalPhone2.ItemStatus.StatusDescription ='test';
            globalPhone2.Listing.Number_x=100;
            globalPhone2.Listing.CountryCode=1;
            globalPhone2.Listing.InternationalPrefix=1;
            globalPhone2.Listing.NationalPrefix=100;
            globalPhone2.Listing.CellPrefix='test';
            globalPhone2.Listing.NDC=100;
            globalPhone2.Listing.SN_From=100;
            globalPhone2.Listing.SN_To=100;
            globalPhone2.Listing.Uses_NDC=false;
            globalPhone2.Listing.Number_Type='test';
            globalPhone2.Listing.CarrierName='test';
            globalPhone2.Listing.Language='test';
            globalPhone2.Listing.Country=100;
            globalPhone2.Listing.ISO='test';
            globalPhone2.Listing.RegionCode='test';
            globalPhone2.Listing.RegionName='test';
            globalPhone2.Listing.City='test';
            globalPhone2.Listing.TimeZone='test';
            globalPhone2.Listing.UTC='test';
            globalPhone2.Listing.DST=false;
            globalPhone2.Listing.Latitude=0.1;
            globalPhone2.Listing.Longitude=1.1;
            globalPhone2.Listing.ErrorCode='test';          
            globalPhonelist.add(globalPhone2);
            
            
            responseDoc.ProcessService = new TFSC_WS_PhoneNumberValidationResp.ProcessService_element();
            responseDoc.ProcessService.ResultBOD=resultInput;
            responseDoc.ProcessService.PhoneNumberValidationResBOD = new TFSC_WS_PhoneNumberValidationResp.ValidateNumberResponseType();

            responseDoc1.ProcessService = new TFSC_WS_PhoneNumberValidationResp.ProcessService_element();
            responseDoc1.ProcessService.ResultBOD=resultInput1;
            //responseDoc1.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult = new TFSC_WS_PhoneNumberValidationResp.ValidateNumberResult_element();             
            
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult = new TFSC_WS_PhoneNumberValidationResp.ValidateNumberResult_element(); 
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceStatus= new TFSC_WS_PhoneNumberValidationResp.ServiceStatus_element();
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceStatus.StatusNbr = 211;
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceStatus.StatusDescription ='test';

            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult = new TFSC_WS_PhoneNumberValidationResp.ServiceResult_element();
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results =new TFSC_WS_PhoneNumberValidationResp.Results_element();     
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results.GlobalPhoneEntryWithStatus = globalPhoneList;
            responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results.GlobalPhoneEntryWithStatus[0].Listing = globalPhone.Listing; 
    
            
            }
            response.put('response_x', responseDoc); 
            //response.put('response_x', responseDoc1);
    }           
            
        
}