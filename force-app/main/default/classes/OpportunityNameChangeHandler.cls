public with sharing class OpportunityNameChangeHandler {
    
    public static void createTaskOnNameChange(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap){
        List<Task> Tasks = new List<Task>();
        
        for (Opportunity Opp : newOpps){
            Opportunity oldOpp = oldOppMap.get(Opp.Id);
            
            if(oldOpp != null && Opp.Name != oldOpp.Name){
                Task newTask = new Task(
                    Subject = 'Task on Opprtunity Name Change',
                Description = 'The Opprtunity name has been change from "' + oldOpp.Name + '" to "' + Opp.Name + '".',
                OwnerID = Opp.OwnerID,
                WhatId = Opp.Id,
                Status = 'Not Started',
                Priority = 'High'
                    );
                Tasks.add(newTask); 
            }
        }
        if(!Tasks.isEmpty()){
            insert Tasks;
        }
    }
    
    public OpportunityNameChangeHandler(){
        
    }
    
}