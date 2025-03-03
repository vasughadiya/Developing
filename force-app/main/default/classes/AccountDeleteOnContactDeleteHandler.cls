public with sharing class AccountDeleteOnContactDeleteHandler {
    
    public static void deleteRelatedAccounts(List<Contact> deletedContacts) {
        Set<Id> relatedAccounts = new Set<Id>();
        List<Account> acc = new List<Account>();
        
        for (Contact con : deletedContacts) {
            String accId = con.AccountId;
            acc.add([SELECT Id FROM Account WHERE Id = :accId]);
        }
        if (!acc.isEmpty()) {
            try {
                delete acc;
            } catch (DmlException e) {
                System.debug('Error deleting Accounts: ' + e.getMessage());
            }
        }
    }
}