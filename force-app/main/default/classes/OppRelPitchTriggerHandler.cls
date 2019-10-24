/********************************************************************************************
Name:            OppRelPitchTriggerHandler
Description:     Handler del trigger OppRelPitchTrigger
Test Class:

Version        Date            Author            Summary of changes
---------------------------------------------------------------------------------------------
1              16/08/2018      Global Desktop    Class creation
*********************************************************************************************/
global without sharing class OppRelPitchTriggerHandler {

    /*
    * @author Global Desktop
    * @Description Inserta los miembros del equipo de la oportunidad relacionada en el equipo del pitch
    */
    global void completePitchTeam(List<Related_opportunity_pitch__c > oppPitchList) {
        if(oppPitchList.size() <= 1) {
            final List<OpportunityTeamMember> oppTeamList = [SELECT UserId, User.Name, TeamMemberRole
                                                        FROM OpportunityTeamMember
                                                        WHERE OpportunityId = :oppPitchList[0].opportunity_pitch_id__c];

            //////////////////////////////
            //Pitch__c pitch = [SELECT Id FROM Pitch__c WHERE Id =: oppPitchList[0].pitch_opportunity_id__c LIMIT 1];
            List<BBVA_Pitch_Team__c> allPitchTeamList = [SELECT Id, external_user_id__c, external_reference_id__c
                                                    FROM BBVA_Pitch_Team__c
                                                    WHERE external_reference_id__c =: oppPitchList[0].pitch_opportunity_id__c];
            map<String, String> pitchUser = new map<String, String>();
            for(BBVA_Pitch_Team__c allPitchTeam : allPitchTeamList) {
                pitchUser.put(allPitchTeam.external_user_id__c, allPitchTeam.external_user_id__c);
            }

            //////////////////////////////

            final List<BBVA_Pitch_Team__c> pitchTeamList = new List<BBVA_Pitch_Team__c>();
            for(OpportunityTeamMember oppTeam : oppTeamList) {
                if(pitchUser.get(oppTeam.UserId) == null) {
                    BBVA_Pitch_Team__c pitchTeam = new BBVA_Pitch_Team__c();
                    pitchTeam.external_reference_id__c = oppPitchList[0].pitch_opportunity_id__c;
                    pitchTeam.external_user_id__c = oppTeam.UserId;
                    //pitchTeam.Name = oppTeam.User.Name;
                    pitchTeam.role_desc__c = oppTeam.TeamMemberRole;
                    pitchTeamList.add(pitchTeam);
                }
            }
            insert pitchTeamList;
        }
    }

}