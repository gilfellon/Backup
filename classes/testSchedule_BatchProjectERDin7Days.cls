@isTest
public class testSchedule_BatchProjectERDin7Days {
 public static testMethod void testschedule1() {

    Test.StartTest();
    Schedule_BatchProjectERDin7Days sh1 = new Schedule_BatchProjectERDin7Days();
    String sched = '0 0 10 * * ?'; 
    system.schedule('Batch Project notification Job', sched, sh1);
    Test.stopTest(); 
    
    }
    
    public  static testmethod void testschedule2(){
        test.StartTest();
         Schedule_BatchProjectERDin7Days.scheduleMe();
        test.StopTest();
    }
}