trigger CreateContactOnAccountCreation on Account (after insert) {
    if (Trigger.isInsert){
        CreateContactOnAccountCreationHandler.createContact(Trigger.new);
    }
}