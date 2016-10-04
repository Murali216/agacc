/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_RecipientAddressMapping
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 03/31/2016
Last Modified by......: Charitha Seelam
Last Modified Date....:  
Description...........: This class has been written to map recipient data to documentRequest object.
Last Modified by......: 
Last Modified Date....:  
Description...........: 

Change Request History:

##########################################################################################
*/

public class Forms_RecipientAddressMapping{

     public interface IRecipientAddress{
         RecipientAddress getRecipientAddress(Map<String,String> inputMap);
     }
    
    public class GetRecipientAddress{
        
        RecipientAddress getALFARecipientAddress(Map<String,String> inputMap){
            
          RecipientAddress address = new RecipientAddress();
          String loadThirdPartyEndpoint;
          String listActiveEndPoint;
          String inputXMLString;
          // Get Recipient address from ALFA 'https://intsvcs-dev.services.toyotafinancial.com/EIP/ProxyServices/CSS/
          if(Forms_EndPointConfig__c.getValues('loadThirdParty') != null) {
          loadThirdPartyEndpoint = Forms_EndPointConfig__c.getValues('loadThirdParty').EndPointURL__c+'ThirdPartyService';
          
          inputXMLString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:thir="http://ws.chpconsulting.com/alfa/thirdparty/v1/thirdparty" xmlns:v11="http://ws.chpconsulting.com/alfa/thirdparty/v1">'+
                                        +'<soapenv:Header>'+
                                        +'<v1:context>'+
                                        +'<v1:systemId>SFDA</v1:systemId>'+
                                        +'</v1:context>'+
                                        +'</soapenv:Header>'+
                                        +'<soapenv:Body>'+
                                        +'<thir:loadThirdParty>'+
                                        +'<thirdPartyIdentifier>'+
                                        +'<v11:billingAddressNumber>'+inputMap.get(Forms_Constant.BILLINGADDRESSNUMBER)+'</v11:billingAddressNumber>'+
                                        +'<v11:thirdPartyNumber>'+inputMap.get(Forms_Constant.THIRDPARTYNUMBER)+'</v11:thirdPartyNumber>'+
                                        +'</thirdPartyIdentifier>'+
                                        +'</thir:loadThirdParty>'+
                                        +'</soapenv:Body>'+
                                    +'</soapenv:Envelope>';
                                  
            HttpResponse loadThirdPartyResponse = new HttpResponse();
            loadThirdPartyResponse = new Forms_CalloutHandler().makeCallout(loadThirdPartyEndpoint, 'POST', inputXMLString, Forms_Constant.LIVE);
            //Response processing
            if(loadThirdPartyresponse != null && loadThirdPartyresponse.getStatusCode() == 200){
                String responseXML = loadThirdPartyresponse.getBody();
                system.debug('Forms_RecipientAddressMapping::getALFARecipientAddress::Live Response::LoadThirdParty For Recipient '+responseXML);
                Dom.Document doc = new Dom.Document();
                doc.load(responseXML);
                Dom.XMLNode root = doc.getRootElement();
                Dom.XMLNode parentNode;                
                String parentConfig = 'soapenv:Envelope.soapenv:Body.v1:loadThirdPartyResponse.return';
                String[] parentNodeArray = parentConfig.split('\\.');
                parentNode = getParentNode(parentNodeArray,root);                
                            
                    if(parentNode != null){                           
                        address.cityStateZipCode = '';
                        for(Dom.XMLNode childNode : parentNode.getChildren()){
                            String childNodeString = childNode.getName();
                            if(childNodeString.equalsIgnoreCase('displayName') && childNode.getText()!=null )
                                address.nameline1 = childNode.getText();
                            /* else if(childNodeString.equalsIgnoreCase('faxNumber') && childNode.getText()!=null )
                                address.recipientFax = childNode.getText(); */
                            
                            else if(childNodeString.equalsIgnoreCase('billingAddress')){
                                for(Dom.XMLNode grandChild : childNode.getChildren()){
                                    STring grandChildString = grandChild.getName();
                                    if(grandChildString.equalsIgnoreCase('line1') && grandChild.getText()!=null)
                                        address.recipientAddress1 = grandChild.getText();    
                                    else if(grandChildString.equalsIgnoreCase('line2') && grandChild.getText()!=null)
                                        address.recipientAddress2 = grandChild.getText();
                                    else if(grandChildString.equalsIgnoreCase('line3') && grandChild.getText()!=null)
                                        address.cityStateZipCode = grandChild.getText()+', ';
                                    else if(grandChildString.equalsIgnoreCase('line4') && grandChild.getText()!=null)
                                        address.cityStateZipCode = address.cityStateZipCode+grandChild.getText()+' ';
                                    else if(grandChildString.equalsIgnoreCase('line5') && grandChild.getText()!=null)
                                        address.cityStateZipCode = address.cityStateZipCode+grandChild.getText();
                                }
                            }
                        }
                     }
                     
            }
            
            }
            //ListACtiveAlerts callout for Deceased.
            if(Forms_EndPointConfig__c.getValues('listActiveBillingAddressAlerts') != null){
            listActiveEndPoint = Forms_EndPointConfig__c.getValues('listActiveBillingAddressAlerts').EndPointURL__c+'ThirdPartyAlertService';
            inputXMLString = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:aler="http://ws.chpconsulting.com/alfa/thirdparty/v1/alert" xmlns:v11="http://ws.chpconsulting.com/alfa/thirdparty/v1">'+
                              +'<soapenv:Header>'+
                              +'<v1:context>'+        
                              +'<v1:systemId>SFDA</v1:systemId>'+         
                              +'</v1:context>'+
                              +'</soapenv:Header>'+
                              +'<soapenv:Body>'+
                              +'<aler:listActiveBillingAddressAlerts>'+
                              +'<thirdPartyIdentifier>'+
                              +'<v11:billingAddressNumber>'+inputMap.get(Forms_Constant.BILLINGADDRESSNUMBER)+'</v11:billingAddressNumber>'+
                              +'<v11:thirdPartyNumber>'+inputMap.get(Forms_Constant.THIRDPARTYNUMBER)+'</v11:thirdPartyNumber>'+
                              +'</thirdPartyIdentifier>'+
                              +'</aler:listActiveBillingAddressAlerts>'+
                              +'</soapenv:Body>'+
                              +'</soapenv:Envelope>';
            HttpResponse listACtiveResponse = new HttpResponse();
            listACtiveResponse = new Forms_CalloutHandler().makeCallout(listActiveEndPoint, 'POST', inputXMLString, Forms_Constant.LIVE);
            if(listActiveResponse != null && listActiveResponse.getStatusCode() == 200){
                String responseXML = listActiveResponse.getBody();
                system.debug('Forms_RecipientAddressMapping::getALFARecipientAddress::Live Response::ListActive For Recipient '+responseXML);
                Dom.Document doc = new Dom.Document();
                doc.load(responseXML);
                Dom.XMLNode root = doc.getRootElement();
                Dom.XMLNode parentNode;                
                String parentConfig = 'soapenv:Envelope.soapenv:Body.aler:listActiveBillingAddressAlertsResponse.return';
                String[] parentNodeArray = parentConfig.split('\\.');
                parentNode = getParentNode(parentNodeArray,root);                
                            
                    if(parentNode != null){ 
                        for(Dom.XMLNode childNode : parentNode.getChildren()){
                            String childNodeString = childNode.getName();
                            if(childNodeString.equalsIgnoreCase('type') && childNode.getText()!=null && childNode.getText().equalsIgnoreCase('DEA')){
                                address.deceased = childNode.getText();
                            }
                        }
                    }
            }              
            
            }
          return address;
        }
        
