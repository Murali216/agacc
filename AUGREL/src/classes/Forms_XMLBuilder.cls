/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_XMLBuilder> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <10/02/2015> 
Last Modified by......: <pranav & Muthu>
Last Modified Date....: <11/17/2015 >
Description...........: <This class has been written for generating request XML and parse response XML into Map to send requester system>

Change Request History:
Pranav & Muthu         16/11/2015   Added multiple node code
##########################################################################################
 */
public class Forms_XMLBuilder {
    
    public static Integer attributesCount = 0; 
    static boolean multiFlag = false;
    
    /*
      Method Name:parseXML
      Method Signature/Inputs:String inputXML, List<FormServiceConfig__c> serviceConfigList
      Method Return Type/outputs: valueMap
      Method Description:This method is used to parse  response xml into Map 
    */
    
    
    public static Map<String, String> parseXML(String inputXML, List<FormServiceConfig__c> serviceConfigList){
        Datetime startDate=system.now();
        Map<String, String> valueMap = new Map<String, String>();
        Map<String, Map<String,List<String>>> multiNodeData = Forms_ResponseDataHolder.getMultiNodeData();
        Map<String, String> singleNodeData = Forms_ResponseDataHolder.getSingleNodeData();

        if(String.isBlank(inputXML)){
            return null;
        }
        if(serviceConfigList.size() == 0){
            return null;
        }
        Dom.Document doc = new Dom.Document();
        doc.load(inputXML);
        Dom.XMLNode root = doc.getRootElement();
        Dom.XMLNode childNode;
        String nameSpace = '';
        String nameSpacePrefix = '';
        String rootName = '';
        String parentName = '';
        valueMap = singleNodeData;
        for(FormServiceConfig__c formServiceConfig : serviceConfigList){
            Dom.XMLNode parentNode;
            String[] parentNodeArray = formServiceConfig.ParentNode__c.split('\\.');

               for(String parentNodeString :parentNodeArray){
                if(parentNode == null){
                    if(root.getName() != null){
                        nameSpace = root.getNameSpace();
                        nameSpacePrefix = (String.isNotBlank(nameSpace)? root.getPrefixFor(nameSpace) : null);                      
                        rootName = (String.isNotBlank(nameSpacePrefix)? nameSpacePrefix+':'+root.getName() : root.getName());
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
            //System.debug('Forms_XMLBuilder::parseXML::parentNode'+parentNode);
            if(parentNode != null){
                
                String filteredParentNodeName = parentNode.getName();
              //  System.debug('Forms_XMLBuilder::parseXML::filteredParentNodeName'+filteredParentNodeName);
                List<DOM.XMLNode> parentNodeList = new List<DOM.XMLNode>();
                if(parentNode != null){
                      if(parentNode.getParent() != null && parentNode.getParent().getChildren().size() > 0){
                        parentNodeList = parentNode.getParent().getChildren();                      
                    } else {
                        parentNodeList.add(parentNode);
                    }
                }
                //system.debug('parentNodeList'+parentNodeList);
                for(DOM.XMLNode parentLoopNode : parentNodeList){
				attributesCount = 0;
                   // system.debug(parentLoopNode.getName() +'=='+ filteredParentNodeName);
                    if(parentLoopNode != null && parentLoopNode.getName() == filteredParentNodeName){
                        childNode = null;
                        childNode = getChildNode(parentLoopNode, formServiceConfig.ChildNode__c, formServiceConfig);
                        //system.debug('child node:'+filteredParentNodeName+':::Child:::'+formServiceConfig.ChildNode__c+'::'+childNode);
                        if(childNode != null){
                            if(formServiceConfig.Multiple_Elements_Node__c == false){
                               // System.debug('reference attribute'+formServiceConfig.ReferenceAttribute__c);
                                if(valueMap.containsKey(formServiceConfig.ReferenceAttribute__c)){
                                   // valueMap.put(formServiceConfig.ReferenceAttribute__c, valueMap.get(formServiceConfig.ReferenceAttribute__c)+', '+childNode.getText());
                                   if(formServiceConfig.allFields__c != true){
                                       if(formServiceConfig.Seperator__c !=null)
                                        valueMap.put(formServiceConfig.ReferenceAttribute__c, valueMap.get(formServiceConfig.ReferenceAttribute__c)+formServiceConfig.Seperator__c+' '+childNode.getText());
                                      else
                                        valueMap.put(formServiceConfig.ReferenceAttribute__c, valueMap.get(formServiceConfig.ReferenceAttribute__c)+' '+childNode.getText());
                                   } else {
                                        if(String.isNotBlank(valueMap.get(formServiceConfig.ReferenceAttribute__c)) && String.isNotBlank(childNode.getText()))
                                           valueMap.put(formServiceConfig.ReferenceAttribute__c, String.valueOf(Decimal.valueOf(valueMap.get(formServiceConfig.ReferenceAttribute__c))+Decimal.valueOf(childNode.getText())));
                                   }
                                   // system.debug('forms_xmlbuilder::'+valueMap.get(formServiceConfig.ReferenceAttribute__c));
                                } else {
                                    valueMap.put(formServiceConfig.ReferenceAttribute__c, childNode.getText());
                                }
                               // System.debug('value map'+valueMap);
                               // System.debug('value map inspection'+valueMap.get('allChargeTypesNetBiiled')+'reference'+formServiceConfig.ReferenceAttribute__c);
                            } else if(formServiceConfig.Multiple_Elements_Node__c == true && formServiceConfig.Type__c != null && formServiceConfig.Key__c != null){
                                if(multiNodeData.containsKey(formServiceConfig.Type__c)){
                                    if(multiNodeData.get(formServiceConfig.Type__c).containsKey(formServiceConfig.Key__c)){
                                        multiNodeData.get(formServiceConfig.Type__c).get(formServiceConfig.Key__c).add(childNode.getText());
                                    } else {
                                        multiNodeData.get(formServiceConfig.Type__c).put(formServiceConfig.Key__c, new List<String>{childNode.getText()});
                                    }
                                } else {
                                    multiNodeData.put(formServiceConfig.Type__c, new Map<String, List<String>>{formServiceConfig.Key__c => new List<String>{childNode.getText()}});
                                }
                            }
                            else if(formServiceConfig.Multiple_Elements_Node__c == true){
                                
                                if(valueMap.containsKey(formServiceConfig.ReferenceAttribute__c)){
                                    
                                    if(childNode.getText()==' '||childNode.getText()=='')
                                    valueMap.put(formServiceConfig.ReferenceAttribute__c,valueMap.get(formServiceConfig.ReferenceAttribute__c)+','+'null');
                                    else
                                    valueMap.put(formServiceConfig.ReferenceAttribute__c,valueMap.get(formServiceConfig.ReferenceAttribute__c)+','+childNode.getText());
                                
                                }else{
                                    
                                    valueMap.put(formServiceConfig.ReferenceAttribute__c,childNode.getText());
                                    
                                }
                                //System.debug('Forms_XMLBuilder::ParseXML::valueMap for Multi '+valueMap);
                            }
                        }else if(formServiceConfig.FormService__r.MultiNode__c && formServiceConfig.Multiple_Elements_Node__c == true){
                            if(valueMap.containsKey(formServiceConfig.ReferenceAttribute__c))
                                valueMap.put(formServiceConfig.ReferenceAttribute__c,valueMap.get(formServiceConfig.ReferenceAttribute__c)+','+'null');
                            else
                                valueMap.put(formServiceConfig.ReferenceAttribute__c,'null');
                       }
                    }
                }
            }
            
        }
        Forms_ResponseDataHolder.setSingleNodeData(valueMap);
        Forms_ResponseDataHolder.setMultiNodeData(multiNodeData);
        system.debug('Forms_XMLBuilder::parseXML::Final SingleNodeData::::'+Json.serialize(Forms_ResponseDataHolder.getSingleNodeData()));
        system.debug('Forms_XMLBuilder::parseXML::Final MultiNodeData::::'+Json.serialize(Forms_ResponseDataHolder.getMultiNodeData()));
        Forms_Utils.executionTime(startDate,system.now(),'Forms_XMLBuilder','parseXML');
        return valueMap;
    }     
    
    public static List<String> generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList, boolean isMulti){
       
        List<String> xmlStringList = new List<String>();
        if(isMulti){
        Integer reqValuesCount = 0;
        Map<String, List<String>> tempMap = new Map<String, List<String>>();
       
        for(FormServiceConfig__c serviceConfig : serviceConfigList){
            String req = dataMap.get(serviceConfig.ReferenceAttribute__c);
            if(req!=null && req.trim().length()>0){    
            String[] splitReq = req.split(' ');
            reqValuesCount = splitReq.size();
            tempMap.put(serviceConfig.ReferenceAttribute__c,splitReq);
            }       
        }            
        for(Integer i=0 ; i<reqValuesCount ; i++){          
            for(FormServiceConfig__c serviceConfig : serviceConfigList){
                if(tempMap.containsKey(serviceConfig.ReferenceAttribute__c)){
                dataMap.put(serviceConfig.ReferenceAttribute__c,tempMap.get(serviceConfig.ReferenceAttribute__c).get(i));
                inputMap.put(serviceConfig.ReferenceAttribute__c,tempMap.get(serviceConfig.ReferenceAttribute__c).get(i));
                }
            }
            //System.debug('Forms_XMLBuilder::GenerateXML::inputMap for Multi '+inputMap);
            String reqXmlString = generateXML(xmlString, inputMap, dataMap, serviceConfigList) ;
            xmlStringList.add(reqXmlString);            
        }
       }
       return xmlStringList;
    }    

    /*
      Method Name:generateXML
      Method Signature/Inputs:String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList
      Method Return Type/outputs: outputXML
      Method Description:This method is used to read the request XML from Attachment and will add the values based on specific node.it will store the xml data in a string. 
    */   
    public static String generateXML(String xmlString, Map<String, String> inputMap, Map<String, String> dataMap, List<FormServiceConfig__c> serviceConfigList){
       Datetime startDate=system.now();
     //  system.debug('Forms_XMLBuilder::generateXML::InputMap::'+json.serialize(inputMap));
       // system.debug('Forms_XMLBuilder::generateXML::serviceConfigList::'+serviceConfigList);
        
        if(String.isBlank(xmlString)){
            return null;
        }
        if(inputMap.size() == 0 && dataMap.size() == 0){
            return null;
        }
        if(serviceConfigList.size() == 0){
            return null;
        }
        
        String outputXML;
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);   
        Dom.XMLNode root = doc.getRootElement();
        
        Dom.XMLNode childNode;
        String nameSpace = '';
        String nameSpacePrefix = '';
        String rootName = '';
        String parentName = '';
         for(FormServiceConfig__c formServiceConfig : serviceConfigList){
            String refAttribute = formServiceConfig.ReferenceAttribute__c;
            String refAttributeValue = inputMap.get(refAttribute);
            String refAttributeValue1 = dataMap.get(refAttribute);
            System.debug('input data check'+ refAttribute+'::'+refAttributeValue1+'::'+refAttributeValue);
            if(!(refAttributeValue!=null && refAttributevalue.trim().length()>0) && !(refAttributeValue1!=null && refAttributevalue1.trim().length()>0)){
                return '';
            }
            
        }       
        for(FormServiceConfig__c formServiceConfig : serviceConfigList){
            
            Dom.XMLNode parentNode;
            String[] parentNodeArray = formServiceConfig.ParentNode__c.split('\\.');
            
            for(String parentNodeString :parentNodeArray){
                if(parentNode == null){
                    if(root.getName() != null){
                        nameSpace = root.getNameSpace();
                        nameSpacePrefix = (String.isNotBlank(nameSpace)? root.getPrefixFor(nameSpace) : null);                      
                        rootName = (String.isNotBlank(nameSpacePrefix)? nameSpacePrefix+':'+root.getName() : root.getName());
                        if(rootName.equalsIgnoreCase(parentNodeString)){
                            parentNode = root;
                        }
                    }
                } else {
                    String[] splitTag = parentNodeString.split('\\:');
                    nameSpace = (splitTag.size() == 2? root.getNameSpaceFor(splitTag[0]) : null);
                    nameSpacePrefix = (String.isNotBlank(nameSpace)? parentNode.getPrefixFor(nameSpace) : null);                        
                    if(String.isBlank(nameSpace) && splitTag.size() == 2){
                        String nameSpaceAndPrefix = getNameSpaceAndNameSpacePrefix(splitTag[0], parentNode);
                        String[] splitedValue = nameSpaceAndPrefix.split('\\~');
                        if(splitedValue.size() == 2){
                            nameSpace = splitedValue[0];
                            nameSpacePrefix = splitedValue[1];
                        }
                    }
                    parentNodeString = parentNodeString.replace(nameSpacePrefix+':', ''); 
                    parentNode = parentNode.getChildElement(parentNodeString, nameSpace);       
                }
                
            }
            if(parentNode != null){                
                    String[] splitTag = formServiceConfig.ChildNode__c.split('\\:');
                    nameSpace = (splitTag.size() == 2? root.getNameSpaceFor(splitTag[0]) : null);
                    
                    nameSpacePrefix = (String.isNotBlank(nameSpace)? root.getPrefixFor(nameSpace) : null);                      
                    if(String.isBlank(nameSpace) && splitTag.size() == 2){
                        String nameSpaceAndPrefix = getNameSpaceAndNameSpacePrefix(splitTag[0], parentNode);
                        String[] splitedValue = nameSpaceAndPrefix.split('\\~');
                        if(splitedValue.size() == 2){
                            nameSpace = splitedValue[0];
                            nameSpacePrefix = splitedValue[1];
                        }
                    }
                    String childNodeString = formServiceConfig.ChildNode__c.replace(nameSpacePrefix+':', '');                
                    
                // inserting input data to xml    
                if(formServiceConfig.ReferenceAttribute__c != null && (inputMap.containsKey(formServiceConfig.ReferenceAttribute__c) || dataMap.containsKey(formServiceConfig.ReferenceAttribute__c))){
                    if(parentNode.getChildElement(childNodeString, nameSpace) != null){
                        if(inputMap.containsKey(formServiceConfig.ReferenceAttribute__c)){                       
                            if(multiFlag){
                                String[] refAttributes = inputMap.get(formServiceConfig.ReferenceAttribute__c).trim().split(' ');
                                childNode = parentNode.getChildElement(childNodeString, nameSpace).addTextNode(refAttributes[0]);
                                String newRefAttribute='';
                                for(integer i=1; i<refAttributes.size();i++){
                                    newRefAttribute = newRefAttribute+refAttributes[i]+' ';
                                }
                               // System.debug('new reference attribute'+newRefAttribute);
                            }else{
                             childNode = parentNode.getChildElement(childNodeString, nameSpace).addTextNode(inputMap.get(formServiceConfig.ReferenceAttribute__c));
                            }    
                        } else if(dataMap.containsKey(formServiceConfig.ReferenceAttribute__c)){
                            
                            if(multiFlag){
                               // System.debug('multi record'+dataMap.get(formServiceConfig.ReferenceAttribute__c));
                            }
                            childNode = parentNode.getChildElement(childNodeString, nameSpace).addTextNode(dataMap.get(formServiceConfig.ReferenceAttribute__c));
                        }
                    }    
                } else {
                    childNode = parentNode.getChildElement(childNodeString, nameSpace);                
                }
            }
        }
        outputXML = doc.toXMLString();
      //  system.debug('Forms_XMLBuilder::generateXML::Output XML'+outputXML);
        Forms_Utils.executionTime(startDate,system.now(),'Forms_XMLBuilder','generateXML');
        return outputXML;
    } 
    
    
    public static String getNameSpaceAndNameSpacePrefix(String nameSpaceString, Dom.XMLNode inputXMLNode){
        String output = ':';
        String nameSpace = '';
        String nameSpacePrefix = '';
        if(String.isNotBlank(nameSpaceString)){
            if(inputXMLNode.getChildren().size() > 0){
                for(Dom.XMLNode xmlNode : inputXMLNode.getChildren()){
                    if(xmlNode.getNameSpaceFor(nameSpaceString) != null){
                        nameSpace = xmlNode.getNameSpaceFor(nameSpaceString);
                        if(String.isNotBlank(nameSpace)){
                            nameSpacePrefix = xmlNode.getPrefixFor(nameSpace);
                        }
                        output = nameSpace+'~'+nameSpacePrefix;
                    }
                }
            }
        }
        return output;
    }
    
    public static DOM.XMLNode getChildNode(DOM.XMLNode parentNode, String childNodeString, FormServiceConfig__c formServiceConfig){
        DOM.XMLNode outputNode;
        DOM.XMLNode inputParentNode = parentNode;
        
        String[] splitTag = new String[2];
        List<String> childStringList = new List<String>();
        //If child node contains multiple nodes, split and assign it to list
        
        if(formServiceConfig.ChildNode__c != null && formServiceConfig.ChildNode__c.split('\\.').size() > 0){
            for(String childNode : formServiceConfig.ChildNode__c.split('\\.')){
                String[] splitChildTag = childNode.split('\\:');
                childNodeString = (splitChildTag.size() == 2 ? splitChildTag[1] : splitChildTag[0]);
                childStringList.add(childNodeString);
            }
            
        }
        if(childStringList.size() > 0)
            childStringList.remove(childStringList.size()-1);
        String attributeTypeString;
               
        for(Dom.XMLNode xmlNode : parentNode.getChildren()){
            
            Dom.xmlNode tempParent = xmlNode.getParent();
        
            String elementAttributeValue;
            if(formServiceConfig.ElementAttributeKey__c!=null){
                 elementAttributeValue =xmlNode.getParent().getAttributeValue(formServiceConfig.ElementAttributeKey__c,'http://www.w3.org/2001/XMLSchema-instance');
            }
            
            /*
            If service Config has two or more conditions to get the value from service response
            Expecting AttributeKey__c in attribute1;attribute2 format. ex:v1:paymentType;v1:paymentMethod
            Expecting AttributeValue__c in value1;value2 format. ex:Rejection;AI                        
            */
            if(formServiceConfig.isMultipleAttribute__c == true && formServiceConfig.AttributeKey__c != null){
                String[] attributes = formServiceConfig.AttributeKey__c.split('\\;');
                String[] values = formServiceConfig.AttributeValue__c.split('\\;');
                 integer i=0;
                for(String attribute : attributes){
                    String[] splitAttributes =  attribute.split('\\:');
                    String attributeValue = values[i];
                    attributeTypeString = (splitAttributes.size() == 2 ? splitAttributes[1] : splitAttributes[0]);
                    if(String.isNotBlank(attributeTypeString) && xmlNode != null && String.isNotBlank(xmlNode.getName()) 
                        && xmlNode.getName().equalsIgnoreCase(attributeTypeString)){
                            if(String.isNotBlank(xmlNode.getText()) && attributeValue != null && xmlNode.getText().equalsIgnoreCase(attributeValue) && formServiceConfig.ElementAttributeValue__c == null)
                        {
                            attributesCount++;                             
                        }                        
                    }
                    i++;
                }
               if(attributesCount == attributes.size()){
                    tempParent = xmlNode.getParent();
                    outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);
                }
            }
            if(formServiceConfig.IsAttribute__c == true && formServiceConfig.AttributeKey__c != null){
                 splitTag = formServiceConfig.AttributeKey__c.split('\\:');
                 attributeTypeString = (splitTag.size() == 2 ? splitTag[1] : splitTag[0]);
                 if(String.isNotBlank(attributeTypeString) && xmlNode != null && String.isNotBlank(xmlNode.getName()) 
                                                           && xmlNode.getName().equalsIgnoreCase(attributeTypeString)){
                        if(String.isNotBlank(xmlNode.getText()) && formServiceConfig.AttributeValue__c != null && xmlNode.getText().equalsIgnoreCase(formServiceConfig.AttributeValue__c) && formServiceConfig.ElementAttributeValue__c == null)
                        {
                             tempParent = xmlNode.getParent();
                             outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);
                        } else if(String.isNotBlank(xmlNode.getText()) && formServiceConfig.AttributeValue__c != null && xmlNode.getText().equalsIgnoreCase(formServiceConfig.AttributeValue__c) && elementAttributeValue!=null && formServiceConfig.ElementAttributeValue__c != null && elementAttributeValue.equalsIgnoreCase(formServiceConfig.ElementAttributeValue__c)){
                             outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);    
                        }
                       
                    }
            } else if(formServiceConfig.allFields__c == true){
                    outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);
            } else if(String.isNotBlank(xmlNode.getText()) && formServiceConfig.ElementAttributeValue__c != null){
                if(elementAttributeValue.equalsIgnoreCase(formServiceConfig.ElementAttributeValue__c))
                           outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);
                }else {
                    if(String.isNotBlank(childNodeString) && xmlNode != null && String.isNotBlank(xmlNode.getName()) 
                                                         && xmlNode.getName().equalsIgnoreCase(childNodeString)){
                               outputNode = xmlNode;   
                    }
                }
                if(formServiceConfig.isMultipleAttribute__c == true && formServiceConfig.AttributeKey__c == null){
                  outputNode = getChildFromParent(xmlNode, childStringList, childNodeString);
                }
            }
      
        return outputNode;
    }
    public static Dom.XMLNode getChildFromParent(Dom.XMLNode xmlNode, List<String> childStringList, String childNodeString){
      Dom.xmlnode outputNode;
      Dom.xmlNode tempParent = xmlNode.getParent();
            /*
              If multiple nodes configured in FormServiceConfig childnode we are iterating 
              all nodes and finding immediate parent node
            */
            //System.debug(tempParent+'childstrnglist:::'+childNodeString+':::'+childStringList);
            if(childStringList.size() > 0){
        
        for(String parentNodeString :childStringList){
                  if(tempParent != null && tempParent.getChildren().size() > 0){
                      for(Dom.XMLNode parentXmlNode : tempParent.getChildren()){
                          if(String.isNotBlank(parentNodeString) && parentXmlNode != null && String.isNotBlank(parentXmlNode.getName()) 
                              && parentXmlNode.getName().equalsIgnoreCase(parentNodeString)){
                              
                              tempParent = parentXmlNode;
                             
                          }
                      }
                  }
              }
        }
            if(tempParent != null){
                for(Dom.XMLNode xmlNode1 : tempParent.getChildren()){
                    if(String.isNotBlank(childNodeString) && xmlNode1 != null && String.isNotBlank(xmlNode1.getName()) 
                        && xmlNode1.getName().equalsIgnoreCase(childNodeString)){
                        outputNode = xmlNode1;  
                    }
                }
            }
            system.debug(':::OUTPUT:::'+outputNode);
            return outputNode;
    }
      
}