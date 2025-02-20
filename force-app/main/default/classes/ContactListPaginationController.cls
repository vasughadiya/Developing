public with sharing class ContactListPaginationController {
    public Integer pageSize = 10;
    public Integer pageNumber = 1;
    public List<Contact> getContacts() {
        return [SELECT Id, Name, Account.Name,Email FROM Contact LIMIT :pageSize OFFSET :((pageNumber-1) * pageSize)];
    }

    public Boolean getDisablePrevious() {
        return pageNumber == 1;
    }

    public Boolean getDisableNext() {
        Integer totalContacts = [SELECT COUNT() FROM Contact];
        return (pageNumber * pageSize) >= totalContacts;
    }

    public void next() {
        pageNumber++;
    }

    public void previous() {
        pageNumber--;
    }



    public ContactListPaginationController() {

    }
}