Public class HierarchyController3 {
        
    public List <Account> AccSiteList{get;set;}
    public List <Account> AccSiteList2nd{get;set;}
    public Account ObjAcc{get;set;}    
    public List <List<Project__c>> ProjSiteList{get;set;}
    public Integer prjWon {get;set;}
    public Integer siz {get;set;}
    public Integer psiz {get;set;}
    public String rltype {get;set;}
    public Account AccRelatedList{get;set;}  
    public Hierarchy [] ProjectList{get;set;}
    public Double amountWon{get;set;}
    public Double totalAmount{get;set;}
    private String sortDirection = 'ASC';
    private String sortExp = 'AccName';
    public List<String> acclist;
    public Map <String,Hierarchy> accmap;    
    public List<String> prjlist;
    public Map <String,Hierarchy> prjmap;
    public List<String> prjsts;
    public Map <String,Hierarchy> stsmap;
    public List<Decimal> amtlst;
    public Map <Decimal,Hierarchy> amtmap;
    public LIST<Order> ordList{get;set;}
    public LIST<Contact> contrls{get;set;}
    public LIST<Project__c> prjList2{get;set;}
    public LIST<Opportunity> oppList2{get;set;}
    
    public HierarchyController3(ApexPages.StandardController con){
        
        AccSiteList = new List <Account>();
        ordList = new LIST<Order>();
        contrls = new List<Contact>();
        prjList2 = new List<Project__c>();
        oppList2 = new List<Opportunity>();
        amtlst = new List<Decimal>();
        amtmap = new Map<Decimal,Hierarchy>();    
        prjsts = new List<String>();
        stsmap = new Map<String,Hierarchy>();    
        acclist = new List<String>();
        accmap = new Map<String,Hierarchy>();    
        prjlist = new List<String>();
        prjmap = new Map<String,Hierarchy>();    
        AccRelatedList = new Account();
        ProjSiteList = new List<List<Project__c>>();
        ProjectList = new List<Hierarchy>();
        objAcc = (Account)con.getRecord();
        totalAmount = 0.0;
        amountWon = 0.0;
        siz = 0;
        psiz = 0;
        prjWon = 0;    
            
        //AccSiteList = [Select Name, Id, Type, (Select Name,Architect_Account__r.Name, Ordering_Account__c,Ordering_Account__r.Name, Amount__c,Application__c,RecordType.Name,Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c,Id, Architect_Account__c, Purchaser_Account__c, Purchaser_Account__r.Name from Projects__r Order by Amount__c desc Nulls last),(Select Name, Id, Ordering_Account__c, Amount__c,Application__c,RecordType.Name,Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c, Architect_Account__c, Purchaser_Account__c from Projects4__r),(Select Name, Id, Ordering_Account__c, Amount__c,Application__c,RecordType.Name,Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c, Architect_Account__c, Purchaser_Account__c from Projects__r),(Select Name, Id, Ordering_Account__c, Amount__c,Application__c,RecordType.Name,Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c, Architect_Account__c, Purchaser_Account__c from Projects5__r) from Account where Parent.Id = :string.valueOf(ObjAcc.Id).left(15)];
    
                /*AccSiteList = [Select Name, Id, Type, (Select Name,Architect_Account__r.Name, Ordering_Account__c,
                                                       Ordering_Account__r.Name, Amount__c,Application__c,RecordType.Name,
                                                       Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c,Id,
                                                       Architect_Account__c, Purchaser_Account__c, 
                                                       Purchaser_Account__r.Name from Projects1__r ) FROM Account WHERE Parent.Id = :string.valueOf(objAcc.Id).left(15)  ];
                       //        FROM Account WHERE Parent.ID =: ObjAcc.ID ];Ultimate_ParentId__c = :string.valueOf(objAcc.Id).left(15) OROR ID=:objAcc.Id
//                                                       where  id=:string.valueOf(ObjAcc.Id).left(15)]; 
               /* 
                AccSiteList2nd = [Select Name, Id, Type, (Select Name,Architect_Account__r.Name, Ordering_Account__c,
                                                       Ordering_Account__r.Name, Amount__c,Application__c,RecordType.Name,
                                                       Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c,Id,
                                                       Architect_Account__c, Purchaser_Account__c, 
                                                       Purchaser_Account__r.Name from Projects__r where  Architect_Account__c = :objAcc.Id OR Brand_Name_Account__c = :objAcc.Id OR End_Customer_Account__c = :objAcc.Id 
                       OR Franchise_Account__c = :objAcc.Id OR Franchisor_Account__c = :objAcc.Id OR Other_Influencer_Account__c = :objAcc.Id 
                       OR Purchaser_Account__c =:objAcc.Id  ) from Account where Id = :string.valueOf(ObjAcc.Id).left(15) limit 100];  */
                                  //where Ultimate_ParentId__c = :string.valueOf(objAcc.Id).left(15)];
                                  //ID =:objAcc.Id];
                                  //  where Id = :string.valueOf(ObjAcc.Id).left(15)]; 
                                  
       AccSiteList = [Select Name, Id, Type, (Select Name,Architect_Account__r.Name, Ordering_Account__c,
                                                       Ordering_Account__r.Name, Amount__c,Application__c,RecordType.Name,
                                                       Stage__c, Project_City__c, Project_State__c, Project_Zip_Code__c,Id,
                                                       Architect_Account__c, Purchaser_Account__c, 
                                                       Purchaser_Account__r.Name from Projects1__r ) from Account 
                                                       where Parent.Id = :string.valueOf(ObjAcc.Id).left(15) OR id=:string.valueOf(ObjAcc.Id).left(15)];                            
                                  System.debug(' AccSiteList ::: '+AccSiteList.size());
                String prevAcc ='';
            
            for (Account ac : AccSiteList)
            {
                                                 
                psiz = ProjectList.size()-1;
                
                if(ac.Projects__r.size()==0)
                    
                    {
                       
                    Hierarchy hier = new Hierarchy();
                
                     hier.accountName = ac;
                
                    acclist.add(ac.Name);
                
                       accmap.put(ac.Name, hier);    
                
                    ProjectList.add(hier);
                }
                    
        else
        {
     
            for (List<Project__c> prjs: ac.Projects__r)
            
            {
                    
                  siz+=prjs.size();           
                             
                 for(Project__c prj : prjs)
                     { 
 
                       Hierarchy hier = new Hierarchy(prj.Architect_Account__c, prj.Purchaser_Account__c,
                                                            prj.Ordering_Account__c);

                       ordList = [Select Name,Id, Order_Finalized_Date__c, Project__r.Id from Order
                                        where Project__r.Id =:prj.Id]; 
               
                       prjList2 = [Select Id, (Select Name, Id, StageName from Opportunities__r where
                                                     StageName like '%Won%' )                          
                                   from Project__c where Id =:prj.Id];
               
               for (Project__c prj2 : prjList2)
               
               for (List<Opportunity> oppList : prj2.Opportunities__r)
               {
                   
                   for (Opportunity opp : oppList)
                   {
                                
                        oppList2 = [Select Id, Name, (Select Contact.Name, ContactId from OpportunityContactRoles ) 
                                    from Opportunity where Id =: opp.Id ];
                   }    
               }
               
               for (Opportunity op : oppList2)
               {
                   
                   for(List<OpportunityContactRole> ocrs : op.OpportunityContactRoles)
                   {
                       
                       for(OpportunityContactRole ocr : ocrs )
                       
                       hier.ocr.add(ocr); 
                   }
               }               
               
               System.debug('hier.ocr: '+hier.ocr);
               
               for (Order od : ordList)
                   { 
                        hier.ordFnzDt.add(od.Order_Finalized_Date__c);
                    }

                        hier.accountName = ac;
                        hier.projectName = prj;
                        hier.architect.Name = prj.Architect_Account__r.Name;
                        hier.purchaser.Name = prj.Purchaser_Account__r.Name;
                        hier.orderingAccount.Name = prj.Ordering_Account__r.Name;    
                        hier.amount = prj.Amount__c;
                        hier.status = prj.Stage__c;
                        hier.projectCity = prj.Project_City__c;
                        hier.projectState = prj.Project_State__c;
                        hier.projectZipCode = prj.Project_Zip_Code__c;
                        hier.applicationIndustry = prj.Application__c;
                        prjlist.add(prj.Name);
                        prjsts.add(prj.Stage__c + prj.Id);
                        amtlst.add(prj.Amount__c);
                        acclist.add(ac.Name);
                        accmap.put(ac.Name, hier);
                        prjmap.put(prj.Name, hier);
                        stsmap.put(prj.Stage__c+ prj.Id,hier);
                        amtmap.put(prj.Amount__c, hier);
                                
                       if (prj.Stage__c != null && (prj.Stage__c.contains('Closed Won') || prj.Stage__c.contains('Closed Complete')))
                       {
                            
                            amountWon = amountWon + prj.Amount__c;
                            prjWon = prjWon + 1;
                        }
                        
                        if(prj.Amount__c!=null)
                        
                        totalAmount = totalAmount + prj.Amount__c;
                        
                        ProjectList.add(hier);
                        
                        prevAcc = hier.accountName.Name;
                     }
                  }
               }
          }
     }
    
    public class Hierarchy {
        
        public Account accountName{get;set;}
        public Project__c projectName{get;set;}
        public Double amount{get;set;}
        public String status{get;set;}
        public Account endCustomer{get;set;}
        public Account purchaser{get;set;}
        public Account orderingAccount{get;set;}
        public Account architect{get;set;}
        public String projectCity{get;set;}
        public String projectState{get;set;}
        public String projectZipCode{get;set;}
        public String applicationIndustry{get;set;}
        public List<Date> ordFnzDt {get;set;}
        public List<OpportunityContactRole> ocr {get;set;}
        
        public Hierarchy()
        {
            
                        ordFnzDt = new List<Date>();
                        ocr = new List<OpportunityContactRole>();            
        }
        
        public Hierarchy(Id arch, Id purch, Id ordr)
        {            
            ordFnzDt = new List<Date>();
            ocr = new List<OpportunityContactRole>();
            this.architect = new Account();
            this.architect.Id = arch;
            this.purchaser = new Account();
            this.purchaser.Id = purch;
            this.orderingAccount = new Account();
            this.orderingAccount.Id = ordr;
        }
    }

    public String sortExpression {

             get { return sortExp; }

             set { //if the column is clicked on then switch between Ascending and Descending modes

               if (value == sortExp) 
                   
                   sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';

               else sortDirection = 'ASC';

               sortExp = value;
           }
       }

        public String getSortDirection() 
        {  
            //if not column is selected

            if (sortExpression == null || sortExpression == '') 
                    return 'ASC';

            else return sortDirection;

         }

         public void setSortDirection(String value) 
         { 

               sortDirection = value;
         }

        public PageReference ViewData()
        {

          string sortFullExp = sortExpression  + ' ' + sortDirection;  

          if(sortExp.equalsIgnoreCase('AccName')) sortData('AccName');
        
          else if (sortExp.equalsIgnoreCase('PrjName')) sortData('PrjName');
            
          else if (sortExp.equalsIgnoreCase('Amount')) sortData('Amount');
            
          else if (sortExp.equalsIgnoreCase('Stage')) sortData('PrjStatus');    
            
          return null;
     }

        public void sortData(String str)
        { 
            
            if (str.equalsIgnoreCase('Amount'))
            {

                amtlst.sort();
                
                List<Hierarchy> amtlist = new List<Hierarchy>();
                
                for (Decimal s : amtlst)
                {
                    
                     amtlist.add(amtmap.get(s));
                }
                    
                if(sortDirection.equalsIgnoreCase('ASC'))
                
                ProjectList = amtlist;
             
                else if (sortDirection.equalsIgnoreCase('DESC'))
                {
                
                for(Integer i = ProjectList.size()-1, j=0;i >=0; i--)
                    
                 ProjectList.set(i,amtlist.get(j++));
             }
          }

            if (str.equalsIgnoreCase('AccName'))
            {
                    
                acclist.sort();
                
                List<Hierarchy> hrlist = new List<Hierarchy>();
                
                for (String s : acclist)
                {
                    
                     hrlist.add(accmap.get(s));
                }
                    
                if(sortDirection.equalsIgnoreCase('ASC'))
                
                ProjectList = hrlist;
             
                else if (sortDirection.equalsIgnoreCase('DESC'))
                {
                
                  for(Integer i = ProjectList.size()-1, j=0;i >=0; i--)
                    
                    ProjectList.set(i,hrlist.get(j++));
                }
         }
            
                if (str.equalsIgnoreCase('PrjName'))
                {
                    
                    prjlist.sort();
                
                   List<Hierarchy> prlist = new List<Hierarchy>();
                
                    for (String s : prjlist)
                     {
                    
                       prlist.add(prjmap.get(s));
                    }
                    
                if(sortDirection.equalsIgnoreCase('ASC'))
                
                ProjectList = prlist;
             
                else if (sortDirection.equalsIgnoreCase('DESC'))
                {
                
                  for(Integer i = ProjectList.size()-1, j=0;i >=0; i--)
                    
                    ProjectList.set(i,prlist.get(j++));
                }
         }
        }
}