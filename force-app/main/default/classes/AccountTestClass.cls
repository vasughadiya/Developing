@isTest
private class AccountTestClass {
    
    @testSetup
    static void setupTestData() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }
    
    @isTest
    static void AccountPrefix() {
        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Test.stopTest();
        // handler : 100%
        // Trigger : 100%
    }
    
    @isTest
    static void AccountApproval(){
        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Test.stopTest();
        // handler : 100%
        // Trigger : 100%
    }
    @isTest
    static void CreateContactOnAccountCreation(){
        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Test.stopTest();
        // handler : 91%
        // Trigger : 100%
    }
    
    @isTest
    static void DeleteSameNameAccountsHandler(){
        Test.startTest();
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Test.stopTest();
        // handler : 90%
        // Trigger : 100%
    }
    
    @isTest
    static void SharingRuleOnAccount(){
        Test.startTest();
        Account acc = [SELECT Id, Name, Rating FROM Account LIMIT 1];
        acc.Name = 'Before Update Test';
        acc.Rating = 'Hot';
        update acc;
        Test.stopTest();
        // handler : 94%
        // Trigger : 100%
    }
}