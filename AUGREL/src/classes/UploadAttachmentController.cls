public class UploadAttachmentController {
    
    private Case orgCase {get;set;} 
    public String fileName {get;set;}
    public Blob fileBody {get;set;}
    public Date strPrintedDate {get;set;}
    public String strStatus {get;set;}
    
    public UploadAttachmentController(ApexPages.StandardController controller) { 
        this.orgCase = (Case)controller.getRecord();
    }   
    
    // creates a new Title_Files__c record
    private Database.SaveResult saveCustomAttachment() {
        Title_Files__c obj = new Title_Files__c();
        obj.case__c = orgCase.Id; 
        obj.printed_date__c = strPrintedDate;
        obj.status__c = strStatus;
        // fill out cust obj fields
        return Database.insert(obj);
    }
    
    // create an actual Attachment record with the Title_Files__c as parent
    private Database.SaveResult saveStandardAttachment(Id parentId) {
        Database.SaveResult result;       
        Attachment attachment = new Attachment();
        attachment.body = this.fileBody;
        attachment.name = this.fileName;
        attachment.parentId = parentId;
        // insert the attachment
        result = Database.insert(attachment);
        // reset the file for the view state
        fileBody = Blob.valueOf(' ');
        return result;
    }
    
    /**
    * Upload process is:
    *  1. Insert new Title_Files__c record
    *  2. Insert new Attachment with the new Title_Files__c record as parent
    *  3. Update the Title_Files__c record with the ID of the new Attachment
    **/
    public PageReference processUpload() {
        try {
            Database.SaveResult customAttachmentResult = saveCustomAttachment();
        
            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));
                return null;
            }
        
            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());
        
            if (attachmentResult == null || !attachmentResult.isSuccess()) {
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                  'Could not save attachment.'));            
                return null;
            } else {
                // update the custom attachment record with some attachment info
                Title_Files__c customAttachment = [select id from Title_Files__c where id = :customAttachmentResult.getId()];
                customAttachment.name = this.fileName;
                customAttachment.Attachment__c = attachmentResult.getId();
                update customAttachment;
            }
        
        } catch (Exception e) {
            ApexPages.AddMessages(e);
            return null;
        }
        
        return new PageReference('/'+orgCase.Id);
    }
    
    public PageReference back() {
        return new PageReference('/'+orgCase.Id);
    }     

}