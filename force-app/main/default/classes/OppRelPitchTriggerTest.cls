/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase OppRelPitchTriggerHandler
* Revision
*/
@isTest
public class OppRelPitchTriggerTest {

  /*
  * Testeo clase OppRelPitchTriggerHandler
  */
  @isTest
  public static void oppRelPitchTriggerHandlerTest() {

    //Declaracion del usuario
    User userTest = PitchUtilTest.createUser();
    insert userTest;
    User userTest2 = PitchUtilTest.createUser();
    insert userTest2;

    //Declaracion de la cuenta
    Account acc= PitchUtilTest.createAccount();
    insert acc;

    //Declaracion del pitch
    List<Pitch__c> pitchList = new List<Pitch__c>();
    Pitch__c pitchTest = PitchUtilTest.createPitch(acc);
    pitchList.add(pitchTest);
    insert pitchList;

    //Declaracion de la oportunidad
    Opportunity opp = PitchUtilTest.createOpportunity(acc);
    insert opp;

    //Declaracion de la relacion entre oportunidad y pitch
    List<Related_opportunity_pitch__c> oppPitchListTest = new List<Related_opportunity_pitch__c>();
    Related_opportunity_pitch__c oppPitchTest = PitchUtilTest.createRelOppPitch(opp,pitchList[0]);
    oppPitchListTest.add(oppPitchTest);
    insert oppPitchListTest;

    //Declaracion del equipo de la oportunidad
    List<OpportunityTeamMember> oppTeamMemberList = new List<OpportunityTeamMember>();
    OpportunityTeamMember oppTeamMember = PitchUtilTest.createOppTeam(opp,userTest);
    oppTeamMemberList.add(oppTeamMember);
    OpportunityTeamMember oppTeamMember2 = PitchUtilTest.createOppTeam(opp,userTest2);
    oppTeamMemberList.add(oppTeamMember2);
    insert oppTeamMemberList;

    Test.startTest();
    OppRelPitchTriggerHandler pitchTrigger = new OppRelPitchTriggerHandler();
    pitchTrigger.completePitchTeam(oppPitchListTest);
    System.assertNotEquals(oppTeamMemberList,null,'Equipo de la oportunidad vacio');
    Test.stopTest();
  }
}