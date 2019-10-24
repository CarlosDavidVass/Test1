/********************************************************************************************
Name:            BBVAPitchTeamHandler
Description:     Handler del trigger BBVAPitchTeam
Test Class:

Version        Date            Author            Summary of changes
---------------------------------------------------------------------------------------------
1              12/08/2018      Global Desktop    Class creation
*********************************************************************************************/
global without sharing class BBVAPitchTeamHandler {

  /*
    * @author Global Desktop
    * @Description Busca los nuevos usuarios incluidos al equipo del pitch
    */
    global void completePublicGroup(List<BBVA_Pitch_Team__c> pitchTeamList) {
      final List<Group> groupRecord = [SELECT Id FROM Group WHERE Name = :pitchTeamList[0].external_reference_id__c LIMIT 1];
      final set<Id> usersId = new set<Id>();
      for(BBVA_Pitch_Team__c pitchTeam : pitchTeamList) {
        usersId.add(pitchTeam.external_user_id__c);
      }
      insertMemberGroup(usersId,groupRecord[0].Id);
    }

    /*
    * @author Global Desktop
    * @Description Inserta los groupMember
    */
    @future
    public static void insertMemberGroup(set<Id> usersId,Id groupRecord) {
      final List<GroupMember> groupMemberList = new List<GroupMember>();
      for(Id userId : usersId) {
        GroupMember groupMember = new GroupMember();
      groupMember.GroupId = groupRecord;
      groupMember.UserOrGroupId  = userId;
      groupMemberList.add(groupMember);
      }
      insert groupMemberList;
    }

    /*
    * @author Global Desktop
    * @Description Recupera el usuario y el grupo relacionado con el registro que se quiere borrar.
    */
    global void getGroupMember(List<BBVA_Pitch_Team__c> pitchTeamList) {
      final Id userId = pitchTeamList[0].external_user_id__c;
      final Id groupId = [SELECT Id FROM Group WHERE Name = :pitchTeamList[0].external_reference_id__c LIMIT 1].Id;
    deleteGroupMember(userId, groupId);
    }

    /*
    * @author Global Desktop
    * @Description Borra del grupo al usuario borrado del equipo del pitch
    */
    @future
    public static void deleteGroupMember(Id userId, Id groupId) {
      final List<GroupMember> groupMemberList = [SELECT Id
                        FROM GroupMember
                        WHERE GroupId = :groupId
                        AND UserOrGroupId = :userId LIMIT 1];
      delete groupMemberList[0];
    }

}