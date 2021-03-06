@isTest(SeeAllData = false)
public class ShopifyCustomerCreation_Test {
    static testMethod void testDoPost() {

        //Insert test data  
        list < Zip_Codes_Master__c > lstzipCode = TestDataUtility.getTerritoryMaster();
        insert lstzipCode;

        Account a = new Account();
        a.Name = 'Test Account';
        a.Phone = '(123) 456-7890';
        a.Name = 'Test account';
        a.BillingState = 'New York';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.BillingStreet = 'xyz street';
        a.BillingCity = 'new va';
        a.ShippingState = 'New York';
        a.ShippingCountryCode = 'US';
        a.ShippingPostalCode = '12345';
        a.ShippingStreet = 'xyz street';
        a.ShippingCity = 'new va';
        insert a;

        contact con = new contact();
        con.FirstName = 'foo';
        con.LastName = 'CAD EMAIL RECIPIENT';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.email = 'test@gmail.com';
        con.accountid = a.id;
        insert con;

        case c = new
        case ();
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Priority = 'Medium';
        c.Send_Quote_To__c = 'End Customer';
        c.Ship_To__c = 'End Customer';
        c.Bill_To__c = 'End Customer';
        c.Contactid = con.id;
        c.Caller_contact__c = con.id;
        insert c;

        case cc = [select id, CaseNumber from
            case where id = :
                c.id
        ];
        Service_Quote__c sq = new Service_Quote__c();
        sq.Discount__c = 10;
        sq.Case__c = c.id;
        sq.shopify__c = true;
        sq.recordtypeid = Schema.SObjectType.Service_Quote__c.getRecordTypeInfosByName().get('Shopify Service Quote').getRecordTypeId();
        sq.Status__c = 'Order Created';
        sq.Shopify_ID__c = '2853431619';
        sq.Total_Amount__c = 569;
        insert sq;
        test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_CustomerCreate());

        HttpResponse res = CalloutClass_ShopifyBatch.getInfoFromExternalService();
        ShopifyCustomerCreation.CustomerCreation(c.id);


