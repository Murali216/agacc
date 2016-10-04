@isTest
private class Forms_WebServiceHelperTest
{
    public static String loadQuoteXML;
    public static String loadAssetXML;
    static testmethod void recordsCreation(){
        
        Map<String, String> inputMap = new Map<String, String>();
        inputMap.put('accountnumber', '12345');
        
        Map<String, String> serviceNameRequestMap = new Map<String, String>();
        serviceNameRequestMap.put('agreementsecurityservice.listsecuritysforagreement','Service_Name__c');
        
        Map<String, String> serviceNameResponseMap = new Map<String, String>();
        serviceNameResponseMap.put('agreementsecurityservice.listsecuritysforagreement','Service_Name__c');
        
        Map<String, String> serviceNameSystemMap = new Map<String, String>();
        serviceNameSystemMap .put('agreementsecurityservice.listsecuritysforagreement','Service_Name__c');
        
        List<Forms_ResponseData__c> formsResponseDataObjectList = new List<Forms_ResponseData__c>();
        Forms_ResponseData__c formResponseData = new Forms_ResponseData__c ();
        formResponseData.Requesting_System__c ='ALFA';
        formResponseData.Service_Name__c='agreementsecurityservice.listsecuritysforagreement';
        formResponseData.Source_System__c ='NA';
        formsResponseDataObjectList.add(formResponseData);
        
        formResponseData = new Forms_ResponseData__c ();
        formResponseData.Requesting_System__c ='ALFA';
        formResponseData.Service_Name__c='rescheduleenquiryservice.loadrescheduleinformation';
        formResponseData.Source_System__c ='NA';
        formsResponseDataObjectList.add(formResponseData);
        Insert formsResponseDataObjectList;
       // Forms_TestDataCreation.formsMetaDataCreation();
        List<Attachment> attachmentObjectList = new List<Attachment>();
        
        /*
        loadQuoteXML= '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://ws.chpconsulting.com/alfa/requestcontext/v1" xmlns:v11="http://ws.chpconsulting.com/alfa/user/v1">'+
                               '<soapenv:Header>'+ 
                                   '<v1:context>'+  
                                        '<v1:data></v1:data>'+ 
                                        '<v1:realmId></v1:realmId> '+
                                        '<v1:sessionId></v1:sessionId>'+ 
                                        '<v1:systemId></v1:systemId> '+
                                        '<v1:uniqueInterfaceId></v1:uniqueInterfaceId>'+
                                        '<v1:userId></v1:userId> '+
                                    '</v1:context>'+
                                '</soapenv:Header>'+
                                '<soapenv:Body>'+
                                    '<v11:load>'+ 
                                        '<userId></userId>'+ 
                                    '</v11:load>'+ 
                                '</soapenv:Body>'+
                            '</soapenv:Envelope>';*/
        /*Attachment attachment = new Attachment();
        attachment.Name = 'request.xml';*/
        //attachment.ParentId = formServiceList[0].Id;
        //attachment.Body = Blob.valueOf(loadQuoteXML); 
        //Insert attachment;                   
        
       /*loadAssetXML = '<request>'+
                        '<entitykey>5555</entitykey>'+
                        '</request>';*/
                      
        /*attachment = new Attachment();
        attachment.Name = 'request.xml';*/
       // attachment.ParentId = formServiceList[1].Id;
       // attachment.Body = Blob.valueOf(loadAssetXML); 
        //Insert attachment; 
        Forms_WebServiceHelper.createServiceResponse(inputMap,serviceNameRequestMap,serviceNameResponseMap,serviceNameSystemMap);
        
        }
    }