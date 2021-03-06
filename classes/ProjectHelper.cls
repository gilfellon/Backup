/**********************************************************************
Apex Test Class: ProjectHelper
Description: This class is used to write all business logic related to Project Trigger .
Created Date: June 19th , 2015            
***********************************************************************/

public class ProjectHelper {
     /*************************************************
    Method Name: projSharingRecalOnInsertUpdate
    Description: T
    Input Parameter: Trigger.new and Trigger.OldMap        
    *************************************************/
    public static void projSharingRecalOnInsertUpdate(List<Project__c> lstNewProj , Map<Id,Project__c> mapOldProj) {
        map<Id,Project__c> projMap = new map<Id,Project__c>();
        for (Project__c proj : lstNewProj){
            if (mapOldProj.get(proj.Id).OwnerId != proj.OwnerId){
                projMap.put(proj.Id, proj);
            }
        } 
     
        if (projMap.values().size() > 0){
            projSharingRecal.projShare(projMap); 
       }
    }
    
    /*************************************************
    Method Name: updateCorpAccFrmProj
    Description: T
    Input Parameter: Set of project Ids       
    *************************************************/
    public static void updateCorpAccFrmProj(set<ID> prjIds){
        map<ID,Opportunity> oppMap= new map<Id,opportunity>();
        list<opportunity> listOpp=[Select id,chain_account__c from opportunity where project_name__c IN : prjIds];
         System.debug('34-Number of Queries used in this apex code so far: ' + Limits.getQueries());

        for(opportunity oppToUpdate : listOpp){
            if(!oppToUpdate.chain_account__c){
                oppToUpdate.chain_account__c=True;
                oppMap.put(oppToUpdate.id,oppToUpdate);
            } 
        }
        if(oppMap.values().size()>0){
            Database.saveresult[] sr = Database.update(oppMap.values(), False); 
            ErrorLogUtility.processErrorLogs(sr, oppMap.values(), 'ProjectHelper', 'updateCorpAccFrmProj', 'Opportunity', 'Update');
        }
    }
    
    /*************************************************
    Method Name: updateResidentialVerticalFrmProj
    Description: This method is used for updating opportunities when residential vertical field is changed 
    Input Parameter: Set of project Ids       
    *************************************************/
    public static void updateResidentialVerticalFrmProj(set<ID> prjIds2){
        map<ID,Opportunity> oppMap2= new map<Id,opportunity>();
        list<opportunity> listOpp=[Select id,Residential_Vertical__c from opportunity where project_name__c IN : prjIds2];
         System.debug('56-Number of Queries used in this apex code so far: ' + Limits.getQueries());

        for(opportunity oppToUpdate2 : listOpp){
            if(!oppToUpdate2.Residential_Vertical__c){
                oppToUpdate2.Residential_Vertical__c=True;
                oppMap2.put(oppToUpdate2.id,oppToUpdate2);
            } 
        }
        if(oppMap2.values().size()>0){
            Database.saveresult[] sr = Database.update(oppMap2.values(), False); 
            ErrorLogUtility.processErrorLogs(sr, oppMap2.values(), 'ProjectHelper', 'updateResidentialVerticalFrmProj', 'Opportunity', 'Update');
        }
    }
    
    /******************************************************************************************************************
    Method Name: createProjSplitLocation
    Description: The method adds the Project Split record whenever a Project is created.
    Input Parameter: List of projects       
    *******************************************************************************************************************/
    
    public static void createProjSplitLocation(list<Project__c> projlst){
        
        list<Project_Split__c> splitToInsert = new list<Project_Split__c>();
        map<String,Project_Split__c> mapProjSplit = new map<String,Project_Split__c>();
        set<Id> projId = new set<Id>();
        
        for (Project__c proj : projlst){
            projId.add(proj.Id);
        }
        
        list<Project_Split__c> splitToQuery = [Select Id,Project__c,Project_Rep__c,Role__c from Project_Split__c where Project__c =: projId ];
         System.debug('87-Number of Queries used in this apex code so far: ' + Limits.getQueries());

        for (Project_Split__c pSplit : splitToQuery){
            mapProjSplit.put(pSplit.Project__c + '#' + pSplit.Project_Rep__c + '#' + pSplit.Role__c,pSplit);
        }
        
        for (Project__c proj :  projlst){
            
             if (!mapProjSplit.containsKey(proj.Id + '#' + proj.OwnerId + '#' + 'Location')){
             
             Project_Split__c projSplit = new Project_Split__c();
             projSplit.Project__c = proj.Id ;
             projSplit.Project_Rep__c = proj.OwnerId ;
             projSplit.Role__c = 'Location';
             if(trigger.isInsert){
             projSplit.Split__c = 100 ;
             }
             else{
             projSplit.Split__c = 0 ;
             }
             splitToInsert.add(projSplit);
          } 
        }
        
        if(splitToInsert.size() > 0){
            Database.saveresult[] sr = Database.insert(splitToInsert, False); 
            ErrorLogUtility.processErrorLogs(sr, splitToInsert, 'ProjectHelper', 'createProjSplitLocation', 'Project_Split__c', 'Insert');
        }
        
    }
    
