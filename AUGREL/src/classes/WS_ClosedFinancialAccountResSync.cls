//Generated by wsdl2apex

public class WS_ClosedFinancialAccountResSync {
    public class ProcessService_element {
        public WS_ServiceApplicationArea.ServiceApplicationAreaType ServiceApplicationArea;
        public WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType ClosedFinancialAccountResBOD;
        private String[] ServiceApplicationArea_type_info = new String[]{'ServiceApplicationArea','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync',null,'1','1','false'};
        private String[] ClosedFinancialAccountResBOD_type_info = new String[]{'ClosedFinancialAccountResBOD','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync','true','false'};
        private String[] field_order_type_info = new String[]{'ServiceApplicationArea','ClosedFinancialAccountResBOD'};
    }
    public class ClosedFinancialAccountResBODType {
        public WS_ResultBOD.ResultBODType ResultBOD;
        private String[] ResultBOD_type_info = new String[]{'ResultBOD','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync','true','false'};
        private String[] field_order_type_info = new String[]{'ResultBOD'};
    }
    public class ClosedFinancialAccountResBODType_element {
        public WS_ClosedFinancialAccountResSync.ProcessService_element ProcessService;
        private String[] ProcessService_type_info = new String[]{'ProcessService','http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/ClosedFinancialAccountResSync','true','false'};
        private String[] field_order_type_info = new String[]{'ProcessService'};
    }
}