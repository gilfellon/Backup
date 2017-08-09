public class AccountDemo
  {
    
  // store records related to the project data
  public list<project__C> AllProjectData {get;set;}
  
  // store opportunity realted to the  project__C
    public list<opportunity> opp{get;set;} 
  
  // store contact role related to the project role
    public list<opportunityContactRole> ContactRole{get;set;} 
  
  // combine data project records and related to contact name  
    public list<Projectwrapper> WrapperCombineAllData {get;set;}
  
  
  // map hold project id and  related contact role  
    public map<id, list<opportunitycontactrole>> OppContRole {get;set;} 
  // store Account ID 
    public id  AccId {get;set;}
    // list for holding contact name
    public list<opportunity>contactName {get;set;}
      public map<id,list<opportunitycontactrole>> NewoppData{get;set;}
      
      
      
      // Accuunt With Project Pagination Section 
      
      // Map stores all the records queried as per the pagenumber   
   Map<integer,List<Projectwrapper>> mapOpportunityPages = new Map<integer,List<Projectwrapper>>();   
  
  // Pagenumber  
   public integer intPageNumber{get;set;}  

   // total number of pages  
    public integer intNumberofPages{get;set;}  
   
  
      
    
  
    public AccountDemo()
    {
        
        AccId = '001A000000ksAXI';
        AllProjectData= new list<project__C>();
        opp = new list<opportunity>();
        OppContRole =new map<id, list<opportunitycontactrole>>();
         ContactRole = new list<opportunityContactRole>();
         WrapperCombineAllData = new list<projectWrapper>();
        contactName = new list<opportunity>();
        NewoppData = new  map<id,list<opportunitycontactrole>>();
       
        
    }
    
   public Pagereference setPagination() 
    {
         
        integer NumberofRecords = 0;  
        integer pagenumber = 1; 
        
        // get records related to the projects
         AllProjectData=[select id,name,(select id, name ,Opp_ContactRole__c, project_name__c from opportunities__r where stagename ='Project Won - Order Paid' )  from project__c where (Purchaser_Account__c =: AccID OR End_Customer_Account__c=: AccID )];
         system.debug('THE value of allProjectData' +AllProjectData.size());
        
       // get related opportunity with project list and store into the opportunity list
       
        for(project__C prj : AllProjectData)
            
                {
            
                        opp.addAll(prj.opportunities__r);
            
                }
      
                
        system.debug('the value of opp is '+opp.size());
       
   
      
      contactName=[select id,name, project_name__c,(select contact.name,Opportunity.Project_Name__c from OpportunityContactRoles) from opportunity where id IN :opp];  
        // select contact.name, opportunity.name from opportunitycontactrole where opportunity.id= '006A000000VSP0i'
        system.debug('the value of opportunitycontactRole is' +ContactRole.size());        
    // store project id into the  project list
    for(opportunity  aa: contactName)
    {
        NewoppData.put(aa.project_name__c, aa.OpportunityContactRoles);
    }
    
    
        
        system.debug('The Size of Map is ' +ContactRole.size());
        integer i =0;
    
    // iterate over the Project Site list  and bind the project records with contactrole
        for(project__c prj : AllProjectData )
        {
          
        
             
            
                  if (NewoppData.containsKey(prj.id))
                
                            {
                                list<opportunitycontactrole> OCR = NewoppData.get(prj.id);
                                Projectwrapper wrapper = new Projectwrapper(prj, OCR);
                               this.WrapperCombineAllData.add(wrapper);
                                

                            }
            
                    else
            
                            {
                                  Projectwrapper wrapper1 = new Projectwrapper(prj, NewoppData.get(prj.id));
                                  this.WrapperCombineAllData.add(wrapper1);
                                  system.debug('The Value of the :::: Ashok' +WrapperCombineAllData.size()); 
                                  
                           }
              
              
            
          
        
        }
   
        
        return null;
       
    }    
      
      
  
      
      
 
     public class Projectwrapper
    {
        
        public project__c pr{get;set;}
        public list<opportunitycontactrole> opp1{get;set;}
        public Projectwrapper( project__C GP, list<opportunitycontactrole> opp)
        {
            this.pr = GP;
            this.opp1 =opp;
        }
       
    }

}