        Dom.XMLNode getParentNode(String[] parentNodeArray,Dom.XMLNode root){
        String nameSpace = '';
        String nameSpacePrefix = '';
        Dom.XMLNode parentNode;
            for(String parentNodeString :parentNodeArray){
                    if(parentNode == null){
                        if(root.getName() != null){
                            nameSpace = root.getNameSpace();
                            nameSpacePrefix = (String.isNotBlank(nameSpace)? root.getPrefixFor(nameSpace) : null);                      
                            String rootName = (String.isNotBlank(nameSpacePrefix)? nameSpacePrefix+':'+root.getName() : root.getName());
                            if(rootName.equalsIgnoreCase(parentNodeString)){
                                parentNode = root;
                            }
                        }
                    } else {
                        String[] splitTag = parentNodeString.split('\\:');
                        parentNodeString = (splitTag.size() == 2 ? splitTag[1] : splitTag[0]);
                        if(parentNode != null && parentNode.getChildren().size() > 0){
                            for(Dom.XMLNode xmlNode : parentNode.getChildren()){
                                if(String.isNotBlank(parentNodeString) && xmlNode != null && String.isNotBlank(xmlNode.getName()) 
                                   && xmlNode.getName().equalsIgnoreCase(parentNodeString)){
                                       parentNode = xmlNode;
                                }
                             }
                         }
                     }
                    }
            return parentNode;
    
    }
    
