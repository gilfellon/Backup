@isTest(SeeAllData=false)
public class Task_PostUpdate_test {

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
        
     Task t = new Task();
        t.Subject = 'Send Booklet';
        t.PhotoBooks_Selection__c = 'Interior';
        t.WhoId = c.Id;
       // t.WhatId = o.Id;
        insert t;
        
            Contact c1 = new contact();
        c1.AccountId = a.Id;
        c1.FirstName='test';
        c1.LastName='test';
        c1.MailingCountryCode = 'US';
        c1.MailingPostalCode = '12345';
        insert c1;
        t.WhoId=c1.Id;
        
update t;
        
    }
    
}