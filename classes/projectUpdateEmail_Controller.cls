/**********************************************************************
Apex Class: projectUpdateEmail_Controller
Description: This class works as a controller for projectUpdateEmail VF page 
Author David: Aquib Javed
Created Date: 12th July,2017            
***********************************************************************/

public class projectUpdateEmail_Controller {
  
    public String ProjectId {get;set;}
    public String ResponseCode {get;set;}
    public String ERDDate {get;set;}
    
    /*************************************************
    Method Name: projectUpdateEmail_Controller
    Description: Constructor of this class
    Input Parameter: N/A    
    *************************************************/
    
    public projectUpdateEmail_Controller () {
        ProjectId = ApexPages.currentPage().getParameters().get('ProjectId');
        ResponseCode = ApexPages.currentPage().getParameters().get('ResponseCode');
        ERDDate = ApexPages.currentPage().getParameters().get('ERD');
    }
    
    /*************************************************
    Method Name: InitPage
    Description: This method will be called when user clicks on button in EMail 
                 It updates the project stage as per user input
    Input Parameter: N/A    
    *************************************************/
    public void InitPage() {
        
        //Code not bulkified as we will only be dealing with one project at a time based on Reps input. 
        
        List<Project__c> RepReply = [SELECT Name , Id, OwnerID , Owner.FirstName, Owner.Email ,Stage__c,Close_Date__c FROM Project__c WHERE Id=:ProjectId LIMIT 1]; 
        
        //Null Check
        if(!RepReply.IsEmpty()){

                system.debug('Value of RepReply' + RepReply);

            // Project Stage Update
            if(ResponseCode != null ){
            
                system.debug('I am inside Project Stage Updte with' + ResponseCode );

                if(ResponseCode == 'Lost' ){
                     
                    RepReply[0].Stage__c= 'Closed Lost - Project Lost';
                    RepReply[0].Reason_Project_Lost__c = 'None';
                }
                
                else if(ResponseCode == 'Cancelled' ){
                     
                    RepReply[0].Stage__c= 'Closed Lost - Project Cancelled';
                    RepReply[0].Reason_Project_Lost__c = 'None';
                    
                }
                
                else if(ResponseCode == 'Inactive'){
                    
                     RepReply[0].Stage__c= 'Closed - Inactivity';
                }
               
                
           }

           //Project ERD update
           else if(ERDDate != null){

                    system.debug('I am inside Close Date Update  with' + ERDDate );

                  if(ERDDate == '30Days'){

                         RepReply[0].Close_Date__c = RepReply[0].Close_Date__c.addDays(30);
                         RepReply[0].Mail_Sent__c = False ;
                    }


                  else if(ERDDate == '60Days'){

                         RepReply[0].Close_Date__c = RepReply[0].Close_Date__c.addDays(60);
                         RepReply[0].Mail_Sent__c = False ;
                  }

                   else if(ERDDate == '90Days'){

                         RepReply[0].Close_Date__c = RepReply[0].Close_Date__c.addDays(90);
                         RepReply[0].Mail_Sent__c = False ;
                  }

           }

           //for sending response mail to Project Owner

             List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
            List<String> toAddresses = new List<String>(); 
            toAddresses.add(RepReply[0].Owner.Email); 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setSubject('Response Received : ' + RepReply[0].Name);
            mail.setSenderDisplayName('Nanawall Support');
            string messageBody ='<html><body> Hi '+ RepReply[0].Owner.FirstName  + '<br/><br/> We have received and updated your response for this project. <br/><br/> Regards, <br/> Nanawall Support Team</body></html>';
            mail.setHtmlBody(messageBody); 
            mailList.add(mail);  
            

           //DMLs inside try block
           //Sending Email inside Try Block
                try{
                     Messaging.sendEmail(mailList);
                     UPDATE RepReply;
                }
                catch(exception e){
                    system.debug('Exception is:' +e.getMessage());
                }
        }
    }
}