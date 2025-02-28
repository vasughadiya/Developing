@isTest
private class AccountNameChangeAlertTest {
    
    @TestSetup
    static void setupTestDsta(){
        Account acc = new Account(Name = 'Old Account Name');
        insert acc;
    }
    
    @isTest
    static void emailAlertTest() {
        Test.startTest();
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        
        acc.Name += ' TEST';
        
        update acc;
        Test.stopTest();
        System.assertEquals(0, Limits.getEmailInvocations(), 'Emails should be sent');
    }
}

// handler : 57% (because of email task)
// trigger : 100%