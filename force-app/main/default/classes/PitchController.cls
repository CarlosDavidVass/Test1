global with sharing class PitchController {

    @AuraEnabled
    global static Boolean getCreated(String recordId){
        Pitch__c isRecentlyCreated = new Pitch__c();
        isRecentlyCreated = [SELECT gf_recent_pitch_type__C from Pitch__c where id=: recordId limit 1];
        return isRecentlyCreated.gf_recent_pitch_type__c;
    }
    /*SINGLETON PATTERN*/
    global static PitchController instance;
    /*global constructor*/
    global PitchController() {
    }
    /*SINGLETON PATTERN*/
    global static PitchController getInstance() { //NOSONAR
        if (instance == null) {
            instance = new PitchController();
        }
        return instance;
    }

}