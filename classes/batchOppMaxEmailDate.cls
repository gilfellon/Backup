global class batchOppMaxEmailDate implements Database.Batchable < sObject >{
String query;
    public list<Opportunity_Stages__c> myCS1 = Opportunity_Stages__c.getall().values();
    public list<String> allstages = new list<String>();
    //global String filters ='006Q000000FLetoIAD';
    Run_Batch_Class__c myCS2 = Run_Batch_Class__c.getValues('Execute Batch');
    Opp_Max_Email_Date__c resopp = Opp_Max_Email_Date__c.getValues('Residential Opportunity');
     Opp_Max_Email_Date__c commopp = Opp_Max_Email_Date__c.getValues('Commercial Opportunity');
    String residential = String.valueOf(resopp.Record_Type_id__c);
    String commercial = String.valueOf(commopp.Record_type_id__c);

// Start Method of Batch class 
    global Database.querylocator start(Database.BatchableContext BC) {
        System.debug('opp stages'+myCS1);
        for(Opportunity_Stages__c os:myCS1) {
            allstages.add(os.Name);
        }
       // Query = 'SELECT ID, Name, StageName,Max_Email_Date__c,Recordtype.Name,Conversica_Switch__c FROM Opportunity Where Id =:filters';
        Query = 'SELECT ID, Name, StageName,Max_Email_Date__c,Recordtype.Name,Conversica_Switch__c FROM Opportunity Where StageName in:allstages and (RecordtypeID =: residential or RecordtypeID =: commercial)';
        system.debug('Value of Query' + Query);
        system.debug('The Query Returns' + Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
    }
    // Execute Method of Batch class
    global void execute(Database.BatchableContext BC, List < Opportunity > opplist) {
        system.debug('Inside Execute');
        List<opportunity> toupdate = new list<opportunity>();
        System.debug('query list'+opplist);
        if(myCS2.Execute_batch_Class__c = true){
            DateTime ab = System.today();
            Date d = Date.newInstance(ab.year(), ab.month(), ab.day());
            for(Opportunity op:opplist){
            Date maxdate =op.Max_Email_date__c.Date();
            System.debug('MaxDte'+maxdate+'today'+d);
            system.debug('RecordTypeName'+op.RecordType.Name+'Max_Email_Date__c'+System.today()+' '+op.Max_Email_Date__c.addDays(180));
                if((residential == op.RecordTypeId && (d == maxdate.addDays(90)))|| (commercial == op.RecordTypeId && (d == maxdate.addDays(180)))){
                    if(op.Conversica_Switch__c == true){
                        op.Conversica_Switch__c = false;
                        toupdate.add(op);
                    }
                    else{
                        op.Conversica_Switch__c = true;
                        toupdate.add(op);
                    }
               }

           }
            if(toupdate.size()>0){
            try{
                update toupdate;
               }
                catch(Exception e){
                    System.debug('Exception is:'+e);
                }
            }
       }
        
    }
    global void finish(Database.BatchableContext BC) {

    }
}