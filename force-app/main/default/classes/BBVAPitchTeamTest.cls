/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase BBVAPitchTeamHandler
* Revision
*/
@isTest
public class BBVAPitchTeamTest {

  /*
  * Testeo clase BBVAPitchTeamHandler
  */
  @isTest
  public static void bbvaPitchTeamHandlerTest() {

    //Declaracion del usuario
    User userTest = PitchUtilTest.createUser();
    insert userTest;

    //Declaracion de la cuenta
    Account acc= PitchUtilTest.createAccount();
    insert acc;

    //Declaracion del pitch
    List<Pitch__c> pitchList = new List<Pitch__c>();
    Pitch__c pitchTest = PitchUtilTest.createPitch(acc);
    pitchList.add(pitchTest);
    insert pitchList;

    //Declaracion del grupo
    Group groupTest = PitchUtilTest.createPitchGroup(pitchList[0]);
    insert groupTest;

    //Declaracion del equipo del pitch
    List<BBVA_Pitch_Team__c> pitchTeamList = new List<BBVA_Pitch_Team__c>();
    BBVA_Pitch_Team__c pitchTeam = PitchUtilTest.createPitchTeam(pitchList[0],userTest);
    pitchTeamList.add(pitchTeam);
    insert pitchTeamList;

    //Declaracion del share del pitch
    Pitch__Share pitchShareTest = PitchUtilTest.pitchShareTest(pitchList[0],pitchTeamList[0]);
    insert pitchShareTest;

    Test.startTest();
    BBVAPitchTeamHandler pitchHandler = new BBVAPitchTeamHandler();
    pitchHandler.completePublicGroup(pitchTeamList);
    pitchHandler.getGroupMember(pitchTeamList);
    System.assertNotEquals(pitchShareTest,null,'No hay share del pitch');
    Test.stopTest();
  }
}