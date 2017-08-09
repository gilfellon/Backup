public class Apex_demo {
    Public List<Project__c> ProjSiteList{get;set;}
    Public Integer ChildAccountCount{get;set;}
    Public List<Account> accList{get;set;}
    Public List<order> orderRecentDate{get;set;}
    Public ApexPages.StandardSetController controller{get;set;}
    Public Integer PrjWonOrderPaid{get;set;}
    Public Decimal PrjWonOrderPaid_Amount{get;set;}
    Public Integer PrjOrderProgress{get;set;}
    Public Decimal PrjOrderProgress_Amount{get;set;}
    Public Integer PrjQuoteProgress{get;set;}
    Public Decimal PrjQuoteProgress_Amount{get;set;}
    Public Integer PrjOrderLost{get;set;}
    Public Decimal PrjOrderLost_Amount{get;set;}
    Public Integer PrjDuplicate{get;set;}
    Public Decimal TotalAmount{get;set;}
    Public Integer ProjectListSize{get;set;}
    Public Integer ProjectCount{get;set;}
    public String acc_id{get;set;} 
    private Integer OffsetSize = 10;
    private Integer QueryLimit = 100;
    // Pagination Variable//
    Private Integer count=0;
    Private Integer LimitSize =100;
    //Contructor Defined //
    public Apex_demo(ApexPages.StandardSetController acon1)
    {
        acon1.setpagesize(20);
    }
    Public Apex_demo(ApexPages.StandardController con)
    {
        ProjSiteList = new List<Project__c>();
        orderRecentDate = new List<order>();
        acc_id = ApexPages.currentPage().getParameters().get('id');
        prjQuery();
        ChildAccountCount = [Select count() from Account where ParentId =: acc_id];
        ProjectCount = [Select count() from Project__c where Purchaser_Account__c =:acc_id];
        PrjWonOrderPaid = 0;
        PrjWonOrderPaid_Amount = 0;
        PrjOrderProgress = 0;
        PrjOrderProgress_Amount = 0;
        PrjQuoteProgress=0;
        PrjQuoteProgress_Amount = 0;
        PrjOrderLost= 0;
        PrjOrderLost_Amount = 0;
        PrjDuplicate = 0;
        TotalAmount = 0;
     
        ProjectListSize = ProjSiteList.size();
        SummarySection();
    }
    
     public void prjQuery()
   {
       ProjSiteList.clear();
      string ProjQuery = 'Select Name ,End_Customer_Account__c,End_Customer_Account__r.Name,Stage__c,Amount__c,';
             ProjQuery +='(Select Order_Finalized_Date__c From Orders__r Order By Order_Finalized_Date__c)';
             ProjQuery +=' FROM Project__c ';
             ProjQuery +=' where Purchaser_Account__c =: acc_id LIMIT 100 OFFSET : count ';
             ProjSiteList = database.query(ProjQuery); 
             System.debug('QueryStrin'+Acc_Id);
    //  ProjSiteList =[Select name,(Select Order_Finalized_Date__c From Orders__r Order By Order_Finalized_Date__c),End_Customer_Account__c,End_Customer_Account__r.Name,Stage__c,Amount__c from Project__c where Purchaser_Account__c =:accId]; 
             orderRecentDate = [Select Order_Finalized_Date__c From Order where (project__r.Purchaser_Account__c =: Acc_Id AND Order_Finalized_Date__c!=NUll)  Order By Order_Finalized_Date__c DESC Limit 1];

   }
    public void SummarySection()
   {
       for(Project__c projData : ProjSiteList)
       {
          if(projData.stage__c.contains('Closed Complete - Ordered - Paid') && projData.Stage__c != null )
          {
             PrjWonOrderPaid = PrjWonOrderPaid + 1;  
             PrjWonOrderPaid_Amount = PrjWonOrderPaid_Amount +  projData.Amount__c;
          }
          if(projData.Stage__c.contains('Closed Won - Order In Process') || projData.Stage__c.contains('Closed Won - Order Signed') || projData.Stage__c.contains('Order - Negotiation')|| projData.Stage__c.contains('Project On Hold'))
          {
              PrjOrderProgress = PrjOrderProgress + 1;
              if(projData.Amount__c != null)
              {
                PrjOrderProgress_Amount = PrjOrderProgress_Amount + projData.Amount__c;                  
              }
          }
          if(projData.Stage__c.contains('Quoted') || projData.Stage__c.contains('Prospecting')|| projData.Stage__c.contains('Design') || projData.Stage__c.contains('Bidding')|| projData.Stage__c.contains('Awarded') || projData.Stage__c.contains('Considered')|| projData.Stage__c.contains('On Hold')) 
          {
              PrjQuoteProgress = PrjQuoteProgress+1;
              if(projData.Amount__c != null)
              {
                  PrjQuoteProgress_Amount = PrjQuoteProgress_Amount + projData.Amount__c;
              }
          }
          if(projData.Stage__c.contains('Closed Lost - Project Lost') || projData.Stage__c.contains('Closed - Inactivity') || projData.Stage__c.contains('Cancelled'))
          {
              PrjOrderLost = PrjOrderLost+1;
              if(ProjData.Amount__c != null)
              {
                 PrjOrderLost_Amount = PrjOrderLost_Amount + projData.Amount__c; 
              }
          }
          if(projData.Stage__c.contains('Duplicate'))
          {
                    PrjDuplicate = PrjDuplicate +1;
          }
           
       }
       TotalAmount = PrjOrderLost_Amount + PrjQuoteProgress_Amount + PrjOrderProgress_Amount + PrjWonOrderPaid_Amount;
   }
   public PageReference Nextbtn()
   {
       count = count+LimitSize;
       prjQuery();
       return null;
   }
   public Boolean getNext()
   {
       if((count+LimitSize)>ProjectCount)
       {
           return true;
       }
       else
       {
           return false;
       }
   }
  public PageReference Previousbtn()
  {
      count = count - LimitSize;
      prjQuery();
      return null;
  }
    public Boolean getPrevious()
    {
        if(count==0)
        {
            return true;
        }
        else
            return false;
    }
}