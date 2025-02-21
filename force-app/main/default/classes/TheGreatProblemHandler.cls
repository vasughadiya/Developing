public with sharing class TheGreatProblemHandler {
    
    public static void greatProblem(List<Contact> newContacts) {
        if (newContacts == null || newContacts.isEmpty()) {
            return;
        }
        
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : newContacts) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for (Account acc : [SELECT Id, Max_Limit__c, Name FROM Account WHERE Id IN :accountIds]) {
            accountMap.put(acc.Id, acc);
        }
        
        List<Contact> contactsToInsert = new List<Contact>();
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for (Contact con1 : newContacts) {
            Contact con = con1.clone(true);
            Account relatedAcc = accountMap.get(con.AccountId);
            if (relatedAcc == null || con.Limit__c == null || relatedAcc.Max_Limit__c == null) {
                continue;
            }
            
            Decimal remainingAmount = con.Limit__c;
            if (remainingAmount > relatedAcc.Max_Limit__c) {
                con.Limit__c = relatedAcc.Max_Limit__c;
                remainingAmount -= relatedAcc.Max_Limit__c;
                
                while (remainingAmount > relatedAcc.Max_Limit__c) {
                    Contact splitCon = new Contact(
                        AccountId = con.AccountId,
                    LastName = relatedAcc.Name,
                    Limit__c = relatedAcc.Max_Limit__c
                        );
                    contactsToInsert.add(splitCon);
                    remainingAmount -= relatedAcc.Max_Limit__c;
                }
                
                if (remainingAmount > 0) {
                    Contact lastCon = new Contact(
                        AccountId = con.AccountId,
                    LastName = relatedAcc.Name,
                    Limit__c = remainingAmount
                        );
                    contactsToInsert.add(lastCon);
                }
                
                contactsToUpdate.add(con);
            }
        }
        
        try {
            if (!contactsToInsert.isEmpty()) {
                insert contactsToInsert;
            }
            if (!contactsToUpdate.isEmpty()) {
                update contactsToUpdate;
            }
        } catch (DmlException e) {
            System.debug('Error inserting/updating contacts: ' + e.getMessage());
        }
    }
}