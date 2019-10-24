/********************************************************************************************
Name:            PitchTriggerHandler
Description:     Handler del trigger PitchTrigger
Test Class:

Version        Date            Author            Summary of changes
---------------------------------------------------------------------------------------------
1              12/08/2018      Global Desktop    Class creation
*********************************************************************************************/
global without sharing class PitchTriggerHandler {

    /*
    * @author Global Desktop
    * @Description Guarda al owner del pitch en el equipo del pitch
    */
    global void ownerToTeam(List<Pitch__c> pitchList) {
        final set<Id> ownerIds = new set<Id>();
        for(Pitch__c iPitch : pitchList) {
            ownerIds.add(iPitch.OwnerId);
        }

        final List<User> userList = [SELECT Id, Name FROM User WHERE Id IN :ownerIds];
        final map<Id,User> idUser = new map<Id,User>();
        for(User user : userList) {
            idUser.put(user.Id, user);
        }

        final List<BBVA_Pitch_Team__c> pitchTeamList =  new List<BBVA_Pitch_Team__c>();
        for(Pitch__c pitch : pitchList) {
            BBVA_Pitch_Team__c pitchTeam = new BBVA_Pitch_Team__c();
            pitchTeam.external_reference_id__c = pitch.Id;
            pitchTeam.external_user_id__c = pitch.OwnerId;
            pitchTeam.Owner__c = true;
            //pitchTeam.Name = idUser.get(pitch.OwnerId).Name;
            pitchTeamList.add(pitchTeam);
        }
        insert pitchTeamList;
    }

    /*
    * @author Global Desktop
    * @Description Crea el grupo publico vaciio del pitch con el nombre igual al Id del pitch
    */
    global void publicGroupCreation (List<Pitch__c> pitchList) {
        final List<Group> groupList = new List<Group>();
        final Map<Id,Pitch__c> mapPitch = new Map<Id,Pitch__c>();
        for(Pitch__c pitch : pitchList) {
            mapPitch.put(pitch.Id,pitch);
            Group newGroup = new Group();
            newGroup.Name = pitch.Id;
            groupList.add(newGroup);
        }
        insert groupList;
        pitchShareCreation(groupList,mapPitch);
    }

    /*
    * @author Global Desktop
    * @Description Crea el share del registro del pitch y lo enlaza con el grupo creado anteriormente
    */
    public void pitchShareCreation(List<Group> groupList, Map<Id,Pitch__c> mapPitch) {
        final List<Pitch__Share> shareList = new List<Pitch__Share>();
        for(Group iGroup : groupList) {
            Pitch__Share pShare = new Pitch__Share();
            pShare.ParentId = mapPitch.get(iGroup.Name).Id;
            pShare.UserOrGroupId = iGroup.Id;
            pShare.AccessLevel = 'Edit';
            shareList.add(pShare);
        }
        insert shareList;
    }

}