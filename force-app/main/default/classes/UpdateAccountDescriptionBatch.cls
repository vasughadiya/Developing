global with sharing class UpdateAccountDescriptionBatch implements Database.Batchable<SObject>, Schedulable {
    
    public Database.QueryLocator start(Database.BatchableContext b) {
        System.debug('Batch start method triggered');
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }
    
    public void execute(Database.BatchableContext b, List<Account> accounts) {
        System.debug('Batch execute method triggered');

        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : accounts) {
            acc.Description = 'Updated on: ' + System.now().format();
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }

        System.debug('Batch execute method completed');
    }
    
    public void finish(Database.BatchableContext b) {
        System.debug('Batch finish method triggered');
        System.debug('Account Description Update Batch Completed.');
    }
    
    global void execute(SchedulableContext s) {
        System.debug('Scheduled job started');
        Database.executeBatch(new UpdateAccountDescriptionBatch(), 200);
    }
    
    public UpdateAccountDescriptionBatch() { }
}


// String cronExp = '0 0 9 * * ?'; // Every day at 9 AM
// System.schedule('Daily Account Update', cronExp, new UpdateAccountDescriptionBatch());