/************************************************************************
Name:            VisitRelPitchTriggerHandler
Description:     Handler del trigger de Visit Topic
Test Class:

Version        Date            Author            Summary of changes
---------------------------------------------------------------------------------------------
1              22/08/2018      Global Desktop    Class creation
*************************************************************************/
global without sharing class VisitRelPitchTriggerHandler {

  /*
  * @author Global Desktop
  * @Description Inserta los miembros del equipo de la oportunidad relacionada en el equipo del pitch
  */
  global void completePitchTeam(List<dwp_kitv__Visit_Topic__c > visitTopicList) {
    if(visitTopicList.size() <= 1) {
      final List<dwp_kitv__Visit_Management_Team__c> visitTeamList = [SELECT dwp_kitv__user_id__c,
                                                                      dwp_kitv__user_id__r.Name
                                                                      FROM dwp_kitv__Visit_Management_Team__c
                                                                      WHERE dwp_kitv__visit_id__c = :visitTopicList[0].dwp_kitv__visit_id__c];

      List<BBVA_Pitch_Team__c> allPitchTeamList = [SELECT Id, external_user_id__c, external_reference_id__c
                                                  FROM BBVA_Pitch_Team__c
                                                  WHERE external_reference_id__c =: visitTopicList[0].pitch_visit_topic_id__c];
      map<String, String> pitchUser = new map<String, String>();
      for(BBVA_Pitch_Team__c allPitchTeam : allPitchTeamList) {
        pitchUser.put(allPitchTeam.external_user_id__c, allPitchTeam.external_user_id__c);
      }

      final List<BBVA_Pitch_Team__c> pitchTeamList = new List<BBVA_Pitch_Team__c>();
      for(dwp_kitv__Visit_Management_Team__c visitTeam : visitTeamList) {
        if(pitchUser.get(visitTeam.dwp_kitv__user_id__c) == null) {
          BBVA_Pitch_Team__c pitchTeam = new BBVA_Pitch_Team__c();
          pitchTeam.external_reference_id__c = visitTopicList[0].pitch_visit_topic_id__c;
          pitchTeam.external_user_id__c = visitTeam.dwp_kitv__user_id__c;
          pitchTeamList.add(pitchTeam);
        }
      }
      insert pitchTeamList;
    }
  }
}