/*
#########################################################################################
Project Name          : TFS Forms Implementation
File                  : Forms_WS_GenerateDocument
Version               : 1.0
Created by            : Hanumantha
Created Date          : 10/07/2015> 
Last Modified by      : Hanumantha
Last Modified Date    : 10/07/2015 >
Description           : This class is used to generate the document request and document request line item response.

Change Request History:
Charitha S  12/07/2015   //Added code to replace boolean values in the generated XML if true - 1 & if false - 0.
      
##########################################################################################
 */

global without sharing class FORMS_WS_GenerateDocument {

  


  // Response structure for the web service wrapper
  public class ResponseRecord{
    public Integer ResultCode;
    public String ResultDesc;
    public String ResultString;
    public String RequestString;
  }

  
  
  private static XMLNode recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(XMLNode parentNode, String destString, FormField formField, sObject sObjWithValues) {
         
    String[] splitObjProps = destString.split('\\.',0);
    String finalProp = splitObjProps[splitObjProps.size() - 1];
    String currentProp = splitObjProps[0];
    XMLNode tmpNodeNextChild;
    //BEGIN RECURRSIVE LOOP
    if(splitObjProps.size() > 1 || 
        ( currentProp.contains('\\|') || currentProp.contains('\\&\\#\\1\\2\\4\\;') || currentProp.contains('|') || currentProp.contains('&#124;') )) 
    {
      if(currentProp.contains('\\|') || currentProp.contains('\\&\\#\\1\\2\\4\\;') || currentProp.contains('|') || currentProp.contains('&#124;')) {
        //then we're looking at a 1:many node.
        //we do not create anything beyond the '|' -- child "Lists" will be added after this recursive loop.
        currentProp = currentProp.replace('\\&\\#\\1\\2\\4\\;', '\\|');
        currentProp = currentProp.split('\\|',0)[0]; //CLEAN OUT PIPE
        tmpNodeNextChild = parentNode.get(currentProp);
        if(tmpNodeNextChild == null) {
          tmpNodeNextChild = createAndAppendContainerNode(parentNode, currentProp);
        }
        //RETURN ONE-TO-MANY PARENT NODE
        return tmpNodeNextChild;
      }else{
        String remainingProps = destString.replaceFirst(currentProp + '.', '');
       tmpNodeNextChild = parentNode.get(currentProp);
        if(tmpNodeNextChild == null) {
          tmpNodeNextChild = createAndAppendContainerNode(parentNode, currentProp);
        }
       
        //RECURSIVE CALL -- pass in remaining properties
        //e.g. "Requests.Request.Blah.CreatedDate" to "Request.Blah.CreatedDate" (passing in parent tmpNodeNextChild called "Requests")         
                return recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(tmpNodeNextChild, remainingProps, formField, sObjWithValues);
      }
    }else{
        appendPropertyNode(parentNode, formField, currentProp, sObjWithValues);
    }

    //RETURN NULL BECAUSE THIS IS NOT A ONE-TO-MANY PARENT NODE    
    return null;
  }

  private static XMLNode createAndAppendContainerNode(XMLNode directParentNode, String nodeName) {
    XMLNode nodeToReturn = new XMLNode(true,nodeName,'','');
    directParentNode.addChild(nodeToReturn);
    return nodeToReturn;
  }

  private static String getYYYYMMDDStringFromDate(Date d) {
    String strToReturn = '';
    if(d != null) {
      //yyyy-mm-dd
      strToReturn += String.valueOf(d.year());
      strToReturn += '-';
      if(d.month() < 10) {
        strToReturn += '0';
      }
      strToReturn += String.valueOf(d.month());
      strToReturn += '-';
      if(d.day() < 10) {
        strToReturn += '0';
      }
      strToReturn += String.valueOf(d.day());


    }
    return strToReturn;
  }

  private static String getYYYYMMDDStringFromDateTimeInGMT(DateTime d) {
    String strToReturn = '';
    if(d != null) {
      //yyyy-mm-dd
      strToReturn += String.valueOf(d.yearGmt());
      strToReturn += '-';
      if(d.monthGmt() < 10) {
        strToReturn += '0';
      }
      strToReturn += String.valueOf(d.monthGmt());
      strToReturn += '-';
      if(d.dayGmt() < 10) {
        strToReturn += '0';
      }
      strToReturn += String.valueOf(d.dayGmt());


    }
    return strToReturn;
  }

  private static XMLNode lastPropertyNode;
  private static void appendPropertyNode(XMLNode directParentNode, FormField formField, String nodeName, sObject sObjWithValues) {

    String value = '';
    Object objectValue;
      if(sObjWithValues != null) {
      objectValue = sObjWithValues.get(formField.targetField);
      if(objectValue == null) {
        value = '';
      }else if((Object)objectValue instanceof Date) {
        Date tmpD = (Date)objectValue;
        value = getYYYYMMDDStringFromDate(tmpD);
      }else if((Object)objectValue instanceof DateTime) {
        DateTime tmpDT = (DateTime)objectValue;
        value = getYYYYMMDDStringFromDateTimeInGMT(tmpDT);
      }
      else{
        value = String.valueOf(objectValue);
      }
    }
    if(value == null || value == 'null') {
      value = ''; 
    }

    value = value.replaceAll('&','&amp;');
    XMLNode newNode = directParentNode.get(nodeName);
    if(newNode == null){
      newNode = new XMLNode(nodeName,value);
      directParentNode.addChild(newNode);
    }else{
      newNode.value = value;
    }

    lastPropertyNode = newNode;
       
  }


  
  
  private static void addHeaderValues(XMLNode grandParentNode) {
    FormField servAppFormField = new FormField();
    servAppFormField.destinationNode = 'soapenv:Header';
    servAppFormField.lineItemField = true;
    servAppFormField.lineItemType = null;
    servAppFormField.targetField = '';

    XMLNode servAppNode = recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(grandParentNode, servAppFormField.destinationNode, servAppFormField, null);
    
  }

  /*
   *  buildFormFieldMap is the main method
   *  FormName is Form_c.Form_Number__c; '4397' for example.
   *  
   *
   */
  public static XMLNode buildFormFieldMap(String formName, Document_Request__c docRequest, List<Document_Request_Line_Item__c> docRequestLineItems) {

    /*XMLNode grandParentNode = new XMLNode(true, 'Envelope', 
        'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:for="http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/FormsReqSync" xmlns:ser="http://www.tfs.com/TFS/SharedComponents/ServiceSchemas/Common/ServiceApplicationArea" xmlns:n="http://tfs.toyota.com/LCFORMS/"', 
        'soapenv');
        */
   try{    
      XMLNode grandParentNode = new XMLNode(true, 'Envelope', 
        'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="http://tfs.toyota.com/EIP/CRM/SharedServices/Schema/GenerateFormService/v1.0.0" xmlns:n="http://tfs.toyota.com/LCFORMS/"', 
        'soapenv');
        //TODO - replace second parameter with some id
    
        //addStaticValues(grandParentNode, 'a0S19000000i1mU');
        addHeaderValues(grandParentNode);
        
    FormField firstChildTmpFormField = new FormField();
    //firstChildTmpFormField.destinationNode = 'soapenv:Body.for:FormsReqSync.for:ProcessService.for:FormsReqBOD.for:ListOfForms.n:LCForms|x.x';
    firstChildTmpFormField.destinationNode = 'soapenv:Body.v1:GenerateFormRequest.n:LCForms|x.x';
    firstChildTmpFormField.lineItemField = true;
    firstChildTmpFormField.lineItemType = null;
    firstChildTmpFormField.targetField = '';
    
    XMLNode oneToManyNode;
    XMLNode dispatchesPrinterNode; //lcf:Request.lcf:Dispatches.lcf:Dispatch.DeviceName
    Map<String,XMLNode> mapOfOneToManyParentNodes = new Map<String,XMLNode>();
    Map<String,List<FormField>> oneToManyFormFieldRecords = new Map<String,List<FormField>>();

    //PARENT NODE IS THE ListOfForms.LCForms level.
    XMLNode parentNode = recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(grandParentNode, firstChildTmpFormField.destinationNode, firstChildTmpFormField, null);
    System.debug('FORMS_WS_GenerateDocument :: buildFormFieldMap() ::: form Number===>'+formName +' ::parentNode ===>'+parentNode);
    
      Form_Field_Junction__c[] junctObjList = new Form_Field_Junction__c[]{};
        FormField[] formFieldList = new FormField[]{};
        Set<String> docRequestFields = new Set<String>();
        Set<String> lineItemFields = new Set<String>();
        String fieldName;
        
        for(Form_Field_Junction__c junctObj : [select form__r.name, Form_Field__r.Source_Field__c, Form_Field__r.Source_Object__c, 
                                                Form_Field__r.Target_Field__c, Form_Field__r.Line_item_field__c, 
                                                Form_Field__r.Line_item_type__c, Form_Field__r.WS_DestinationNode__c, 
                                                Form_Field__r.WS_Sequence__c
                                                from form_field_junction__c
                                                where form__r.Form_Number__c = :formName
                                                and Form_Field__r.WS_DestinationNode__c <> ''
                                                and Form_Field__r.WS_DestinationNode__c <> '#N/A'
                                                order by Form_Field__r.WS_Sequence__c]) 
        {
            formFieldList.add( new FormField(junctObj.Form_Field__r) );
          }
          
         
        
    
    
    //MAIN XML NODE GENERATION LOOP.
    for(FormField formFieldObj : formFieldList) {
            //destString = object notation of data's destination; e.g. "Request.CreatedDate"
            String destString = formFieldObj.destinationNode;            
            
            //add node to main parent node.            
            if(!formFieldObj.lineItemField && docRequest.get(formFieldObj.targetField)!=null && String.valueOf(docRequest.get(formFieldObj.targetField)).trim().length() > 0 ){
                 recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(parentNode, destString, formFieldObj, docRequest);
            }else if(formFieldObj.lineItemField){
                 //destString = object notation of data's destination; e.g. Account.InsuranceRefunds|InsuranceRefund.Name and lineitemType is ExpenseType
                 boolean childrenExists = false;
                 String lineItemtype =  formFieldObj.lineItemType;
                 //Creating OneToManyNode i.e., till InsuranceRefunds.
                 if(!mapOfOneToManyParentNodes.containsKey(lineItemtype)){         
                            oneToManyNode = recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(parentNode, destString, formFieldObj, docRequest);
                            mapOfOneToManyParentNodes.put(lineItemtype, oneToManyNode);                     
                         }
                
                if(oneToManyNode.children.size()>0){
                    childrenExists = true;
                    System.debug('Forms_WS_GenerateDocument:bBuildFormFiedlMap::For lineItemtype '+lineItemtype+' no of childrens '+oneToManyNode.children.size());
                }
                
                Boolean childrenAdded = false;
                integer i=0;
                
                 for(Document_Request_Line_Item__c docLineItem : docRequestLineItems) {
                    
                    childrenAdded = true;                   
                    if(lineItemtype.equalsIgnoreCase(docLineItem.Type__c) )
                    {
                        if(docLineItem.get(formFieldObj.targetField) != null && docLineItem.get(formFieldObj.targetField) != 'null' && String.valueOf(docLineItem.get(formFieldObj.targetField)).trim().length() > 0)
                       {    
                        destString = formFieldObj.destinationNode; 
                        destString = destString.substring(destString.indexOf('|') + 1);
                        //sending destString only 'name' if InsuranceRefunds children InsuranceRefund already exists.
                        if(childrenExists){
                            destString = destString.substring(destString.indexOf('.') + 1);
                            recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(oneToManyNode.children.get(i), destString, formFieldObj, docLineItem);  
                            i=i+1;
                        }                       
                        else
                        {
                            //sending destString InsuranceRefund.Name if children not exists for oneToManyNode InsuranceFunds.
                            recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany(oneToManyNode, destString, formFieldObj, docLineItem);
                            if(childrenAdded) {
                         //THIS IS DONE SO THAT InsuranceRefunds.InsuranceRefund.Name(eg) DOES NOT GET OVERWRITTEN
                          //TWO XML-NODES WITH THE SAME NAME IN THE PARENT NODE WILL USE MAP.GET() (in recursivelyAppendNodesAndReturnLastChildNodeIfOneToMany) 
                          //TO DETERMINE IF CREATE-NEW AND TRAVERSE [OR ONLY TRAVERSE] TO NEXT CHILD NODE
                          Integer childNodeIndex = oneToManyNode.children.size() - 1;
                          XMLNode lastChildAdded = oneToManyNode.children.get(childNodeIndex);
                          oneToManyNode.childrenNodesByName.remove(lastChildAdded.name);
                            }
                        }
                     }else{
                        if(childrenExists)
                        i = i+1;
                     }
                    }
                   }
            }
            
            
        }
      
    if( mapOfOneToManyParentNodes.size() > 0 ) {
      //now, InsuranceRefunds.InsuranceRefund cannot be empty if InsuranceRefund exists.  Remove if empty.
      for(XMLNode nodeToPotentiallyRemove : mapOfOneToManyParentNodes.values()) {
        if(nodeToPotentiallyRemove.children == null || nodeToPotentiallyRemove.children.size() == 0) {
            
            XMLNode parent = nodeToPotentiallyRemove.myParentNode;
            nodeToPotentiallyRemove.removeFromParent();
            if(parent.children == null || parent.children.size() == 0)
                parent.removeFromParent(); 
         }
      }
    }


    if(dispatchesPrinterNode != null && (dispatchesPrinterNode.value == null || dispatchesPrinterNode.value == '') ) {
      //then no printer selected.  remove node.
      XMLNode dispatchesNode = dispatchesPrinterNode.myParentNode.myParentNode ;
      dispatchesNode.removeFromParent();
      //lcf:Request.lcf:Dispatches.lcf:Dispatch.DeviceName
    }
    //Added below code to replace boolean values true to 1 & false to 0.
    
    
    System.debug('XML ouput=========>'+grandParentNode.getXmlString());
    System.debug(LoggingLevel.ERROR, '***** xmlJive - ' + grandParentNode.getXmlString() + ' *****');
    
   
    return grandParentNode;
    }
    
    
catch(Exception e){ 
            system.debug(e);
            system.debug('FORMS_WS_GenerateDocument::buildFormFieldMap::Exception:'+ e.getMessage()+':::'+e.getStackTraceString()+':::'+e.getLineNumber()+':::'+e.getCause());  
            
        } 
    return null;
  }


  public class XMLNode {

    public String name;
    public String value;
    public String nameSpaceString;
    public String nameSpacePrefix;

    public XMLNode myParentNode;

    public List<XMLNode> children;
    public Map<String,XMLNode> childrenNodesByName;
    

    public XMLNode get(String propName) {
      return childrenNodesByName.get(propName);
    }
    
    public String getXmlString() {
      String strToReturn = '<';
      if(nameSpacePrefix != null && nameSpacePrefix != '') {
        strToReturn += nameSpacePrefix + ':';
      }
      strToReturn += name;
      if(nameSpaceString != null && nameSpaceString != '') {
        strToReturn += ' ' + nameSpaceString;
      }
      strToReturn += '>';

      //GET CHILD XML STRINGS
      if(children != null) {
        for(XMLNode childNode : children) {
          strToReturn += childNode.getXmlString();
           }
      }else if(value != null && value != ''){
        strToReturn += value;
      }

      strToReturn += '</';
      if(nameSpacePrefix != null && nameSpacePrefix != '') {
        strToReturn += nameSpacePrefix + ':';
      }
      strToReturn += name + '>';
      strToReturn = strToReturn.replace('>false<','>0<');
      strToReturn = strToReturn.replace('>true<','>1<');
      return strToReturn;
    }


    public XMLNode(String nodeName, String nodeValue) {
      this.name = nodeName;
      this.value = nodeValue;
      this.nameSpaceString = '';
      this.nameSpacePrefix = '';
    }
    public XMLNode(String nodeName, String nodeValue, String nameSpaceString, String nameSpacePrefix) {
      this.name = nodeName;
      this.value = nodeValue;
      this.nameSpaceString = nameSpaceString;
      this.nameSpacePrefix = nameSpacePrefix;
    }
    public XMLNode(Boolean initChildren, String nodeName, String nameSpaceString, String nameSpacePrefix) {
      this.name = nodeName;
      this.nameSpaceString = nameSpaceString;
      this.nameSpacePrefix = nameSpacePrefix;

      this.children = new List<XMLNode>();
      this.childrenNodesByName = new Map<String,XMLNode>();
           
    }

    public XMLNode addChildren(List<XMLNode> childrenToAdd) {
      //children.addAll(childrenToAdd);
      for(XMLNode child : childrenToAdd) {
        addChild(child);
      }
      return this;
    }
    public XMLNode addChild(XMLNode child) {
      child.myParentNode = this;
      children.add(child);
      childrenNodesByName.put(child.name, child);
      return this;
    }
    

    public void removeFromParent() {
      if(myParentNode != null) {
        myParentNode.childrenNodesByName.put(this.name,null);
        Integer i = -1;
        Integer n = 0;
        for(XMLNode parentsChild : myParentNode.children) {
          if(parentsChild == this) {
            i = n;
          }
          n++;
        }
        if(i > -1) {
          myParentNode.children.remove(i);
        }
      }
    }

  }


  private class FormField {

    public String destinationNode;
    public String targetField;
    public String lineItemType;
    public Boolean lineItemField;

    public FormField(Form_Field__c ff) {
      this.destinationNode = ff.WS_DestinationNode__c;
      this.targetField = ff.Target_Field__c;
      this.lineItemField = ff.Line_item_field__c;
      this.lineItemType = ff.Line_Item_type__c;
    }

    public FormField() {
    }

  }

}