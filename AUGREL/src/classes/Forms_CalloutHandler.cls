/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_CalloutHandler
Version...............: 1.0
Created by............: Muthu
Created Date..........: 10/14/2015
Last Modified by......: Muthu
Last Modified Date....: 10/20/2015 
Description...........: This class has been written for makeHTTP callout  


Change Request History:
##########################################################################################
*/
public class Forms_CalloutHandler{

    // public Enum ResponseType {DEVELOPMENT, LIVE}
    /*
    Method Name: makeCallout
    Method Signature: String endPoint, String method, String inputXML, String responseTypeArgument
    Method Return type: HttpResponse
    Method Description: This method will be called to make external HTTP callout. This will
                        call the web service and returns the HTTPResponse.
    */
    public HttpResponse makeCallout(String endPoint, String method, String inputXML, String responseTypeArgument){
        Datetime startDate = system.Now();
        system.debug('Forms_CalloutHandler::makeCallout::InputXML Callout'+inputXML);
        system.debug('Forms_CalloutHandler::makeCallout::endPointCallout'+endPoint);
        HttpResponse response = new HttpResponse();
        HttpRequest request = new HttpRequest();
        if(String.isNotBlank(endPoint) && String.isNotBlank(method)){
            request.setEndPoint(endPoint);
            request.setMethod(method);
            request.setBody(inputXML);
            request.setTimeout(120000);
            //Blob authCredBlob = Blob.valueOf('00D19000000Ej8r' + ':' + '00D19000000Ej8r');
            //Blob authCredBlob = Blob.valueOf('00D180000001RJ1' + ':' + '00D180000001RJ1');
            String authCred = setAuthorization();
            request.setHeader('Authorization', 'Basic ' + authCred);
            Http http = new Http();
            if(responseTypeArgument.equals(Forms_Constant.LIVE)){
                response = http.send(request);
                system.debug('Forms_CalloutHandler :: makeCallout :: Request callout'+request +'Response callout'+response );
            } else if(responseTypeArgument.equals(Forms_Constant.DEVELOPMENT)){
                response = new Forms_CalloutResponse().respond(request);
                system.debug('Forms_CalloutHandler :: makeCallout :: Request callout 2'  + request + 'Response callout 2'+ response );
            }
        }
        Forms_Utils.executionTime(startDate,system.now(),'Forms_CalloutHandler','makeCallout');
        return response;
    }
    public String setAuthorization(){
        String userName = Forms_Utils.decryptUserName();
        String password = Forms_Utils.decryptPassword();
        //system.debug('::SET AUTH::'+userName+'::-::'+password);
        Blob authCredBlob = Blob.valueOf(userName + ':' + password);
        String authCred = EncodingUtil.base64Encode(authCredBlob);
        return authCred;
    }
    
    public HttpResponse makeAdobeCallout(String inputxml){
    String endPoint = Forms_DataSelector.getAdobeServiceEndPoint();     
    HttpResponse adobeResponse =  makeCallout(endPoint, 'POST' , inputxml,Forms_Constant.LIVE);	
    
    return adobeResponse;	
    }
}