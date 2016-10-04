/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_DocumentDataHolder
Version...............: 1.0
Created by............: Hanumantha
Created Date..........: 11/09/2015
Last Modified by......: Pranav 
Last Modified Date....: 11/16/2015
Description...........: This is a wrapper class used for storing the values of document request object and document request line item 
                        objects to be used in data Aggregation Helper class.

Change Request History:
##########################################################################################
*/
public class Forms_DocumentDataHolder{
        Document_Request__c   documentRequest = new Document_Request__c();
        List<Document_Request_Line_Item__c> lineItems = new List<Document_Request_Line_Item__c>();
        
        /* Method Name: setDocumentRequest
        Method Signature/Inputs: instance of Document request object
        Method Return Type/outputs: NULL
        Method Description: This is a getter method for document request object.
        */
        public void setDocumentRequest(Document_Request__c docRequest){
            documentRequest = docRequest;
        }
        /* Method Name: getDocumentRequest
        Method Signature/Inputs:NULL
        Method Return Type/outputs: instance of Document request object
        Method Description: This is a getter method for document request object.
        */
        public Document_Request__c   getDocumentRequest(){
            return documentRequest;
        }
        /* Method Name: setLineItems
        Method Signature/Inputs: List of document request line item objects
        Method Return Type/outputs: NULL 
        Method Description: This is a setter method for lineitems list. 
        */
        public void setLineItems(List<Document_Request_Line_Item__c> lineItems){
              this.lineItems = lineItems;
        }
        /* Method Name: getLineItems
        Method Signature/Inputs: NULL
        Method Return Type/outputs: List of document request line item objects
        Method Description: This is a getter method for document request line item object.
        */
        public List<Document_Request_Line_Item__c> getLineItems(){
            return lineItems;
        }
        /* Method Name: addLineItem
        Method Signature/Inputs: an instance of document request line item object
        Method Return Type/outputs: NULL
        Method Description: This method is used to add the input document request line item object to the lineItems list.
        */
        public void addLineItem(Document_Request_Line_Item__c lineItem){
            lineItems.add(lineItem);
        }
        
    }