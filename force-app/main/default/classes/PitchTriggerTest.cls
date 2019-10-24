/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase PitchTriggerHandler
* Revision
*/
@isTest
public class PitchTriggerTest {

  @isTest
  public static void ownerToTeamTest() {

    //Declaracion de la cuenta
    Account acc= PitchUtilTest.createAccount();
    insert acc;

    //Declaracion del pitch
    List<Pitch__c> pitchList = new List<Pitch__c>();
    Pitch__c pitchTest = PitchUtilTest.createPitch(acc);
    pitchList.add(pitchTest);
    insert pitchList;

    Test.startTest();
    PitchTriggerHandler pitchHandler = new PitchTriggerHandler();
    pitchHandler.ownerToTeam(pitchList);
    pitchHandler.publicGroupCreation(pitchList);
    System.assertNotEquals(pitchList,null,'Pitch nulo');
    Test.stopTest();
  }
}