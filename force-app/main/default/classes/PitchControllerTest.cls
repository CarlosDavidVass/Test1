/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase BBVAPitchTeamHandler
* Revision
*/
@isTest
public class PitchControllerTest {

  /*
  * Testeo clase BBVAPitchTeamHandler
  */
  @isTest
  public static void pitchCreatedControllerTest() {

    //Declaracion de la cuenta
    Account acc= PitchUtilTest.createAccount();
    insert acc;

    //Declaracion del pitch
    List<Pitch__c> pitchList = new List<Pitch__c>();
    Pitch__c pitchTest = PitchUtilTest.createPitch(acc);
    pitchList.add(pitchTest);
    insert pitchList;

    Test.startTest();
    PitchController.getInstance();
    PitchController.getCreated(String.valueOf(pitchList[0].Id));
    System.assertNotEquals(pitchList,null,'Pitch vacio');
    Test.stopTest();
  }

}