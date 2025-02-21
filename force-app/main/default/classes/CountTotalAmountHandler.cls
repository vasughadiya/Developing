public with sharing class CountTotalAmountHandler {
    
    public static void updateTotalCount(Map<Id, Contact> newCons, Map<Id, Contact> oldCons){
        // Decimal oldAmount = 0;
        // for(Contact newCon : newCons){
            //     if (!oldCons.isEmpty()) {
                //         for(Contact oldCon : oldCons){
                    //             if (oldCon.Id == newCon.Id){
                        //                 oldAmount = oldcon.Amount__c;
                    //             }
                //         }
            //     }
            //     Account relatedAcc = [SELECT Id FROM Account WHERE Id = : newCon.Id];
            //     relatedAcwc.Total_Amount__c += (newcon.Amount__c - oldAmount);
        // }

        Set<Account> triggerAccounts = new Set<Account>();

        List<Account> conAcc = [SELECT Id FROM Account WHERE Id IN: oldCons.keySet()];

        Map<Id, Account> conAccMap = new Map<Id, Account>();
        for(Account a : conAcc){
            conAccMap.put(a.Id, a);
        }
        
        if (oldCons != null) {
            for (Contact oldCon : oldCons.values()) {
                if (String.IsEmpty(oldCon.AccountId)) {
                    Account acc = conAccMap.get(oldCon.AccountId);
                    triggerAccounts.add(acc);
                }   
            }
        }
        
        if (newCons != null) {
            for (Contact newCon : newCons.values()) {
                if (newCon.AccountId != null) {
                    Account acc = [SELECT Id FROM Account WHERE Id = : newCon.AccountId];
                    triggerAccounts.add(acc);
                }
            }
        }

        List<Account> accToUpdate = new List<Account>();
        
        if(!triggerAccounts.isEmpty()){
            for(Account acc : triggerAccounts){
                if(acc.Id != null){
                    Decimal total = 0;
                    List<Contact> cons = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
                    for (Contact con : cons){
                        if (con.Id != null){
                            total += con.Amount__c;
                        }
                    }
                    acc.Total_Amount__c = total;
                }
                accToUpdate.add(acc);
            }
        }

        if(!accToUpdate.isEmpty()){
            try {
                update accToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }

// ===>>>>>




        
        // if(accountIds.isEmpty()){
            //     return;
        // }
        
        // Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
        
        // for (Account acc : [SELECT Id, Total_Amount__c FROM Account WHERE Id IN :accountIds]) {
            //     accountsToUpdate.put(acc.Id, acc);
        // }
        
        // Map<Id, Decimal> accountTotals = new Map<Id, Decimal>();
        // for (AggregateResult ar : [
        //                 SELECT AccountId, SUM(Amount__c) totalAmount
        //                 FROM Contact
        //                 WHERE AccountId IN :accountIds
        //                 GROUP BY AccountId
        //             ]) {
            //     accountTotals.put((Id) ar.get('AccountId'), (Decimal) ar.get('totalAmount'));
        // }
        
        // List<Account> accountsToUpdateList = new List<Account>();
        // for (Id accId : accountsToUpdate.keySet()) {
            //     Account acc = accountsToUpdate.get(accId);
            //     acc.Total_Amount__c = accountTotals.containsKey(accId) ? accountTotals.get(accId) : 0;
            //     accountsToUpdateList.add(acc);
        // }
        
        
        // if (!accountsToUpdateList.isEmpty()) {
            //     try {
                //         update accountsToUpdateList;
            //     } catch (DmlException e) {
                //         System.debug('Error updating accounts: ' + e.getMessage());
            //     }
        // }
        
    }
    
    public CountTotalAmountHandler() {
        
    }
}