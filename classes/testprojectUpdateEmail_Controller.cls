@isTest
public class testprojectUpdateEmail_Controller {
    static testmethod void method1(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ResponseCode', 'Cancelled');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }
    static testmethod void method2(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ResponseCode', 'Lost');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }
    static testmethod void method3(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ResponseCode', 'Inactive');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }
    static testmethod void method4(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ERD', '30Days');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }
    static testmethod void method5(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ERD', '60Days');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }
    static testmethod void method6(){
        list<Zip_Codes_Master__c> tmList = TestDataUtility.getTerritoryMaster();
        insert tmList;
        list<Project__c>prolist = Testdatautility.createProjectTestData();
        for(Integer i = 0;i<prolist.size();i++){
            prolist[i].close_date__c = Date.newInstance(2017, 7, 25);
            prolist[i].stage__c = 'Project Created';
        }
        insert prolist;
        test.startTest();
        PageReference pageRef = Page.projectUpdateEmail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('ProjectId', prolist[0].id);
        ApexPages.currentPage().getParameters().put('ERD', '90Days');
        projectUpdateEmail_Controller pr = new projectUpdateEmail_Controller();
        pr.InitPage();
        test.stopTest();
    }

}