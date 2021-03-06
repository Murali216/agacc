//Generated by wsdl2apex

public class TFSC_WS_EmailValidationImpl {
    public class ReceiveEmailValidationRequest {
        public String endpoint_x = 'https://localhost:24454/TFS/Services/EmailValidation';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceDefinition/EmailValidationService/EmailValidationImpl/TFS/Services', 'TFSC_WS_EmailValidationImpl', 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/Common/ServiceApplicationArea', 'TFSC_WS_EmailServiceApplicationArea', 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync', 'TFSC_WS_EmailValidationtReqSync', 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationResBOD', 'TFSC_WS_EmailValidationResBOD', 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationResSync', 'TFSC_WS_EmailValidationResSync', 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/Common/ResultBOD', 'TFSC_WS_EmailValidationResultBOD'};
        public TFSC_WS_EmailValidationResSync.ProcessService_element EmailValidation(TFSC_WS_EmailValidationtReqSync.ProcessService_element ProcessService) {
            TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element request_x = new TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element();
            request_x.ProcessService = ProcessService;
            TFSC_WS_EmailValidationResSync.EmailValidationResSync_element response_x;
            Map<String, TFSC_WS_EmailValidationResSync.EmailValidationResSync_element> response_map_x = new Map<String, TFSC_WS_EmailValidationResSync.EmailValidationResSync_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '/TFS/Services/EmailValidation',
              'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',
              'EmailValidationReqSync',
              'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationResSync',
              'EmailValidationResSync',
              'TFSC_WS_EmailValidationResSync.EmailValidationResSync_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.ProcessService;
        }
    }
}