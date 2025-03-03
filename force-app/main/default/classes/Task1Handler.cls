public with sharing class Task1Handler {

    public static void mymethod(Map<Id, Opportunity> newOpps, Map<Id,Opportunity> oldOpps) {

        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity newopp : (newOpps != null ? newOpps.values() : new List<Opportunity>())){
            accountIds.add(newopp.AccountId);
        }

        for(Opportunity oldOpp : (oldOpps != null ? oldOpps.values() : new List<Opportunity>())){
            accountIds.add(oldopp.AccountId);
        }

        List<Account> triggeredAcc = [SELECT Id, TotalOpportunityAmount__c, (SELECT Amount FROM Opportunities) FROM Account WHERE Id IN :accountIds];
        List<Account> accToUpdate = new List<Account>();
    
        for (Account acc : triggeredAcc){
            acc.TotalOpportunityAmount__c = 0;
            for(Opportunity opp : acc.Opportunities){
                acc.TotalOpportunityAmount__c += (opp.Amount != null ? opp.Amount : 0);
            }
            accToUpdate.add(acc);
        }
        
        if (!accToUpdate.isEmpty()) {
            try {
                update accToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
}   
