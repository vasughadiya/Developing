public with sharing class DeleteSameNameAccountsHandler {
    
    public static void deleteAccount(List<Account> newAccounts) {
        Set<String> accountNames = new Set<String>();
        
        for (Account acc : newAccounts) {
            if (acc.Name != null) {
                accountNames.add(acc.Name);
            }
        }
        if(!accountNames.isEmpty()){
            List<Account> sameNameAccounts = [SELECT Id FROM Account WHERE Name IN :accountNames];
            
            try {
                delete sameNameAccounts;
                System.debug('Deleted duplicate accounts: ' + sameNameAccounts);
            } catch (DmlException e) {
                System.debug('Error deleting accounts: ' + e.getMessage());
            }
        }
    }
    
}