@IsTest
public class Quote_AutoQuoteControllerTest {
    //public boolean getAutoQuoteViewEnabled;
    public boolean AutoClose;
    static testMethod void myUnitTest()
    {
    
      list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        
         Project__c p1 = new Project__c();
         p1.Name = 'Test Project CompetitorHelper_Test';
         p1.Application__c = 'Automotive';
         p1.Application_2__c = 'Dealership';
         p1.Stage__c = 'Considered';
         p1.Project_Zip_Code__c = '94040' ;
         insert p1;
        
        Account acct = new Account(Name='My Test Account1',BillingCity=' ', BillingCountry='United States', BillingPostalCode='12345', BillingState=' ', BillingStreet='y',ShippingCity=' ', ShippingCountry='United States', ShippingPostalCode='12345', ShippingState=' ', ShippingStreet='xy', Phone='5432167', Fax='444-5555');
        insert acct; 
         
         contact co=new contact();
         co.Accountid = acct.id;
         co.FirstName = 'john';
         co.LastName = 'CAD EMAIL RECIPIENT';
         co.MailingStreet = 'street';
         co.MailingCity = 'city'; 
         co.Mailingstate = 'Utah'; 
         co.MailingPostalCode = '12345';
         co.MailingCountryCode = 'US';
         co.Address_1__c='hyderabad';
         co.Address_2__c='hyder guda';
         co.AIA_Lunch_and_Learn__c=true;
         co.AssistantName='contact assistant';
         co.Birthdate=system.today();
         co.Fax='123456';
         co.Email='abc@abc.com';
         co.Phone='125869';
         co.Country__c='Aruba';
         insert co;

         Opportunity o = new Opportunity();
         o.Name = 'Test Opp CompetitorHelper_Test1';
         o.StageName = 'Need Analysis';
         o.CloseDate = Date.today();
         o.project_name__c = p1.id;
         o.Country__c = 'USA';
         o.Postal_Code__c = 'TEST';
         insert o;
      
         Quote__c q = new Quote__c();
         q.Name = 'Test Quote';
         q.Opportunity__c = o.Id;
         q.Primary_Quote__c=True;
         q.Project__c = p1.id;
         q.Shipping_Min__c = 12;
         insert q;
         System.debug('quote valueeeeeee'+q);
         
        PageReference pageRef = Page.Quote_AutoQuote;
        Test.setCurrentPage(pageRef);
         ApexPages.currentPage().getParameters().put('id',q.Id);
        ApexPages.currentPage().getParameters().put('QuoteID',q.Id);
            boolean AutoQuoteViewEnabled=false;
  Id id = ApexPages.currentPage().getParameters().get('id');
  
      Quote_AutoQuoteController qac = new Quote_AutoQuoteController();
      quote__c qd;
       qd = [SELECT id,Quote_ID__c, Contact__r.FirstName, Contact__r.LastName FROM Quote__c where id = :Apexpages.currentPage().getParameters().get('id')   ];
       System.debug('quote valueeeeeee after'+qd);
     //qac=q.id
      //qac.getAutoQuoteViewEnabled();
        
        
       // ApexPages.StandardController sc = new ApexPages.StandardController(q);
    //Quote_AutoQuoteController ac = new Quote_AutoQuoteController (sc);
        //qac.setAutoQuoteViewEnabled(true);
        //qac.LoadInitialState();
        //qac.TriggerAutoQuote();
        //qac.AutoClose=true;
        
    }
}