public with sharing class EventForNewContactHandler {
    
    public static void createEvent(List<Contact> newContacts) {
        List<Event> events = new List<Event>();
        
        for (Contact con : newContacts) {
            if (con.Id != null) {
                DateTime startTime = System.now().addDays(1);
                DateTime endTime = startTime.addHours(1);
                Event newEvent = new Event(
                    WhoId = con.Id,
                    Subject = 'Event for ' + con.FirstName + ' ' + con.LastName,
                    StartDateTime = startTime,
                    EndDateTime = endTime,
                    OwnerId = con.OwnerId,
                    Description = 'Auto-generated event for new contact'
                );
                events.add(newEvent);
            }
        }
        
        if (!events.isEmpty()) {
            try {
                insert events;
            } catch (DmlException e) {
                System.debug('Error inserting Events: ' + e.getMessage());
            }
        }
    }
    
    public EventForNewContactHandler() {
        
    }
}