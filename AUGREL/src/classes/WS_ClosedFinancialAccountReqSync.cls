//Generated by wsdl2apex

public class WS_ClosedFinancialAccountReqSync {
    public class ProcessService_element {
        public WS_ServiceApplicationArea.ServiceApplicationAreaType ServiceApplicationArea;
        public WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqBODType ClosedFinancialAccountReqBOD;
        private String[] ServiceApplicationArea_type_info = new String[]{'ServiceApplicationArea','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'1','1','false'};
        private String[] ClosedFinancialAccountReqBOD_type_info = new String[]{'ClosedFinancialAccountReqBOD','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceApplicationArea','ClosedFinancialAccountReqBOD'};
    }
    public class ClosedFinancialAccountReqBODType {
        public String ClosedFinancialAccountNumber;
        public DateTime AccountClosedDate;
        public String Branch;
        public String AccountType;
        private String[] ClosedFinancialAccountNumber_type_info = new String[]{'ClosedFinancialAccountNumber','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'1','1','false'};
        private String[] AccountClosedDate_type_info = new String[]{'AccountClosedDate','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'0','1','false'};
        private String[] Branch_type_info = new String[]{'Branch','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'0','1','false'};
        private String[] AccountType_type_info = new String[]{'AccountType','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'ClosedFinancialAccountNumber','AccountClosedDate','Branch','AccountType'};
    }
    public class ClosedFinancialAccountReqSync_element {
        public WS_ClosedFinancialAccountReqSync.ProcessService_element ProcessService;
        private String[] ProcessService_type_info = new String[]{'ProcessService','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountReqSync','true','false'};
        private String[] field_order_type_info = new String[]{'ProcessService'};
    }
}