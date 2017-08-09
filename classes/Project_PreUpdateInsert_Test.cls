@isTest(SeeAllData=false)
public class Project_PreUpdateInsert_Test {

    static testmethod void method1(){
    
     
        
         User testUser1 = TestDataUtility.createUser('System Administrator','test@testingupdate.com');
        insert testUser1;
        
         list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
    
        
        Account a = new Account();
        a.Name='test';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.Chain_Account__c = false;
        a.OwnerId = testUser1.id;
        insert a;
        
        Contact c = new contact();
        c.AccountId = a.Id;
        c.FirstName='test';
        c.LastName='test';
        c.MailingCountryCode = 'US';
        c.MailingPostalCode = '12345';
        insert c;
        
         Project__c p1 = new Project__c();
         p1.Name = 'Test Project CompetitorHelper_Test';
         p1.Application__c = 'Automotive';
         p1.Application_2__c = 'Dealership';
         p1.Stage__c = 'Considered';
         p1.Project_Zip_Code__c = '94040' ;
         insert p1;
        

             Opportunity o = new Opportunity();
         o.Name = 'Test Opp CompetitorHelper_Test1';
         o.StageName = 'Need Analysis';
         o.CloseDate = Date.today();
             o.AccountId=a.Id;
         o.project_name__c = p1.id;
         o.Country__c = 'US';
         o.Postal_Code__c = '12345';
         insert o;
       
        
        o.Amount=100;
        update o;
        
           set < id > ids = new set < id > ();
        ids.add(o.Id);
        
          Opportunity_UtilityClass.SetIn2CloudsScore(new list < id > (ids));
        
    }

}