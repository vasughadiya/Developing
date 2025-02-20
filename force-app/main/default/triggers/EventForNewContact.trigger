trigger EventForNewContact on Contact (before insert) {
    if (Trigger.isInsert){
        EventForNewContactHandler.createEvent(Trigger.new);
    }
}