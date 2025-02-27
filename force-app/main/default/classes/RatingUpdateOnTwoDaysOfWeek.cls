global with sharing class RatingUpdateOnTwoDaysOfWeek  implements Schedulable{
    
    
    public static void updateRating(){
        List<Account> accounts = [SELECT id, Rating FROM Account WHERE Type = 'Customer - Channel'];
        for (Account acc : accounts){
            acc.Rating = 'Warm';
        }
        update (accounts);
        System.debug('Account Rating updated');
    }
    
    global void execute(SchedulableContext s) {
        System.debug('Account Rating Updating');
        updateRating();
    }
    
    public RatingUpdateOnTwoDaysOfWeek() {
        
    }
}

// String cronExp = '0 0 18 ? * TUE-WED *';
// System.schedule('Rating Update On Two Days Of Week', cronExp, new RatingUpdateOnTwoDaysOfWeek());