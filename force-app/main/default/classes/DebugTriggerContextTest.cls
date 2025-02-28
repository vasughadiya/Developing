/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class DebugTriggerContextTest {
    
    @testSetup
    static void setupTestData() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
    }
    
    @isTest
    static void testBeforeInsert() {
        Test.startTest();
        Account acc = new Account(Name = 'Before Insert Test');
        insert acc;
        Test.stopTest();
        
        System.assertNotEquals(null, acc.Id, 'Account should be inserted.');
    }
    
    @isTest
    static void testAfterInsert() {
        Test.startTest();
        Account acc = new Account(Name = 'After Insert Test');
        insert acc;
        Test.stopTest();
        
        System.assertNotEquals(null, acc.Id, 'Account should be inserted.');
    }
    
    @isTest
    static void testBeforeUpdate() {
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'Before Update Test';
        
        Test.startTest();
        update acc;
        Test.stopTest();
        
        Account updatedAcc = [SELECT Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('Before Update Test', updatedAcc.Name, 'Account name should be updated.');
    }
    
    @isTest
    static void testAfterUpdate() {
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        acc.Name = 'After Update Test';
        
        Test.startTest();
        update acc;
        Test.stopTest();
        
        Account updatedAcc = [SELECT Name FROM Account WHERE Id = :acc.Id];
        System.assertEquals('After Update Test', updatedAcc.Name, 'Account name should be updated.');
    }
    
    @isTest
    static void testBeforeDelete() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();
        delete acc;
        Test.stopTest();
        
        Integer count = [SELECT COUNT() FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, count, 'Account should be deleted.');
    }
    
    @isTest
    static void testAfterDelete() {
        Account acc = new Account(Name = 'Delete Test');
        insert acc;
        
        Test.startTest();
        delete acc;
        Test.stopTest();
        
        Integer count = [SELECT COUNT() FROM Account WHERE Id = :acc.Id];
        System.assertEquals(0, count, 'Account should be deleted.');
    }
    
    @isTest
    static void testAfterUndelete() {
        Account acc = new Account(Name = 'Undelete Test');
        insert acc;
        delete acc;
        
        Test.startTest();
        undelete acc;
        Test.stopTest();
        
        Account undeletedAcc = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        System.assertNotEquals(null, undeletedAcc.Id, 'Account should be undeleted.');
    }
}

// handler : 100%
// trigger : 100%