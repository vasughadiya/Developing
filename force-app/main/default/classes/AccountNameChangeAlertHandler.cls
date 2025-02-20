public with sharing class AccountNameChangeAlertHandler {

    public static void sendEmailOnNameChange(List<Account> newAccounts, Map<Id, Account> oldAccountMap){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);
            if (oldAcc.Name != acc.Name) {
                List<Contact> contacts = [SELECT Email FROM Contact WHERE AccountId = :acc.Id AND Email != null];
                for (Contact con : contacts) {
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new List<String>{con.Email});
                    email.setSubject('Account Name Changed Notification');
                    email.setPlainTextBody('Hello,\n\nThe name of your account has been changed from "' + oldAcc.Name + '" to "' + acc.Name + '".\n\nThank you.');
                    emails.add(email);
                }
            }
        }
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }

    public AccountNameChangeAlertHandler() {

    }
}
