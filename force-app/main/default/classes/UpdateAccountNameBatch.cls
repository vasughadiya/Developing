public with sharing class UpdateAccountNameBatch implements Database.Batchable<SObject> {
    
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, Amount, AccountId FROM Opportunity WHERE AccountId != NULL');
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        for (Opportunity opp : scope) {
            if (opp.AccountId != null && opp.Amount < 20000) {
                Account acc = new Account(
                    Id = opp.AccountId,
                Name = opp.Name
                    );
                accountMap.put(acc.Id, acc);
            }
        }
        
        if (!accountMap.isEmpty()) {
            update accountMap.values();
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Process Completed Successfully.');
    }
    
    
    public UpdateAccountNameBatch() {
        
    }
}


// UpdateAccountNameBatch uanb = new UpdateAccountNameBatch();
// Database.executeBatch(uanb, 50); // Batch size = 200 records per execution
