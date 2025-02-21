public with sharing class SheepProblemHandler {
    
    public static void updateContacts(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> oldAccountIds = new Set<Id>();
        Set<Id> newAccountIds = new Set<Id>();
        Map<Id, Id> contactToNewAccountMap = new Map<Id, Id>();
        
        for (Contact newContact : newContacts) {
            Contact oldContact = oldContactsMap.get(newContact.Id);
            if (oldContact != null && oldContact.AccountId != newContact.AccountId) {
                oldAccountIds.add(oldContact.AccountId);
                newAccountIds.add(newContact.AccountId);
                contactToNewAccountMap.put(oldContact.AccountId, newContact.AccountId);
            }
        }
        
        if (oldAccountIds.isEmpty() || newAccountIds.isEmpty()) {
            return;
        }
        
        List<Contact> contactsToUpdate = new List<Contact>();
        List<Contact> affectedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :oldAccountIds];
        
        for (Contact con : affectedContacts) {
            if (contactToNewAccountMap.containsKey(con.AccountId)) {
                con.AccountId = contactToNewAccountMap.get(con.AccountId);
                contactsToUpdate.add(con);
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            try {
                update contactsToUpdate;
            } catch (DmlException e) {
                System.debug('Error updating Contacts : ' + e.getMessage());
            }
        }
    }
    
    public SheepProblemHandler() {
        
    }
}