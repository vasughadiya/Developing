public with sharing class CreateContactOnAccountCreationHandler {
    
    public static void createContact(List<Account> accounts) {
        List<Contact> Contacts = new List<Contact>();
        
        for (Account acc : accounts) {
            if (acc.Id != null) {
                Contact con = new Contact(
                    AccountId = acc.Id,
                LastName = acc.Name
                    );
                Contacts.add(con);
            }
        }
        
        if (!Contacts.isEmpty()) {
            try {
                insert Contacts;
            } catch (DmlException e) {
                System.debug('Error inserting Contacts: ' + e.getMessage());
            }
        }
    }
    
    public CreateContactOnAccountCreationHandler() {
        
    }
}