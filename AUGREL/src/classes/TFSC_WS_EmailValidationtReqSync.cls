//Generated by wsdl2apex

public class TFSC_WS_EmailValidationtReqSync {
    public class EmailValidationReqSync_element {
        public TFSC_WS_EmailValidationtReqSync.ProcessService_element ProcessService;
        private String[] ProcessService_type_info = new String[]{'ProcessService','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'ProcessService'};
    }
    public class ProcessService_element {
        public TFSC_WS_EmailServiceApplicationArea.ServiceApplicationAreaType ServiceApplicationArea;
        public TFSC_WS_EmailValidationtReqSync.EmailValidationReqBODType EmailValidationReqBOD;
        private String[] ServiceApplicationArea_type_info = new String[]{'ServiceApplicationArea','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] EmailValidationReqBOD_type_info = new String[]{'EmailValidationReqBOD','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceApplicationArea','EmailValidationReqBOD'};
    }
    public class EmailValidationReqBODType {
        public TFSC_WS_EmailValidationtReqSync.VerifyEmailType VerifyEmail;
        private String[] VerifyEmail_type_info = new String[]{'VerifyEmail','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'VerifyEmail'};
    }
    public class VerifyEmailType {
        public String EmailAddress;
        public Integer Timeout;
        public String OptionalSourceID;
        private String[] EmailAddress_type_info = new String[]{'EmailAddress','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] Timeout_type_info = new String[]{'Timeout','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'1','1','false'};
        private String[] OptionalSourceID_type_info = new String[]{'OptionalSourceID','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'EmailAddress','Timeout','OptionalSourceID'};
    }
}