public with sharing class DeleteSameNameAccountsHandler {
    
    public static void deleteAccount(List<Account> newAccounts) {
        Set<String> accountNames = new Set<String>();
        
        for (Account acc : newAccounts) {
            if (acc.Name != null) {
                accountNames.add(acc.Name);
            }
        }
        
        if (accountNames.isEmpty()) {
            return;
        }
        
        List<Account> sameNameAccounts = [SELECT Id FROM Account WHERE Name IN :accountNames];
        
        if (!sameNameAccounts.isEmpty()) {
            try {
                delete sameNameAccounts;
                System.debug('Deleted duplicate accounts: ' + sameNameAccounts);
            } catch (DmlException e) {
                System.debug('Error deleting accounts: ' + e.getMessage());
            }
        }
    }

    // public static void CountTotalAmount(List<Account> newAccounts){
    //     for (Account acc : newAccounts){
    //         if (acc.Id != null){
    //             Decimal total = 0;
    //             List<Contact> cons = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
    //             for (Contact con : cons){
    //                 if (con.Id != null){
    //                     total += con.Amount__c;
    //                 }
    //             }
    //             acc.Total_Amount__c = total;
    //         }            
    //     }
    // }
}