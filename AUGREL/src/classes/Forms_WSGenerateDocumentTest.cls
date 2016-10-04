@isTest
private class Forms_WSGenerateDocumentTest{
    
   
static testMethod void testWSGenerateDocument() {

Form__c formObj = Forms_TestDataUtil.insertForm('4201');
Forms_TestDataUtil.insertFormFieldsForRequest();
Forms_TestDataUtil.insertFormFieldsForResponse(); 
    
    //Inserting datetime datatype field inorder to cover code.
    Form_Field__c formField = new Form_Field__c();
    formField.Data_Type__c = 'DateTime';
    formField.Name = 'CreatedDate__c';
    formField.Target_Field__c = 'CreatedDate__c';
    formField.Source_Field__c = '';
    formField.Input_Fields__c = '';
    formField.WS_Sequence__c = 5;
    formField.WS_DestinationNode__c='request.createdDate';
    formField.Line_item_field__c=false;
    formField.Line_item_type__c=null;
    insert formField;
    
    Form_Field_Junction__c formFieldJunction = new Form_Field_Junction__c();
    formFieldJunction.Form__c = formobj.Id;
    formFieldJunction.Form_Field__c = formField.Id;
    formFieldJunction.required__c =true;
    insert formFieldJunction;
    
Document_Request__c docReq = new Document_Request__c();
docReq.CustomDate__c = system.today();
docReq.FormType__c = 'Interactive';
//docReq.Dispatch_Name__c='Local Print';
//docReq.ReturnEnvelope__c=true;
//docReq.LegalEnvelop__c=false;
//docReq.NumberOfCopies__c=2;
//docReq.CertifiedMail__c=false;
docReq.Target_SystemName__c = 'FileNet';
docReq.AccountNumber__C='ACC1234re311223';
docReq.DocumentType__C = 'DCT1';
docReq.RequestID__c='REQUES12345';
docReq.Source_SystemName__c = 'ALFA';
docReq.FormID__c='4201';
docReq.Dealer_Number__c='DEALER1111';
docReq.Vehicle_Year__c = 2008;
docReq.Vehicle_Make__C ='TOYOTA';
docReq.Vehicle_Model__c='LEXUS';
docReq.VIN__c = '232DSDSDSw3';
docReq.Recipient_NameLine1__c = 'NameLINE1';
docReq.Recipient_Address1__c = 'ADDRESS1';
docReq.Recipient_Address2__c = 'ADDRESS2';
docReq.Recipient_CityStateZipCode__c='CityStateZipCode';
docReq.Recipient_FAX__c = '912-234-1245';
docReq.CustomString1__c = 'Deceased Indicator';
docReq.CustomCurrency1__c = 34100.25;
docReq.CreatedDate__c=system.now();
docReq.CustomString2__c='Product Type';
docReq.CustomString3__c='Jurisdiction';
docReq.CustomString4__c='user branch';
case caseobj = Forms_TestDataUtil.getCase();
docReq.case__c=caseobj.id;

insert docReq;

Document_Request_Line_Item__c lineItem1 = new Document_Request_Line_Item__c();
lineItem1.Type__c = 'Dispatch';
lineItem1.dispatchName__c = 'Network print';
lineItem1.Document_Request__c = docReq.Id;
lineItem1.isLegalEnvelop__c = true;
lineItem1.returnEnvelop__c = true;
lineItem1.Is_Certified_Mail__c = true;
lineItem1.noOfCopies__c =2;
/*lineItem1.Type__c='Other Charges';        
lineItem1.CoCustomer_AddyAddress1__c='FAX';
lineItem1.CoCustomer_AddyAddress2__c='YES';
lineItem1.Document_Request__c = docReq.Id;*/

Document_Request_Line_Item__c lineItem2 = new Document_Request_Line_Item__c();
    
/*lineItem2.Type__c='Other Charges';        
lineItem2.CoCustomer_AddyAddress1__c='Print Central';
lineItem2.CoCustomer_AddyAddress2__c='NO';
lineItem2.Document_Request__c = docReq.Id;*/
lineItem2.Type__c = 'Dispatch';
lineItem2.dispatchName__c = 'FAX';
lineItem2.Document_Request__c = docReq.Id;
lineItem2.isLegalEnvelop__c = true;
lineItem2.returnEnvelop__c = true;
lineItem1.Is_Certified_Mail__c = true;
lineItem1.noOfCopies__c =2;

List<Document_Request_Line_Item__c> drlList = new List<Document_Request_Line_Item__c>();
drlList.add(lineItem1);
drlList.add(lineItem2);

insert drlList;

FORMS_WS_GenerateDocument.buildFormFieldMap('4201',docReq,drlList);
List<FORMS_WS_GenerateDocument.XMLNode> nodeList = new List<FORMS_WS_GenerateDocument.XMLNode>();
FORMS_WS_GenerateDocument.XMLNode node1 = new FORMS_WS_GenerateDocument.XMLNode('ser:RefToSequenceNo','1','','');
node1.children = new List<FORMS_WS_GenerateDocument.XMLNode>();
node1.childrenNodesByName = new Map<String,FORMS_WS_GenerateDocument.XMLNode>();
nodeList.add(node1);
node1.addChildren(nodeList);
node1.removeFromParent();


}
   /* public class XMLNode {

    public String name;
    public String value;
    public String nameSpaceString;
    public String nameSpacePrefix;
        
      public XMLNode(String nodeName, String nodeValue, String nameSpaceString, String nameSpacePrefix) {
      this.name = nodeName;
      this.value = nodeValue;
      this.nameSpaceString = nameSpaceString;
      this.nameSpacePrefix = nameSpacePrefix;
    }
    }*/
static testMethod void testAddChildren() {
    
    
    //List<FORMS_WS_GenerateDocument.XMLNode> nodeList = new List<FORMS_WS_GenerateDocument.XMLNode>();
    FORMS_WS_GenerateDocument.XMLNode node1 = new FORMS_WS_GenerateDocument.XMLNode('ser:RefToSequenceNo','1','','');
    //nodeList.add(node1);
    //FORMS_WS_GenerateDocument.addChildren(nodeList);
    //FORMS_WS_GenerateDocument.removeFromParent();
}
}