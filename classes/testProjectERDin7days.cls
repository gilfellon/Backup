@isTest
public class testProjectERDin7days {
    static testmethod void method1(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = system.today().addDays(6);
            prolist[i].stage__c = 'Project Created';
            prolist[i].mail_sent__c = false;
        }
        insert prolist;
        test.startTest();
        batchProjectERDin7Days en = new batchProjectERDin7Days();
        Database.executeBatch(en);
        test.stopTest();
    }
}