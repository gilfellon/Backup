public class NanaWallCLass 
{       
     public List<Projectwrapper> lstOpp{get;set;} 
    // Count The Project Won
        public integer ProjWon{get;set;}
    // Count The Project Order In Process
        public integer ProjOrderInProgress{get;set;}
    // Count The Project quote In Process
        public integer ProjQuoteInProgress{get;set;}
    // Count The Project Lost
        public integer ProjLost{get;set;}
    // Count The Project Duplicate
        public integer ProjDuplicate{get;set;}
    // Count The Project Closer Rate Percantage 
        public integer ProjClosureRate{get;set;}
    // Count The Project Amount Won
        public Decimal ProjAmountWon{get;set;}
    // Count The Project Amount in Process
        public Decimal ProjAmountOrderInProgress{get;set;}
    // Count The Project Won
        public Decimal ProjAmounQuoteInProgress{get;set;}
    // Count The Project Won
        public Decimal ProjAmountLost{get;set;}
    // Count The Project Total Amount
        public decimal ProjTotalAmount{get;set;}     
    
        // Latest Order Finalaize Date
        public list<order> latestOrderDate {get;set;}
       // Store all the data ragarding Account which have project except contact role 
        public Transient  list <project__c> AccountWithProjects{get;set;}
        // Account the number site on particular account
         public integer SiteCount {get;set;}
        // hold the value for the queotelss account
        public List<Opportunity> CAProjOppList{get;set;}
        // get run time id of the account 
        public id AccId{get;set;}
        //Pagination varibles and List
        public integer PaginationSize {get;set;}
        public integer NoOfRecords {get;set;}
        // record select options for pagination Account which does not have projects
        public List<selectoption> PaginationSizeOptions {get;set;}   
        
        
        /* wrapper class related varieble declaration    */
        
      // store opportunity realted to the  project__C to Find Opportunity Contact Role
        public list<opportunity> oppContactRole{get;set;} 
        
        // store contact role related to the project role
        public list<opportunityContactRole> ContactRole{get;set;} 
        
      
        
        
        // combine data project records and related to contact name  
    public transient list<Projectwrapper> WrapperCombineAllData {get;set;}
    
    // map hold project id and  related contact role  
    public map<id, list<opportunitycontactrole>> OppContRole {get;set;} 
    
    
     public list<opportunity>contactName {get;set;}
      public map<id,list<opportunitycontactrole>> NewoppData{get;set;}
      
      
      // For sorting varieble used in wrapper class
       public static String compareField {get; set;}
       public static String sortOrder{get; set;} 
    
    
    /*        Varible Declaration related to the Project Filtering        */
    /*                                                                   */
       public String AccountName{get;set;}

    public String ProjectName{get;set;}
    public String ProjectCity{get;set;}
    public String ProjectState{get;set;}
    public String ProjecctZipCode{get;set;}
    public String ProjectStage{get;set;}
    public String ProjectApplicationIndustry{get;set;}
    public String ProjectArchitectAcc{get;set;}
    public String ProjectInstalledAtAcc{get;set;}
    public String ProjectOrderingAcc{get;set;}

    // list to hold original vlaue when customer click on search option
    public map<id,list<Projectwrapper>> SearchProject{get;set;}
  
    // Store Account With Prpject data temoorerly
    public list<projectWrapper> SearchProj{get;set;}
     
    
    /* Varible inilization related to Account with Project Pagination */
    
     // Map stores all the records queried as per the pagenumber  
      
                Map<integer,List<Projectwrapper>> mapOpportunityPages = new Map<integer,List<Projectwrapper>>();   
     
        // Pagenumber  
                public integer intPageNumber{get;set;}  
   
   // total number of pages  
           public integer intNumberofPages{get;set;} 
    
    // Wrapper list which Display data on to the Visaulforrce page account with project section  
  
  public List<Projectwrapper> getLstOppRecords()
   
   {  
         lstOpp= new List<Projectwrapper>();  
        // List<Projectwrapper> lstOpp= new List<Projectwrapper>();  
         lstOpp.addAll(mapOpportunityPages.get(intPageNumber));  
       
         return lstOpp;  
   }  
    
       
  
       // Main class Constructor for all data inilization
        public  NanaWallCLass(ApexPages.StandardController setCon) 
        {
            AccId = ApexPages.currentPage().getParameters().get('id');
            
            // Inilize all summary Account Data to the Zero
            ProjWon =0;
            ProjOrderInProgress =0;
            ProjQuoteInProgress=0;
            ProjLost=0;
            ProjQuoteInProgress=0;            
            ProjDuplicate=0;
            ProjClosureRate=0;
            ProjAmountWon=0;
            ProjAmountOrderInProgress=0;
            ProjAmounQuoteInProgress=0;
            ProjAmountLost=0;
            ProjTotalAmount=0;
            
            
            // Varible Inilization related to the wrapper class
            
            oppContactRole = new list<opportunity>();
            OppContRole =new map<id, list<opportunitycontactrole>>();
            ContactRole = new list<opportunityContactRole>();
            WrapperCombineAllData = new list<projectWrapper>();
            contactName = new list<opportunity>();
            NewoppData = new  map<id,list<opportunitycontactrole>>();
     
            
           
            // Pagination Default Page Size 
            PaginationSize =10;
            // User Can select Pagination Size from this options
            paginationSizeOptions = new List<selectoption>();
            // Page size options on Account which does not have project
            paginationSizeOptions.add(new selectoption('25','25'));
            paginationSizeOptions.add(new selectoption('100','100'));
            paginationSizeOptions.add(new selectoption('150','150'));
            paginationSizeOptions.add(new selectoption('200','200'));
            paginationSizeOptions.add(new selectoption('250','250'));
            
            
            
            // Varieble Inilization Related to the Filtering Section 
            
            
        ProjectName= '';
        AccountName= '';
        ProjectCity= '';
        ProjectState= '';
        ProjecctZipCode= '';
        ProjectStage= '';
        ProjectApplicationIndustry= '';
        ProjectArchitectAcc= '';
        ProjectInstalledAtAcc= '';
        ProjectOrderingAcc= '';
        
            
            
            setPagination();
            
           
            
            
          
            
         SearchProject =new map<id,list<Projectwrapper>>();
       SearchProj = new list<projectwrapper>();
                    
           
        }
    
   public Pagereference setPagination() 
    {
        
                integer NumberofRecords = 0;  
                    integer pagenumber = 1;  
                     Integer counter = 1;
        
        // Count the total Site of the projects
            SiteCount=[select count() from account where parent.id =:accid];
            
            
             
            //get the latest order finalize Date from orders
            latestOrderDate  = [select Order_Finalized_Date__c, project__r.Purchaser_Account__c, account.id from order where project__r.Purchaser_Account__c=:AccId  AND Order_Finalized_Date__c!=null order By Order_Finalized_Date__c DESC LIMIT 1]; 
            
            // Fire Query on Project Object and get all related data except contact Role
               String query1 ='SELECT Id,(Select Id,Name,CreatedDate, Order_Finalized_Date__c From Orders__r), Architect_Contact__r.firstname,Name, Architect_Account__r.Name, Purchaser_Account__r.Name, Ordering_Account__r.Name, CreatedDate, RecordType.Name, Application__c, Amount__c, Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c,';
               query1+='Architect_Account__c,Ordering_Account__c, Brand_Name_Account__c, End_Customer_Account__c,End_Customer_Account__r.Name, Franchise_Account__c, Franchisor_Account__c, Other_Influencer_Account__c, Purchaser_Account__c, ';
               query1+='(Select Id, Name, AccountId,Project_Name__c, Opp_ContactRole__c from Opportunities__r where (StageName like \'%Won%\' OR StageName like \'%Complete%\' OR StageName like \'%Paid%\') AND (NOT StageName LIKE \'%Influencer%\'))';
               query1+=' FROM Project__c ';
               query1+=' WHERE (Architect_Account__c = :AccId OR Brand_Name_Account__c = :AccId OR End_Customer_Account__c = :AccId '; 
               query1+=' OR Franchise_Account__c = :AccId OR Franchisor_Account__c = :AccId OR Other_Influencer_Account__c = :AccId '; 
               query1+=' OR Purchaser_Account__c =:AccId OR Ordering_Account__c =:AccId ) ';
            
            //Assign Query REsults to the project List type Projects
             AccountWithProjects = database.query(query1);   
    
            
                 
     /*********QuoteLess Opprotunities *******************/
        CAProjOppList = [select id, name, stagename , Quote_Count__c,Project_Name__r.Name, Project_Name__r.Purchaser_Account__c,Project_Name__r.Architect_Account__c,Project_Name__r.CreatedDate,Project_Name__r.Bid_Date__c,Project_Name__r.Award_Date__c,Project_Name__r.Close_Date__c,Project_Name__r.Actual_Project_Need_Date__c,Project_Name__r.Amount__c,Project_Name__r.Estimated_Project_Need_Date__c  from opportunity where (stagename='Opportunity Created' ) AND Project_Name__r.Purchaser_Account__c =:AccId AND Quote_Count__c=0];
     /**********End Section *****************************/  
        
        
        
       
            
                for(project__C prj : AccountWithProjects)
        {
            
            oppContactRole.addAll(prj.opportunities__r);
            
            
        }
        
         contactName=[select id,name, project_name__c,(select contact.name,Opportunity.Project_Name__c from OpportunityContactRoles) from opportunity where id IN :oppContactRole];  
        
        system.debug('the value of opportunitycontactRole is' +ContactRole.size());        
            // store project id into the  project list
            
            for(opportunity  aa: contactName)
                
                {
                        NewoppData.put(aa.project_name__c, aa.OpportunityContactRoles);
                
                }  
        
        
        
        
        
    
                 for(Project__c proj: AccountWithProjects )
           
            
            {
            
                   
           
                   
                
            if(proj.Stage__c.contains('Project Lost') || proj.Stage__c.contains('Project Inactive') || proj.Stage__c.contains('Cancelled'))
                       
                       {
             
                               
                                   ProjLost= ProjLost+ 1; 
                                   if(proj.Amount__c!=NULL)
                                   {
                                    ProjAmountLost =ProjAmountLost + proj.Amount__c;
                                   }
              
                     } 
                
            
            
                     if(proj.Stage__c.contains('Duplicate'))
                     
                    {
                    
                            ProjDuplicate= ProjDuplicate+1;
                    
                    }   
            
            if (proj.Stage__c != null && (proj.Stage__c.contains('Project Won - Order Paid')))
               
                {
                    
                    ProjWon = ProjWon + 1;
                    ProjAmountWon= ProjAmountWon+ proj.Amount__c; 
                    
                    
                }
                
            if(proj.Stage__c.contains('Order Finalized') || proj.Stage__c.contains('Order Pending') || proj.Stage__c.contains('Project On Hold') && proj.Orders__r.size()>0)
              
                {
                          
                            ProjOrderInProgress = ProjOrderInProgress +1; 
                    
                        if(proj.Amount__c!=null)
                        {    
                    
                                ProjAmountOrderInProgress= ProjAmountOrderInProgress+ proj.Amount__c; 
                         }    
                }
                
                 /** Total Amount related to Amount (Quote In Progress)****/ 
          
          
            if(proj.Stage__c.contains('Quoted') || proj.Stage__c.contains('Prospecting') || proj.Stage__c.contains('Design') || proj.Stage__c.contains('Bidding') || proj.Stage__c.contains('Considered')|| proj.Stage__c.contains('Awarded') || (proj.Stage__c.contains('On Hold') && proj.Orders__r.size()==0))
          
            {
                
                ProjQuoteInProgress= ProjQuoteInProgress+ 1;
                
                if(proj.Amount__c!=NULL)
                {
                        ProjAmounQuoteInProgress= ProjAmounQuoteInProgress+ proj.Amount__c;
                }
          
           }
           
          
                 if(proj.Amount__c!=NULL)
                 {
                            ProjTotalAmount= ProjTotalAmount+ proj.Amount__c;
            
                 }
                
                if (NumberofRecords < 50) 
                {
                
                            if (NewoppData.containsKey(proj.id))
  
                            {
                           
                                    list<opportunitycontactrole> OCR = NewoppData.get(proj.id);

                            
                                         {
                                        
                                                Projectwrapper wrapper = new Projectwrapper(proj, OCR, counter);                                        
                                                this.WrapperCombineAllData.add(wrapper); 
                                                
                                         if (mapOpportunityPages.containsKey(pagenumber))
         
                                
                                                            {  
             
                                                                        mapOpportunityPages.get(pagenumber).add(new Projectwrapper(proj,NewoppData.get(proj.id),counter));  

                                                            }  
   
                                             else 
        
        
                                                           {  
        
                                                                    mapOpportunityPages.put(pagenumber,new List<Projectwrapper>{new Projectwrapper(proj,NewoppData.get(proj.id),counter)});    
            
                                                           }    
  
                                                counter++;
                                                                  
                                         }

                            }
            
               
                            else 
            
                
                                        {
                              
                                              Projectwrapper wrapper1 = new Projectwrapper(proj, NewoppData.get(proj.id),counter);
                                              this.WrapperCombineAllData.add(wrapper1);
                                              
                                              if (mapOpportunityPages.containsKey(pagenumber))
         
                                
                                                            {  
             
                                                                        mapOpportunityPages.get(pagenumber).add(new Projectwrapper(proj,NewoppData.get(proj.id),counter));  

                                                            }  
   
                                             else 
        
        
                                                           {  
        
                                                                    mapOpportunityPages.put(pagenumber,new List<Projectwrapper>{new Projectwrapper(proj,NewoppData.get(proj.id),counter)});    
            
                                                           }  
                                              
                                              
                                              
                                              
                                              counter++;
                                              

                              
                                        }
                                        
                      NumberofRecords++;  
                      
                      if (NumberofRecords == 50) 

                                        {  

                                                NumberofRecords = 0;  
                                                pagenumber++;  
                                        }  
                      
        
                                        
                   
                   }                     
                  
              
              
      }  
      
    intNumberofPages = mapOpportunityPages.size();  

    intPageNumber =1;  

    getLstOppRecords();   
     
            
    return null;
            
            
    
}
    
    integer Flag=0;
      /*  Funtions for Project Search and return result */
    
       public void ProjectSearch()
  
              {
                   
                    if(Flag==0)
                    {
                     SearchProj.addall(lstOpp); 
                     Flag++;
                     }      
                   
                       
                     lstOpp.clear();    
                 
                      
                     for(projectwrapper prj : SearchProj)
                     
                     {
                   

                     if(prj.pr.name.contains(ProjectName) )
          //  if(prj.pr.Project_City__c.contains(ProjectCity))
                     
                         {
                               system.debug('THE VALUE inside if  ASHOK ::::' + ProjectName);
                               lstOpp.add(prj);
                             
                         }
                     
                     
                     }
                      
                    
                     
                     
   
      
              }
     
     
      public void ProjectReset()
      
              {
                   
                
                 
                     lstOpp.addall(SearchProj);
                     
                     
                     
                     

              }
  
   
    
    
    
    public ApexPages.StandardSetController setCon 
    {
        get {
            if(setCon == null) {  
               // Account without project 
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [SELECT Account.Name FROM Account WHERE parent.id =:AccId AND Account.Id NOT IN (SELECT project__C.End_Customer_Account__c FROM project__c) ]));
                setCon.setPageSize(Paginationsize);  
                noOfRecords = setCon.getResultSize(); 
                return setcon;
                
            }            
            return setCon;
        }
        set;
    }
    //Changes the size of pagination account without pagination 
    public PageReference refreshPageSize() 
    {
         setCon.setPageSize(PaginationSize);
         return null;
    }
 
    // Initialize setCon and return a list of record    
     
    public List<account> getAccountsData()
    {
         return (List<Account>) setCon.getRecords();
    }
   
    // Account With Project Pagination Function 
    
    public Boolean hasNext 
   
   {  
        get 
        {  
                    if (intNumberofPages <= intPageNumber) 
        
            {  
                return false;  
            }  
      
      else 
            {  
        
                return true;  
            }  
     }  
     set;  
   }
   

   public Boolean hasPrevious 

   {  
        get 
     {  
            if (intPageNumber == 1) 
       {  
            return false;  
       }  
            else 
       {  
            return true;  
       }  
     }  
     set;  
   }  
   
   public void first() 
   {  
      intPageNumber = 1;  
      getLstOppRecords();  
   }  
   
   public void last() 
   
   {  
      intPageNumber=intNumberofPages;   
      getLstOppRecords();  
   }   
   
   public void previous() 
   
   {  
      intPageNumber--;  
      getLstOppRecords();  
   }  
    
    public void next() 
    
    {  
      intPageNumber++;  
      getLstOppRecords();  
    }  
   
    public void sortWrpLst()  
    {  
      lstOpp.sort();  
    }  

  
    
 
    
    
    
    public class Projectwrapper implements Comparable
    {
        
        public project__c pr{get;set;}
        public list<opportunitycontactrole> opp1{get;set;}
        public integer row {get;set;}
        public string name;
        public Projectwrapper( project__C GP, list<opportunitycontactrole> opp, integer rowcounter)
        {
            this.pr = GP;
            this.opp1 =opp;
            this.row = rowcounter; 
            this.name = gp.name;
        }
        
        public Integer compareTo(Object project)
        {
            Projectwrapper ProjectToCompare = (Projectwrapper) project;
            if((string)pr.get(compareField) > (string)ProjectToCompare.pr.get(compareField))  
         return sortOrder.equals('asc') ? 1 : 0;  
        else  
          return sortOrder.equals('asc') ? 0 : 1; 
            
        }
       
    }
    
  

}