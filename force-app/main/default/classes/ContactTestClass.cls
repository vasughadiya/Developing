@isTest
private class ContactTestClass {
    
    @testSetup
    static void setupTestData() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(LastName = 'Test Contact', Email = 'test@example.com', AccountId = acc.Id);
        insert con;
        
        Account oldAccount = new Account(Name = 'Old Account');
        Account newAccount = new Account(Name = 'New Account');
        insert new List<Account>{ oldAccount, newAccount };
        
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'test', Email = 'test@example.com', AccountId = oldAccount.Id),
            new Contact(LastName = 'test', Email = 'test@example.com', AccountId = oldAccount.Id)
        };
        insert contacts;
        // List<Contact> contacts = new List<Contact>{
            //     new Contact(LastName = 'Test contect', Email = 'test@example.com', AccountId = acc.Id),
            //     new Contact(LastName = 'Test Contact', Email = 'test@example.com', AccountId = acc.Id)
        // };
        // insert contacts;
    }
    
    @isTest
    static void AccountDeleteOnContactDelete() {
        Test.startTest();
        Contact con = [SELECT Id, AccountId FROM Contact LIMIT 1];
        Id accountId = con.AccountId;
        delete con;
        Test.stopTest();
        // Handler : 90%
        // Trigger : 100%
    }
    
    @isTest
    static void EventForNewContact(){
        Test.startTest();
        Contact con = new Contact(LastName = 'Test Contact');
        insert con;
        Test.stopTest();
        // Handler : 94%
        // Trigger : 100%
    }
    
    @isTest
    static void CountTotalAmountInsertTrigger() {
        Test.startTest();
        Contact newContact = new Contact(FirstName = 'Alice', LastName = 'Brown', Email = 'alice@example.com');
        insert newContact;
        Test.stopTest();
    }
    
    @isTest
    static void CountTotalAmountUpdateTrigger() {
        Test.startTest();
        Contact existingContact = [SELECT Id, LastName FROM Contact LIMIT 1];
        existingContact.LastName = 'UpdatedName';
        update existingContact;
        Test.stopTest();
    }
    
    @isTest
    static void CountTotalAmountDeleteTrigger() {
        Test.startTest();
        Contact contactToDelete = [SELECT Id FROM Contact LIMIT 1];
        delete contactToDelete;
        Test.stopTest();
    }
    
    @isTest
    static void CountTotalAmountUndeleteTrigger() {
        Test.startTest();
        Contact contactToUndelete = [SELECT Id FROM Contact LIMIT 1];
        delete contactToUndelete;
        Contact deletedContact = [SELECT Id FROM Contact WHERE Id = :contactToUndelete.Id ALL ROWS];
        undelete deletedContact;
        Test.stopTest();
    }
    
    // For CountTotalAmount :
    // Handler : 94%
    // Trigger : 100%
    
    @isTest
    static void SheepProblem() {
        Test.startTest();
        Contact existingContact = [SELECT Id, LastName, accountId FROM Contact LIMIT 1];
        Account acc = [SELECT Id FROM Account WHERE Id != :existingContact.accountId LIMIT 1];
        existingContact.LastName = 'UpdatedName';
        existingContact.AccountId = acc.Id;
        update existingContact;
        Test.stopTest();
        // Header : 68%
        // Handler : 100%
    }
}