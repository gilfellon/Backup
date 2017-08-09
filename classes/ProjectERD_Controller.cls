/**********************************************************************
Apex Class: ProjectERD_Controller
Description: This class works as a controller for ProjectERD VF page 
Author David: Aquib Javed
Created Date: 19th July,2017            
***********************************************************************/
public class ProjectERD_Controller {

   
    
    public project__c Pro {get;set;}
    
    public Date dat {get;set;}
    
    public string stage {get;set;}
    
    public list<SelectOption> options{get;set;}

    /*************************************************
    Method Name: ProjectERD_Controller
    Description: Constructor of this class
    Input Parameter: N/A    
    *************************************************/
    
     public ProjectERD_Controller () {
       
       
        options = new list<SelectOption>();
        pro = [SELECT id , Stage__c , Close_Date__c FROM Project__c WHERE id =: ApexPages.currentPage().getParameters().get('ProjectId') ];
         System.debug('date'+dat);
      }
       
       public list < selectOption > getProjStages() {
       
        List < SelectOption > options = new List < SelectOption > ();
        options.add(new SelectOption('Project Lost', 'Project Lost'));
        options.add(new SelectOption('Project Inactive', 'Project Inactive'));
        options.add(new SelectOption('Project Cancelled', 'Project Cancelled'));
        return options;
      }

        public void save(){
       if(stage != null && stage != ''){
                  
          if(stage == 'Project Lost' ){
                 
                pro.Stage__c= 'Closed Lost - Project Lost';
                pro.Reason_Project_Lost__c = 'None';
            }
            
            else if(stage == 'Project Cancelled' ){
                 
                pro.Stage__c= 'Closed Lost - Project Cancelled';
                pro.Reason_Project_Lost__c = 'None';
                
            }
            
            else if(stage == 'Project Inactive'){
                
                 pro.Stage__c= 'Closed - Inactivity';
            }
        }
        if(dat != null){
                 
             pro.close_date__c = dat;
        }

        //DMLs inside try block
            try{
                    UPDATE pro;
            }
            catch(exception e){
                system.debug('Exception is:' +e.getMessage());
            }

        
               

      }
    
    
}