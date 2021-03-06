public class multiAttachment_newController {
    public Id sobjId {get; set;}
    // list of existing files - populated on demand
    public List<ContentVersion> files;
    public ContentVersion cc{get; set;}
    // list of new files to add
    public List<ContentVersion> newfiles {get; set;}
    public list<Installation__c> childinst;
    
    public static final Integer NUM_FILES_TO_ADD=9;
    public multiAttachment_newController(){
        // instantiate the list with a single file
        newfiles=new List<ContentVersion>{new ContentVersion(),new ContentVersion(),new ContentVersion(),new ContentVersion(),
            new ContentVersion(),new ContentVersion(),new ContentVersion(),new ContentVersion(),new ContentVersion(),new ContentVersion()};
            
    }
    public void SaveFiles()
    {
        
        List<ContentVersion> toInsert=new List<ContentVersion>();
        List <FeedItem> FeedItemContentList = new List <FeedItem> () ;
        List <FeedItem> FeedItemList = new List <FeedItem>();
        for (ContentVersion newf : newFiles)
        {
           System.debug('versionData'+newf.VersionData);
            if (newf.versionData!=null)
            {
                newf.pathOnClient = newf.Title;
                //newf.parentId=sobjId;
                toInsert.add(newf);
            }
        }
        if(toInsert.size() > 0){
        insert toInsert;
            childinst = [select id,name from installation__c where project__c =:sobjId];
            for(ContentVersion c: toInsert){
                    System.debug('is it equal?');
                    //Attaching FeedItem to ContentVersion
                    FeedItem elm = new FeedItem(Body = 'Post with related document body', ParentId = sobjId, RelatedRecordId = c.ID, Type = 'ContentPost');
                    FeedItemContentList.add(elm);
                    //Attaching Files of type 'Drawings' to Installations under the Project
                    if(childinst.size() > 0 && c.Type_of_File__c == 'Drawings'){
                        for(Installation__c inst:childinst){
                            FeedItem e = new FeedItem(Body = 'Post with related document body', ParentId = inst.Id, RelatedRecordId = c.ID, Type = 'ContentPost');
                            FeedItemList.add(e);
                        }
                    }
                    
                }
            insert FeedItemContentList;
            if(FeedItemList.size() > 0){
                insert FeedItemList;
            }
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO, toInsert.size() + ' file(s) uploaded successfully'));
        }
        else{
         ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.ERROR,'Please select at-least one file'));  
        }
        newFiles.clear();
        for (Integer idx=0; idx<=NUM_FILES_TO_ADD; idx++){
        newFiles.add(new ContentVersion());
        }
        // null the list of existing files - this will be rebuilt when the page is refreshed
        files=null;
    }
    public Pagereference goBack()
    {
        PageReference nextPage = new PageReference('/' + sObjId);
        return nextPage;
    }
    
}