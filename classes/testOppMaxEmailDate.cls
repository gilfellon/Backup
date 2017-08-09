@isTest
public class testOppMaxEmailDate {
    static testmethod void method1(){
    list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
            insert tmList;
        insert new Run_Batch_Class__c(Name = 'Execute Batch',Execute_batch_Class__c = true);
        insert new Opp_Max_Email_Date__c(Name = 'Residential Opportunity',Number_of_Days__c = 90,Record_type_Id__c = '');
        insert new Opp_Max_Email_Date__c(Name = 'Commercial Opportunity',Number_of_Days__c = 180,Record_Type_id__c ='012A0000000Gjh5IAC');
        insert new Opportunity_Stages__c(Name = 'Quoted');
        Project__c prolist = new Project__c();
        prolist.Project_Zip_Code__c = '94040';
        prolist.Name = 'Test Project CompetitorHelper_Test';
        prolist.Application__c = 'Automotive';
        prolist.Application_2__c = 'Dealership';
        insert prolist;
        Opportunity o = new Opportunity();
        o.Name = 'Test Opp CompetitorHelper_Test1';
        o.StageName = 'Quoted';
        o.CloseDate = Date.today();
        o.Country__c = 'USA';
        o.Postal_Code__c = 'TEST';
        o.Project_name__c = prolist.id;
        o.RecordtypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Commercial Opportunity').getRecordTypeId();
        insert o;
        Test.startTest();
        Quote__c q = new Quote__c();
        q.Name = 'Test Quote';
        q.Opportunity__c = o.Id;
        q.Primary_Quote__c=True;        
        Date d = System.today().addDays(-180);
        q.Print_Date__c = d;
        insert q;
        o.Name = 'New name test';
        update o;
        System.debug('Date'+o.Max_Email_Date__c);
        batchOppMaxEmailDate en = new batchOppMaxEmailDate ();
        Database.executeBatch(en);
        Test.stopTest();
    }
}