     /****************************************************************************************************************************************
      Method Name: createProjSplitSpecifier
      Description: The method adds the Project Split record whenever a Project is created/updated with an architech account.
      Input Parameter: List of projects       
    *****************************************************************************************************************************************/
    
    public static void createProjSplitSpecifier(list<Project__c> projlst){
        
        list<Project_Split__c> splitToInsert = new list<Project_Split__c>();
        set<Id> projId = new set<Id>();
        map<String,Project_Split__c> mapProjSplit = new map<String,Project_Split__c>();
        
        for (Project__c proj : projlst){
            projId.add(proj.Id);
        }
        
        list<Project__c> querylist = [Select Id,Architect_Account__c, Architect_Account__r.OwnerId from Project__c where Id =: projId];
        
        list<Project_Split__c> splitToQuery = [Select Id,Project__c,Account__c,Project_Rep__c,Role__c from Project_Split__c where Project__c =: projId ];
         System.debug('137-Number of Queries used in this apex code so far: ' + Limits.getQueries());

        for (Project_Split__c pSplit : splitToQuery){
            mapProjSplit.put(pSplit.Project__c + '#' + pSplit.Project_Rep__c + '#' + pSplit.Account__c + '#' + pSplit.Role__c,pSplit);
        }
        
        for (Project__c proj :  querylist){
            
             if (!mapProjSplit.containsKey(proj.Id + '#' + proj.Architect_Account__r.OwnerId + '#' + proj.Architect_Account__c + '#' + 'Specifier')){
            
             Project_Split__c projSplit = new Project_Split__c();
             projSplit.Project__c = proj.Id ;
             projSplit.Project_Rep__c = proj.Architect_Account__r.OwnerId ;
             projSplit.Account__c = proj.Architect_Account__c ;
             projSplit.Role__c = 'Specifier';
             projSplit.Split__c = 0 ;
             splitToInsert.add(projSplit);
          }  
        }
        
        if(splitToInsert.size() > 0){
            Database.saveresult[] sr = Database.insert(splitToInsert, False); 
            ErrorLogUtility.processErrorLogs(sr, splitToInsert, 'ProjectHelper', 'createProjSplitLocation', 'Project_Split__c', 'Insert');
        }
        
    }
    /****************************************************************************************************************************************
      Method Name: projCeroCheck
      Description: The method Checks the CERO Checkbox  whenever a Related Quote Detail is created/updated with an CERO  Model.
      Input Parameter: Set Ids of Quotes      
    *****************************************************************************************************************************************/
     public static void projCeroCheck(Set<ID> quoteIds){
        List<Quote__c> quoList = [select id,Project__c,Opportunity__c from Quote__c where ID =:quoteIds ];
           System.debug('170-Number of Queries used in this apex code so far: ' + Limits.getQueries());

          Set<ID> proIds = new Set<ID>();
          list<Project__c> ProjUpdateList = new list<Project__c>();
          for (Quote__c quo: quoList) {
                proIds.add(quo.Project__c);
           }
          if (proIds.size() >0){
            for (Project__c proj: [Select Id,CERO__c  from Project__c Where Id IN: proIds]) {
                proj.CERO__c = true;
                system.debug('ProjectCERO'+proj.CERO__c);
                ProjUpdateList.add(proj);
            }
            if(ProjUpdateList.size()>0){
                 Database.saveresult[] sr = Database.update(ProjUpdateList, False); 
                 ErrorLogUtility.processErrorLogs(sr, ProjUpdateList, 'ProjectHelper', 'projCeroCheck', 'Project', 'Update');
            }
          }
     }