        RecipientAddress getSFDCRecipientAddress(Map<String,String> inputMap){
            RecipientAddress address;
            List<Financial_Account_Customer__c> recipientInfo = Forms_DataSelector.getSFDCRecipientInfo(inputMap);
            system.debug('Forms_RecipientAddressMapping::getSFDCRecipientAddress::RecipientInfo'+recipientInfo);
            if(recipientInfo != null && recipientInfo.size()>0){
                 address = new RecipientAddress();
                 address.nameLine1 = recipientInfo.get(0).Account__r.name;                                                            
                 address.recipientAddress1 = recipientInfo.get(0).Mailing_Street_BillTo__c;
                 address.recipientAddress2 = recipientInfo.get(0).Address_Special_BillTo__c;
                 address.cityStateZipCode = recipientInfo.get(0).Mailing_City_BillTo__c+', '+recipientInfo.get(0).Mailing_State_BillTo__c+' '+recipientInfo.get(0).Mailing_PostalCode_BillTo__c;
                // address.recipientFax = '';
                 String deceasedFlag = recipientInfo.get(0).Account__r.Flag_Deceased__pc;
                 if(deceasedFlag != null && deceasedFlag != '' && !deceasedFlag.equalsIgnoreCase('N'))
                 address.deceased = 'DEA';                
            }
            return address;
        }
    }
    
   
    public class ALFARecipientAddress implements IRecipientAddress{
        private GetRecipientAddress recAddress;
        public ALFARecipientAddress(GetRecipientAddress recAddress){
            this.recAddress = recAddress;
        }
        public RecipientAddress getRecipientAddress(Map<String,String> inputData){
            return recAddress.getALFARecipientAddress(inputData);
        }
    }
    
    public class SFDCRecipientAddress implements IRecipientAddress{
        private GetRecipientAddress recAddress;
        public SFDCRecipientAddress(GetRecipientAddress recAddress){
            this.recAddress = recAddress;
        }
        public RecipientAddress getRecipientAddress(Map<String,String> inputData){
            return recAddress.getSFDCRecipientAddress(inputData);
        }
    }
    
    /* Method Name: mappingRecipientToDocReq
    Method Signature/Inputs: 
    Method Return Type/outputs: 
    Method Description: 
     */
     
     
    public void mappingRecipientToDocReq(Map<String,String> inputMap,Forms_DocumentDataHolder documentData){
        
       RecipientAddress address;
        
       GetRecipientAddress getRecAddress = new GetRecipientAddress();
       IRecipientAddress  SFDCRecAddress = new SFDCRecipientAddress(getRecAddress);
       IRecipientAddress  ALFARecAddress = new ALFARecipientAddress(getRecAddress);
       String errorMessage = Forms_Fetch_CustomSetting.fetchErrorMessage('Invalid Input')+'\r\n'+Forms_Fetch_CustomSetting.fetchErrorMessage('Missing Fields');  
      if(inputMap.get(Forms_Constant.SOURCESYSTEM)!=null && inputMap.get(Forms_Constant.SOURCESYSTEM).equalsIgnoreCase(Forms_Constant.SFDC)){
            String recipientId = inputMap.get(Forms_Constant.RECIPIENTID);
            if(recipientId!=null){
                String[] splitRecipient = recipientId.split('/');
                if(splitRecipient.size()>1){
                    inputMap.put(Forms_Constant.ACCOUNTNUMBER,splitRecipient[0]);
                    inputMap.put(Forms_Constant.RECIPIENTID,splitRecipient[1]); 
                    address = SFDCRecAddress.getRecipientAddress(inputMap);
                }else if(splitRecipient.size()==1){
                    inputMap.put(Forms_Constant.RECIPIENTID,splitRecipient[0]); 
                }
            }else{
                 errorMessage = errorMessage+' UCID,Account Number';
                 throw new Forms_ValidationException(errorMessage);             
            }
                        
       }
       else if(inputMap.get(Forms_Constant.SOURCESYSTEM)!=null && inputMap.get(Forms_Constant.SOURCESYSTEM).equalsIgnoreCase(Forms_Constant.ALFA)){
                 if(inputMap.get(Forms_Constant.THIRDPARTYNUMBER)!=null && inputMap.get(Forms_Constant.BILLINGADDRESSNUMBER)!=null)
                 address = ALFARecAddress.getRecipientAddress(inputMap);                
            
       }
       if(inputMap.containsKey('faxnumber') && inputMap.get('faxnumber')!=null)
       address.recipientFax = inputMap.get('faxnumber');
       
       system.debug('Forms_RecipientAddressMapping::mappingRecipientToDocReq::recipientAddressObj::'+address);
        if(address!=null){
            Document_Request__c docReq = documentData.getDocumentRequest();
            docReq.Recipient_Nameline1__c = address.nameline1;
            docReq.Recipient_Address1__c = address.recipientAddress1;
            docReq.Recipient_Address2__c = address.recipientAddress2;
            docReq.Recipient_CityStateZipCode__c = address.cityStateZipCode;
            docReq.CustomString1__c = address.deceased;
            docReq.Recipient_Fax__c = address.recipientFax;
            
            documentData.setDocumentRequest(docReq);
           
        }
        
       }
       
       //Wrapper class to hold the recipient Address.
       public class RecipientAddress{
        
            public String nameline1;
            public String recipientAddress1;
            public String recipientAddress2;
            public String cityStateZipCode;
            public String deceased;
            public String recipientFax;
        
       } 
    }