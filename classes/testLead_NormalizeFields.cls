@isTest
public class testLead_NormalizeFields {
    static testmethod void method1(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
            insert tmList;
        List<Lead> leadlist = TestDataUtility.createLeadTestData();
        for(Integer i=0;i<leadlist.size();i++){
            leadlist[i].City = 'London';
            leadlist[i].StateCode = 'NY';
        }
        insert leadlist;
    }
}