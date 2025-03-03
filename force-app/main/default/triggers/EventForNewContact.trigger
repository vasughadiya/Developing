trigger EventForNewContact on Contact (after insert) {
    if (Trigger.isInsert){
        EventForNewContactHandler.createEvent(Trigger.new);
    }
}