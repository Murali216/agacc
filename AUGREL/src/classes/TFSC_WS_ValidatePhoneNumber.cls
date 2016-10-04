public class TFSC_WS_ValidatePhoneNumber {
    
        
        /*Description: This Class is constructing the Request structure for Request wrapper from wsdl generated class,
    which will be sent in the callout.*/    
    public class PhoneNumberValidation_RequestParams{
        public String phoneNumber;
    }
         
        
    /*Description: This class is constructing the Response structre for Response wrapper from wsdl generated class, 
    when request is sent, these are the values which we get back as response.*/ 
    public class PhoneNumberValidation_ResponseRecord{
        public Long Number_x{get;set;}
        public Integer CountryCode{get;set;}
        public Integer InternationalPrefix{get;set;}
        public Integer NationalPrefix{get;set;}
        public String CellPrefix{get;set;}
        public Integer NDC{get;set;}
        public Integer SN_From{get;set;}
        public Integer SN_To{get;set;}
        public Boolean Uses_NDC{get;set;}
        public String Number_Type{get;set;}
        public String CarrierName{get;set;}
        public String Language{get;set;}
        public Integer Country{get;set;}
        public String ISO{get;set;}
        public String RegionCode{get;set;}
        public String RegionName{get;set;}
        public String City{get;set;}
        public String TimeZone{get;set;}
        public String UTC{get;set;}
        public Boolean DST{get;set;}
        public Decimal Latitude{get;set;}
        public Decimal Longitude{get;set;}
        public String ErrorCode{get;set;}
        public Integer StatusNbr{get;set;}
        public String StatusDescription {get;set;}
        
    }
    
        public class PhoneNumberValidation_StatusParams{
        public String Status{get;set;} // SUCCESS or FAIL
        public String Error{get;set;} // Populated only if Status = FAIL 
        public Integer StatusNbrService {get;set;}
        public String StatusDescriptionService {get;set;}
        public Integer ResultCode {get;set;}
    }
    
            /*Description: This class with constructer holds the status and the response values in a list. */   
    public class PhoneNumberValidation_ResponseParams{
    	
    	        public List <PhoneNumberValidation_ResponseRecord> ResponseRecordList {get;set;}
        public PhoneNumberValidation_StatusParams StatusParams {get;set;}
    	
        public  PhoneNumberValidation_ResponseParams(){
            this.statusParams = new PhoneNumberValidation_StatusParams();
    }

    }
    
    
        /*Description: This method invocates WebService passing the PhoneNumber by passing it in the request,
    creating stub,Auth and endpoint which are fetched from IMPL wsdl generated class,
    getting response and parsing the response from other method. */    
    public static PhoneNumberValidation_ResponseParams validatePhoneNumber(PhoneNumberValidation_RequestParams requestParams){
        //Constructing Request using WSDL generated class
        TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element requestDoc = constructRequest(requestParams);
        system.debug('*Request of the constructed value*:');
        
        //Creating stub 
        TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest stub = getstub();
        stub = setEndPointURL(stub);
        stub = setAuthDetails(stub);  
        System.debug('*The Prepared Stub *:');
        
        //Initializing Response
        PhoneNumberValidation_ResponseParams ResponseParams;
        TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element responseDoc = new TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element();
        system.debug('*The value of Response Doc*:');
        
        try{
        
            //Invoke service
            System.debug('*Web Service Request *:' + RequestParams);
            responseDoc.ProcessService = stub.PhoneValidation(requestDoc.ProcessService);
            System.debug('*Web Service Invoked Successfully *');
            System.debug('*Web Service Response *:' + responseDoc);

            //Parse Response
            responseParams = parseResponse(responseDoc);
            System.debug('***** Parsed Response Successfully *****');
        }
        catch(exception e){
            ResponseParams= new PhoneNumberValidation_ResponseParams();
            ResponseParams.StatusParams.Status='FAIL';
            System.debug('***** Exception Occured - ' + e + ' *****');
            responseParams.StatusParams.Error = e.getTypeName() + ': ' + e.getMessage();
            system.debug('*Exception type caught*:'+e.getTypeName());
            system.debug('*Exception message*:'+e.getMessage());
        }

        return responseParams;
    }
    
    
        /*Description: This method constructs the request values from the wsdl generated class. */
    private static TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element constructRequest(PhoneNumberValidation_RequestParams requestParams){
        TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element requestDoc = new TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqSync_element();
        
        requestDoc.ProcessService = new TFSC_WS_PhoneNumberValidationReq.ProcessService_element();        
        requestDoc.ProcessService.PhoneNumberValidationReqBOD = new TFSC_WS_PhoneNumberValidationReq.PhoneNumberValidationReqBODType();
        requestDoc.ProcessService.PhoneNumberValidationReqBOD.PhoneNumber = requestParams.phoneNumber;
        
        requestDoc.ProcessService.ServiceApplicationArea = new TFSC_WS_PhoneNumberValidationCommon.ServiceApplicationAreaType();
        requestDoc.ProcessService.ServiceApplicationArea.ConversationID = TFSC_Utils.getGUID();
        requestDoc.ProcessService.ServiceApplicationArea.MessageType = 'REQ';
        requestDoc.ProcessService.ServiceApplicationArea.Mode = null;
        requestDoc.ProcessService.ServiceApplicationArea.RefToSequenceNo = null;
        requestDoc.ProcessService.ServiceApplicationArea.SenderID = null;
        requestDoc.ProcessService.ServiceApplicationArea.SentTimeStamp = Datetime.valueOf(datetime.now());
        requestDoc.ProcessService.ServiceApplicationArea.SequenceNo = null;
        requestDoc.ProcessService.ServiceApplicationArea.ServiceType = null;
        requestDoc.ProcessService.ServiceApplicationArea.TargetID = null;
        requestDoc.ProcessService.ServiceApplicationArea.VersionNo = null;   
        
        return requestDoc;
    
    }
    
        //Constructing Stub, called from validatePhoneNumber method in this same class.
    private static TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest getstub(){
        TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest stub = new TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest();
        
        return stub;
    }   
    
        //Constructing End point url, called from validatePhoneNumber method in this same class.
    private static TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest setEndPointURL(TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest stub){
        
        //stub.endpoint_x = https://intsvcs-test1.services.toyotafinancial.com/phonenumbervalidation
        stub.endpoint_x = Label.Phone_Number_Validation_End_Point;
        //stub.endpoint_x = 'https://intsvcs-stg.services.toyotafinancial.com/TFS/Services/PhoneValidation';
        
        return stub;
    }
    
    
        //Setting the value of authentication and called from validatePhoneNumber method in this same class.
    private static TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest setAuthDetails(
    TFSC_WS_PhoneNumberValidationImpl.ReceivePhoneValidationRequest stub) {        
        String username;
        String password;
        String authCred;
        Map<String,String> inputHttpHeaders_x = new Map<String,String>();
        stub.inputHttpHeaders_x = inputHttpHeaders_x;
        username = System.UserInfo.getOrganizationId();
        password = username;      
        System.debug(username + ':' + password);
        Blob authCredBlob = Blob.valueOf(username + ':' + password);
        authCred = EncodingUtil.base64Encode(authCredBlob);
        stub.inputHttpHeaders_x.put('Authorization', 'Basic '+authCred);
        return stub;    
    }
    
    
    
        /* Description: This method is responsible for parsing the response what we get after the callout,
    and we map the response values to the declared response parameters of this class, to use the repsonse further.*/
    @TestVisible private static PhoneNumberValidation_ResponseParams parseResponse(TFSC_WS_PhoneNumberValidationResp.PhoneNumberValidationResSync_element responseDoc){
        
        //initializing response params and taking them in a List.
        PhoneNumberValidation_ResponseParams responseParams = new PhoneNumberValidation_ResponseParams();
        list<PhoneNumberValidation_ResponseRecord> responseRecordList = new list<PhoneNumberValidation_ResponseRecord>();
        responseParams.StatusParams =  new PhoneNumberValidation_StatusParams();
        responseParams.StatusParams.Status = 'SUCCESS';
        responseParams.StatusParams.StatusNbrService=211;
        
        List<TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element> globalList;
        List <TFSC_WS_PhoneNumberValidationResp.Listing_element> transcationList;
        List<TFSC_WS_PhoneNumberValidationResp.ItemStatus_element> itemList;
        TFSC_WS_PhoneNumberValidationResp.ServiceStatus_element serviceList;
        
        System.debug('*Check Result Code*: ' + responseDoc.ProcessService.ResultBOD.ResultCode);
        
        if(responseDoc.ProcessService.ResultBOD.ResultCode == 0){
        
            if(responseDoc.ProcessService.PhoneNumberValidationResBOD != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results.GlobalPhoneEntryWithStatus.size()>0  && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results.GlobalPhoneEntryWithStatus[0].Listing != NULL){ 
                globalList=responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceResult.Results.GlobalPhoneEntryWithStatus;                
                system.debug('*Number of Transcation in globalList*:' + globalList.size());
            }
            else{
                system.debug('No Transactions*');
                responseParams.StatusParams.Status = 'FAIL';
                responseParams.StatusParams.Error = responseDoc.ProcessService.ResultBOD.ResultCode + ': ' + responseDoc.ProcessService.ResultBOD.ResultDesc + ' - '+ responseDoc.ProcessService.ResultBOD.ResultString;
            }
            if(responseDoc.ProcessService.PhoneNumberValidationResBOD != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult != NULL && responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceStatus != NULL){
                serviceList= responseDoc.ProcessService.PhoneNumberValidationResBOD.ValidateNumberResult.ServiceStatus;
                system.debug('*Number of Transcation in serviceList*:' + serviceList);
            }
            
            if(globalList != NULL && serviceList != NULL){
                for(integer i=0; i<globalList.size(); i++) {
                    //Retrieve individual records to assign it to the response records
                    TFSC_WS_PhoneNumberValidationResp.GlobalPhoneEntryWithStatus_element singleTrans = globalList.get(i);
                    system.debug('*Parsing resord number*:'+ i);
                    PhoneNumberValidation_ResponseRecord responseRecord = new PhoneNumberValidation_ResponseRecord();
                    
                    //Map individual response values to Transcation values
                    responseRecord.Number_x = singleTrans.Listing.Number_x;
                    responseRecord.CountryCode = singleTrans.Listing.CountryCode;
                    responseRecord.InternationalPrefix = singleTrans.Listing.InternationalPrefix;
                    responseRecord.NationalPrefix = singleTrans.Listing.NationalPrefix;
                    responseRecord.CellPrefix = singleTrans.Listing.CellPrefix;
                    responseRecord.NDC = singleTrans.Listing.NDC;
                    responseRecord.SN_From = singleTrans.Listing.SN_From;
                    responseRecord.SN_To = singleTrans.Listing.SN_To;
                    responseRecord.Uses_NDC = singleTrans.Listing.Uses_NDC;
                    responseRecord.Number_Type = singleTrans.Listing.Number_Type;
                    responseRecord.CarrierName = singleTrans.Listing.CarrierName;
                    responseRecord.Language = singleTrans.Listing.Language;
                    responseRecord.Country = singleTrans.Listing.Country;
                    responseRecord.ISO = singleTrans.Listing.ISO;
                    responseRecord.RegionCode = singleTrans.Listing.RegionCode;
                    responseRecord.RegionName = singleTrans.Listing.RegionName;
                    responseRecord.City = singleTrans.Listing.City;
                    responseRecord.TimeZone = singleTrans.Listing.TimeZone;
                    responseRecord.UTC = singleTrans.Listing.UTC;
                    responseRecord.DST = singleTrans.Listing.DST;
                    responseRecord.Latitude = singleTrans.Listing.Latitude;
                    responseRecord.Longitude = singleTrans.Listing.Longitude;
                    responseRecord.ErrorCode = singleTrans.Listing.ErrorCode;
                    responseRecord.StatusNbr = singleTrans.ItemStatus.StatusNbr;
                    responseRecord.StatusDescription = singleTrans.ItemStatus.StatusDescription;
                    responseParams.StatusParams.StatusNbrService = serviceList.StatusNbr;
                    responseParams.StatusParams.StatusDescriptionService = serviceList.StatusDescription;
                    responseParams.StatusParams.resultcode = responseDoc.ProcessService.ResultBOD.ResultCode;
                        
                    system.debug('* Response Record value of Number_x *:' + responseRecord.Number_x);
                    system.debug('* Response Record value of CountryCode *:' + responseRecord.CountryCode);
                    system.debug('* Response Record value of InternationalPrefix *:' + responseRecord.InternationalPrefix);
                    system.debug('* Response Record value of NationalPrefix *:' + responseRecord.NationalPrefix);
                    system.debug('* Response Record value of CellPrefix *:' + responseRecord.CellPrefix);
                    system.debug('* Response Record value of NDC *:' + responseRecord.NDC);
                    system.debug('* Response Record value of SN_From *:' + responseRecord.SN_From);
                    system.debug('* Response Record value of SN_To *:' + responseRecord.SN_To);
                    system.debug('* Response Record value of Uses_NDC *:' + responseRecord.Uses_NDC);
                    system.debug('* Response Record value of Number_Type *:' + responseRecord.Number_Type);
                    system.debug('* Response Record value of CarrierName *:' + responseRecord.CarrierName);
                    system.debug('* Response Record value of Language *:' + responseRecord.Language);
                    system.debug('* Response Record value of Country *:' + responseRecord.Country);
                    system.debug('* Response Record value of ISO *:' + responseRecord.ISO);
                    system.debug('* Response Record value of RegionCode *:' + responseRecord.RegionCode);
                    system.debug('* Response Record value of RegionName *:' + responseRecord.RegionName);
                    system.debug('* Response Record value of City *:' + responseRecord.City);
                    system.debug('* Response Record value of TimeZone *:' + responseRecord.TimeZone);
                    system.debug('* Response Record value of UTC *:' + responseRecord.UTC);
                    system.debug('* Response Record value of DST *:' + responseRecord.DST);
                    system.debug('* Response Record value of Latitude *:' + responseRecord.Latitude);
                    system.debug('* Response Record value of Longitude *:' + responseRecord.Longitude);
                    system.debug('* Response Record value of ErrorCode *:' + responseRecord.ErrorCode);
                    system.debug('* Response Record value of StatusNbr  *:' + responseRecord.StatusNbr);
                    system.debug('* Response Record value of StatusDescription *:' + responseRecord.StatusDescription);
                    system.debug('* Response Record value of StatusNbrService  *:' + responseParams.StatusParams.StatusNbrService );
                    system.debug('* Response Record value of StatusDescriptionService *:' + responseParams.StatusParams.StatusDescriptionService);
                    system.debug('* Response Record value of resultcode *:'+ responseParams.StatusParams.resultcode);
                    
                //Add all the response values to the response list
                responseRecordList.add(responseRecord);
    
            }
        }
        
    }
    else {
        responseParams.StatusParams.Status = 'FAIL';
        responseParams.StatusParams.Error = responseDoc.ProcessService.ResultBOD.ResultCode + ': ' + responseDoc.ProcessService.ResultBOD.ResultDesc + ' - '+ responseDoc.ProcessService.ResultBOD.ResultString;
        }
        
    responseParams.ResponseRecordList = responseRecordList; 
    return responseParams;
    }
    
    
        /*Description: This class holds the values in a list together as its set in constructor.
    which will be both the Request and Response values. */
    public class ValidatePhone{
        public string phoneNumber;
        public Boolean isValid;
            public validatePhone(string phone, boolean valid){
                this.phoneNumber=phone;
                this.isValid=valid;
            }
    }
    
    /*Description: This method invokes the callout class, sends the request and gets the response
    along with the boolean to check if the number is validated or failed.*/
    Public static List<ValidatePhone> isValid(List<ValidatePhone> phonenumbers){
       
        Boolean validatedStatus= false;        
        PhoneNumberValidation_RequestParams reqParamInput = new PhoneNumberValidation_RequestParams();
        PhoneNumberValidation_ResponseParams finalResponse;
        List<ValidatePhone> phonesList = new List<ValidatePhone>();
        for(ValidatePhone SingleNumber : phonenumbers){
            reqParamInput.phoneNumber = SingleNumber.phoneNumber;
            finalResponse = validatePhoneNumber(reqParamInput);
            TFSC_WS_PhoneNumberValidationResult.ResultBODType resultResp = new TFSC_WS_PhoneNumberValidationResult.ResultBODType(); 
            system.debug('the input of callout'+reqParamInput); 
            system.debug('*The response values in test final response*:' + finalResponse);
            system.debug('*The response list*:' + finalResponse.ResponseRecordList); 
            system.debug('resultcode^'+ resultResp.ResultCode);     
                
                if(finalResponse != NULL && finalResponse.ResponseRecordList != NULL){
                    if(finalResponse.Statusparams.ResultCode ==0){
                        for(PhoneNumberValidation_ResponseRecord response : finalResponse.ResponseRecordList){
                        system.debug('response' +response);         
                            if(response.StatusNbr == 201 || finalResponse.Statusparams.StatusNbrService==211){
                                system.debug('display the service status:' +finalResponse.Statusparams.StatusNbrService);
                                system.debug('display the item status:' + response.StatusNbr);
                                validatedStatus = true;
                            }
                        ValidatePhone phoneDetails = new ValidatePhone(string.valueof(response.Number_x), validatedStatus);
                        phonesList.add(phoneDetails);   
                        }  
                    }
                }
                else{
                    ValidatedStatus = false;
                    ValidatePhone phoneDetails = new ValidatePhone(SingleNumber.phoneNumber, validatedStatus);
                    phonesList.add(phoneDetails);
                }
        }
        system.debug('validatedStatus end result:'+validatedStatus);
        system.debug('validatedStatus end result:list'+phonesList);
        return phonesList; 
    }
    
    
}