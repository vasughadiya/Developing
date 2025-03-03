public with sharing class CountTotalAmountHandler {
    
    public static void updateTotalCount(Map<Id, Contact> newCons, Map<Id, Contact> oldCons){
        
        
        Set<Id> accountIds = new Set<Id>();
        
        for (Contact con : (oldCons != null ? oldCons.values() : new List<Contact>())) {
            if (con.AccountId != null) accountIds.add(con.AccountId);
        }
        for (Contact con : (newCons != null ? newCons.values() : new List<Contact>())) {
            if (con.AccountId != null) accountIds.add(con.AccountId);
        }
        
        if (accountIds.isEmpty()) return;
        
        List<Account> triggerAccount = [SELECT Id, Total_Amount__c, (SELECT Amount__c FROM Contacts) FROM Account WHERE Id IN :accountIds];
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : triggerAccount) {
            acc.Total_Amount__c = 0;
            for (Contact con : acc.Contacts) {
                acc.Total_Amount__c += (con.Amount__c != null ? con.Amount__c : 0);
            }
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
        
    }
}