        test.stopTest();
    }

    static testMethod void testDoPost2() {

        //Insert test data
        list < Zip_Codes_Master__c > lstzipCode = TestDataUtility.getTerritoryMaster();
        insert lstzipCode;

        Account a = new Account();
        a.Name = 'Test Account';
        a.Phone = '(123) 456-7890';
        a.Name = 'Test account';
        a.BillingState = 'New York';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.BillingStreet = 'xyz street';
        a.BillingCity = 'new va';

        insert a;

        contact con = new contact();
        con.FirstName = 'foo';
        con.LastName = 'CAD EMAIL RECIPIENT';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.email = 'test@gmail.com';
        con.accountid = a.id;
        insert con;

        case c = new
        case ();
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Priority = 'Medium';
        c.Send_Quote_To__c = 'Caller Contact';
        c.Ship_To__c = 'Caller Contact';
        c.Bill_To__c = 'Caller Contact';
        c.Contactid = con.id;
        c.Caller_contact__c = con.id;
        insert c;

        case cc = [select id, CaseNumber from
            case where id = :
                c.id
        ];
        Service_Quote__c sq = new Service_Quote__c();
        sq.Discount__c = 10;
        sq.Case__c = c.id;
        sq.shopify__c = true;
        sq.recordtypeid = Schema.SObjectType.Service_Quote__c.getRecordTypeInfosByName().get('Shopify Service Quote').getRecordTypeId();
        sq.Status__c = 'Order Created';
        sq.Shopify_ID__c = '2853431619';
        sq.Total_Amount__c = 569;
        insert sq;
        test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_CustomerCreate());

        HttpResponse res = CalloutClass_ShopifyBatch.getInfoFromExternalService();
        ShopifyCustomerCreation.CustomerCreation(c.id);


        test.stopTest();
    }

    static testMethod void testDoPost3() {

        //Insert Test data
        list < Zip_Codes_Master__c > lstzipCode = TestDataUtility.getTerritoryMaster();
        insert lstzipCode;

        Account a = new Account();
        a.Name = 'Test Account';
        a.Phone = '(123) 456-7890';
        a.Name = 'Test account';
        a.BillingState = 'New York';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.BillingStreet = 'xyz street';
        a.BillingCity = 'new va';

        insert a;

        contact con = new contact();
        con.FirstName = 'foo';
        con.LastName = 'CAD EMAIL RECIPIENT';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.email = 'test@gmail.com';
        con.accountid = a.id;
        insert con;

        Project__c p = new Project__c();
        p.RecordTypeId = Schema.SObjectType.Project__c.getRecordTypeInfosByName().get('Residential Project').getRecordTypeId();
        p.Name = 'xyz enterprise';
        p.Project_Zip_Code__c = '12345';
        p.Project_Country__c = 'United States';
        p.Close_Date__c = system.today();
        p.Project_State__c = ' ';
        p.Application__c = 'Automotive';
        p.Application_2__c = 'Dealership';
        insert p;

        /*list<Opportunity> olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].AccountId = a.Id ;
            olstOpportunity[0].Project_Name__c = p.Id;
            insert olstOpportunity;
            
           Quote__c q = new Quote__c();
          q.Name = 'Test Quote';
          q.Opportunity__c = olstOpportunity[0].Id;
          q.Primary_Quote__c=True; 
          insert q;*/

        order ord = new order();
        ord.Accountid = a.id;
        ord.EffectiveDate = system.today();
        ord.Project__c = p.id;
        ord.Status = 'Draft';
       // insert ord;

        case c = new
        case ();
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Priority = 'Medium';
        c.Send_Quote_To__c = 'Caller Contact';
        c.Ship_To__c = 'Project Site';
        c.Bill_To__c = 'Project Site';
        c.Contactid = con.id;
        c.Caller_contact__c = con.id;
       // c.Order__c = ord.id;
        insert c;

        case cc = [select id, CaseNumber from
            case where id = :
                c.id
        ];
        Service_Quote__c sq = new Service_Quote__c();
        sq.Discount__c = 10;
        sq.Case__c = c.id;
        sq.shopify__c = true;
        sq.recordtypeid = Schema.SObjectType.Service_Quote__c.getRecordTypeInfosByName().get('Shopify Service Quote').getRecordTypeId();
        sq.Status__c = 'Order Created';
        sq.Shopify_ID__c = '2853431619';
        sq.Total_Amount__c = 569;
        insert sq;
        test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_CustomerCreate());

        HttpResponse res = CalloutClass_ShopifyBatch.getInfoFromExternalService();
        ShopifyCustomerCreation.CustomerCreation(c.id);


        test.stopTest();
    }

    static testMethod void testDoPost4() {

        //Insert test data
        list < Zip_Codes_Master__c > lstzipCode = TestDataUtility.getTerritoryMaster();
        insert lstzipCode;

        Account a = new Account();
        a.Name = 'Test Account';
        a.Phone = '(123) 456-7890';
        a.Name = 'Test account';
        a.BillingState = 'New York';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.BillingStreet = 'xyz street';
        a.BillingCity = 'new va';
        a.ShippingState = 'New York';
        a.ShippingCountryCode = 'US';
        a.ShippingPostalCode = '12345';
        a.ShippingStreet = 'xyz street';
        a.ShippingCity = 'new va';

        insert a;

        contact con = new contact();
        con.FirstName = 'foo';
        con.LastName = 'CAD EMAIL RECIPIENT';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.email = 'test@gmail.com';
        con.Mailingstate = 'New York';
        con.accountid = a.id;
        insert con;

        Project__c p = new Project__c();
        p.RecordTypeId = Schema.SObjectType.Project__c.getRecordTypeInfosByName().get('Residential Project').getRecordTypeId();
        p.Name = 'xyz enterprise';
        p.Project_Zip_Code__c = '12345';
        p.Project_Country__c = 'United States';
        p.Close_Date__c = system.today();
        p.Project_State__c = ' ';
        p.Application__c = 'Automotive';
        p.Application_2__c = 'Dealership';
        insert p;

        /*list<Opportunity> olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].AccountId = a.Id ;
            olstOpportunity[0].Project_Name__c = p.Id;
            insert olstOpportunity;
            
           Quote__c q = new Quote__c();
          q.Name = 'Test Quote';
          q.Opportunity__c = olstOpportunity[0].Id;
          q.Primary_Quote__c=True; 
          insert q;*/

        order ord = new order();
        ord.Accountid = a.id;
        ord.EffectiveDate = system.today();
        ord.Project__c = p.id;
        ord.Status = 'Draft';
       // insert ord;
       Database.insert(ord,false);
        case c = new
        case ();
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Priority = 'Medium';
        c.Send_Quote_To__c = 'Caller Contact';
        c.Ship_To__c = 'Caller Contact';
        c.Bill_To__c = 'Caller Contact';
        c.Contactid = con.id;
        c.Caller_contact__c = con.id;
        c.Order__c = ord.id;
        insert c;

        case cc = [select id, CaseNumber from case where id = : c.id];
        Service_Quote__c sq = new Service_Quote__c();
        sq.Discount__c = 10;
        sq.Case__c = c.id;
        sq.shopify__c = true;
        sq.recordtypeid = Schema.SObjectType.Service_Quote__c.getRecordTypeInfosByName().get('Shopify Service Quote').getRecordTypeId();
        sq.Status__c = 'Order Created';
        sq.Shopify_ID__c = '2853431619';
        sq.Total_Amount__c = 569;
        insert sq;
        test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_CustomerCreate());

        HttpResponse res = CalloutClass_ShopifyBatch.getInfoFromExternalService();
        ShopifyCustomerCreation.CustomerCreation(c.id);


        test.stopTest();
    }
       static testMethod void testDoPost5() {

        //Insert test data
        list < Zip_Codes_Master__c > lstzipCode = TestDataUtility.getTerritoryMaster();
        insert lstzipCode;

        Account a = new Account();
        a.Name = 'Test Account';
        a.Phone = '(123) 456-7890';
        a.Name = 'Test account';
        a.BillingState = 'New York';
        a.BillingCountryCode = 'US';
        a.BillingPostalCode = '12345';
        a.BillingStreet = 'xyz street';
        a.BillingCity = 'new va';
        a.ShippingState = 'New York';
        a.ShippingCountryCode = 'US';
        a.ShippingPostalCode = '12345';
        a.ShippingStreet = 'xyz street';
        a.ShippingCity = 'new va';

        insert a;

        contact con = new contact();
        con.FirstName = 'foo';
        con.LastName = 'CAD EMAIL RECIPIENT';
        con.MailingStreet = 'street';
        con.MailingCity = 'city';
        con.MailingPostalCode = '12345';
        con.MailingCountryCode = 'US';
        con.email = 'test@gmail.com';
        con.Mailingstate = 'New York';
        con.accountid = a.id;
        insert con;

        Project__c p = new Project__c();
        p.RecordTypeId = Schema.SObjectType.Project__c.getRecordTypeInfosByName().get('Residential Project').getRecordTypeId();
        p.Name = 'xyz enterprise';
        p.Project_Zip_Code__c = '12345';
        p.Project_Country__c = 'United States';
        p.Close_Date__c = system.today();
        p.Project_State__c = ' ';
        p.Application__c = 'Automotive';
        p.Application_2__c = 'Dealership';
        insert p;

        /*list<Opportunity> olstOpportunity = TestDataUtility.createOppTestData();
            olstOpportunity[0].AccountId = a.Id ;
            olstOpportunity[0].Project_Name__c = p.Id;
            insert olstOpportunity;
            
           Quote__c q = new Quote__c();
          q.Name = 'Test Quote';
          q.Opportunity__c = olstOpportunity[0].Id;
          q.Primary_Quote__c=True; 
          insert q;*/

        order ord = new order();
        ord.Accountid = a.id;
        ord.EffectiveDate = system.today();
        ord.Project__c = p.id;
        ord.Status = 'Draft';
       // insert ord;
       Database.insert(ord,false);

        case c = new
        case ();
        c.Origin = 'Phone';
        c.Status = 'New';
        c.Priority = 'Medium';
        c.Send_Quote_To__c = 'other';
        c.Ship_To__c = 'other';
        c.Bill_To__c = 'other';
        c.Contactid = con.id;
        c.Caller_contact__c = con.id;
        c.Order__c = ord.id;
        insert c;

        case cc = [select id, CaseNumber from case where id = : c.id];
        Service_Quote__c sq = new Service_Quote__c();
        sq.Discount__c = 10;
        sq.Case__c = c.id;
        sq.shopify__c = true;
        sq.recordtypeid = Schema.SObjectType.Service_Quote__c.getRecordTypeInfosByName().get('Shopify Service Quote').getRecordTypeId();
        sq.Status__c = 'Order Created';
        sq.Shopify_ID__c = '2853431619';
        sq.Total_Amount__c = 569;
        insert sq;
        test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_CustomerCreate());

        HttpResponse res = CalloutClass_ShopifyBatch.getInfoFromExternalService();
        ShopifyCustomerCreation.CustomerCreation(c.id);


        test.stopTest();
    }
    
}