     /****************************************************************************************************************************************
      Method Name: createInfluencerOpportunity
      Description: The method creates Influencer opportunity below Project 
      Input Parameter: List of projects       
    *****************************************************************************************************************************************/
     public static void createInfluencerOpportunity (List<Project__c> lstPro) {

        system.debug('I am here createInfluencerOpportunity');

        map<ID , string > mapProjectArchitect = new map <ID,string> ();
        List<opportunity> lstOppInsert = new List <opportunity> () ;

        for(Project__c p : lstPro){

            mapProjectArchitect.put(p.ID , p.Architect_Account__c) ; 
        }
        string InfluencerRecordTypeID = label.Influencer_Opportunity_RecordTypeId ; 
        //To know if Project already have a Influencer opportunity or not
      system.debug('Project NAME'+mapProjectArchitect.keyset()+'RecordTypeID'+InfluencerRecordTypeID);
     Integer count =   [SELECT count() From opportunity WHERE project_name__c in: mapProjectArchitect.keyset() AND recordTypeID =: InfluencerRecordTypeID ] ;
     
     // Project Doesn't have a Influencer Opp - Create one
     if(count == 0){

        system.debug('I am inside if') ; 

        for(Project__c p : lstPro ){

            Opportunity opp = new Opportunity () ; 
            
            opp.project_name__c = p.ID ; 
            opp.AccountID = p.Architect_Account__c ; 
            opp.Name = 'Fills Automatically' ;
            opp.StageName = 'Drawings - Requested' ; 
            opp.CloseDate = p.Close_Date__c ;
            opp.ForecastCategoryName = 'Pipeline';
            opp.recordTypeID = InfluencerRecordTypeID ; 
            lstOppInsert.add(opp) ; 


        }
        system.debug('Value of lstOppInsert' +lstOppInsert) ; 
     }
     
     else{

        system.debug('I am inside else') ; 
        // Influencer opp already exist , check if its account is same as Architect account, if not then create new

        List<Opportunity> lstOpps = [SELECT AccountID , ID , Close_Date__c, project_name__c  FROM Opportunity WHERE project_name__c in: mapProjectArchitect.keyset() AND  recordTypeID =: InfluencerRecordTypeID ] ; 
        
        set<ID> setAccountID = new set<ID>() ; 
        for(Opportunity opp : lstOpps){
               setAccountID.add(opp.AccountID) ;  
        }
        
       
        for(Opportunity o : lstOpps){

            if((!setAccountID.contains(mapProjectArchitect.get(o.project_name__c))) && (UtilityClass.onlyrunOnce == TRUE)) {
            
            system.debug('I am inside inner if' + lstOpps);
            Opportunity opp = new Opportunity (); 
            opp.project_name__c = o.project_name__c ; 
            opp.Name = 'Fills Automatically' ; 
            opp.AccountID = mapProjectArchitect.get (o.project_name__c) ; 
            opp.StageName = 'Drawings - Requested' ; 
            opp.CloseDate = o.Close_Date__c ; 
             opp.recordTypeID = InfluencerRecordTypeID ;
             opp.ForecastCategoryName = 'Pipeline';
            lstOppInsert.add(opp) ; 
            UtilityClass.onlyRunOnce = FALSE ;
            }
        }

     }


     try{
                if(lstOppInsert.size() > 0 ){
                    system.debug('Inside Try lstOppInsert' +lstOppInsert) ; 
                     UtilityClass.firstRun = FALSE ;
                Database.saveresult[] sr = Database.insert(lstOppInsert, False); 

                  }
        }

    catch(exception e){

        system.debug('Exception is:' +e.getMessage());

    }
     


     }
     
     
     /****************************************************************************************************************************************
      Method Name: updateOpportunityonHoldandCancelled
      Description: The method updates opportunities below Project 
      Input Parameter: List of projects       
    *****************************************************************************************************************************************/
     public static void updateOpportunityonHoldandCancelled(set<Id> lstProIds) {
     
        list<project__c> allProjWithOpps = new list<project__c>();
        list<opportunity> opps = new list<opportunity>();
        allProjWithOpps = [Select Id,Stage__c, (Select Id,AccountId,StageName,recordtype.Name from Opportunities__r) from Project__c WHERE ID IN: lstProIds];
        for(project__c pro : allProjWithOpps){
           for(opportunity opp : pro.Opportunities__r){
              if(pro.stage__c=='Project Lost'){
                if(opp.recordtype.Name=='Influencer Opportunity'){
                opp.StageName = 'Project Lost - Influencer';
                opp.Reason_Opportunity_Lost__c = 'None';
                }
                else{
                opp.StageName = 'Project Lost';
                opp.Reason_Opportunity_Lost__c = 'None';
                }
              }
              else if(pro.stage__c=='Project Cancelled'){
               opp.StageName = 'Project Cancelled';
              }
              else if(pro.stage__c=='Project Inactive'){
               opp.stageName = 'Project Inactive';
              }
              else if(pro.stage__c=='Project On Hold'){
                opp.stageName = 'Project On Hold';
              }
           opps.add(opp);
           }
           
        }
        
         if (opps.size() > 0) {
            //Updating Project
            Database.saveresult[] sr = Database.update(opps, False); 
            //ErrorLogUtility.processErrorLogs(sr, updateProjList, 'OpportunityHelper', 'UpdateProjectStagesFromOppStages', 'Project__c', 'Update');
        }
     }
     
     
}