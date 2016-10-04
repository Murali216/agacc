public class Forms_ResponseDataHolder {
    
    public static Map<String,String> singleNodeData = new Map<String,String>();
    public static Map<String, Map<String,List<String>>> multiNodeData = new Map<String, Map<String,List<String>>>();
    
    public static void setSingleNodeData(Map<String,String> dataMap){
           singleNodeData = dataMap;
    }
    public static void setMultiNodeData(Map<String, Map<String,List<String>>> dataMap){
        multiNodeData = dataMap;
    }
    public static Map<String,String> getSingleNodeData(){
         return singleNodeData;
    }
    public static Map<String, Map<String,List<String>>> getMultiNodeData(){
        return multiNodeData;
    }
    

}