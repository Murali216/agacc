/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_Request
Version...............: 1.0
Created by............: Hanumantha
Created Date..........: 10/12/2015
Last Modified by......: 
Last Modified Date....: 10/6/2015 
Description...........: This class is created to declare fewvariables and to be used as an wrapper class.

Change Request History:
##########################################################################################
 */




public class Forms_Request {

    public String formID  {get;set;}
    public String accountNumber {get;set;}
    public String formType {get;set;}
    public String dispatchMode {get;set;}
    public List<Forms_RequestAttributes> attributes{get;set;}
    
    Public Forms_Request(){
    }

    public class Forms_RequestAttributes{
        public String attributeKey {get;set;}
        public String attributeValue {get;set;}

    }


}