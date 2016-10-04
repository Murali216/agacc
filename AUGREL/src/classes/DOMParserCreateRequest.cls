public class DOMParserCreateRequest {
    
    public static void createRequest()
    {
        DOM.Document doc = new DOM.Document();
        
        String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
        String ema = 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/EmailValidationtReqSync';
        String ser = 'http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/Common/ServiceApplicationArea';
        
                dom.XmlNode envelope= doc.createRootElement('Envelope', soapNS, 'soapenv');
        envelope.setNamespace('ema', ema);
        envelope.SetNamespace('ser',ser);
      
        
        dom.XmlNode body
            = envelope.addChildElement('Body', soapNS, null);
        
        body.addChildElement('EmailValidationReqSync', ema, null).
           addChildElement('ProcessService', ema, null).addChildElement('ServiceApplicationArea', ema, null).addChildElement('ConversationID',ser,null).addTextNode('49147491-b108-c4c6-14ed-53fed991f4f7');
         
        
        System.debug(doc.toXmlString());
        
        
        
    }

}