/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase PitchTriggerHandler
* Revision
*/
@isTest
public class VisitRelPitchTriggerHandlerTest {

  @isTest
  public static void completePitchTeamTest() {

    //Declaracion del usuario
    List<User> userList = new List<User>();
    User userTest = PitchUtilTest.createUser();
    userList.add(userTest);
    User userTest2 = PitchUtilTest.createUser();
    userList.add(userTest2);
    insert userList;

    //Declaracion de la cuenta
    Account acc= PitchUtilTest.createAccount();
    insert acc;

    //Declaracion de la oportunidad
    Opportunity opp = PitchUtilTest.createOpportunity(acc);
    insert opp;

    //Declaracion del pitch
    List<Pitch__c> pitchList = new List<Pitch__c>();
    Pitch__c pitchTest = PitchUtilTest.createPitch(acc);
    pitchList.add(pitchTest);
    insert pitchList;

    //Declaracion del equipo del pitch
    List<BBVA_Pitch_Team__c> pitchTeamList = new List<BBVA_Pitch_Team__c>();
    BBVA_Pitch_Team__c pitchTeam = PitchUtilTest.createPitchTeam(pitchList[0],userList[0]);
    pitchTeamList.add(pitchTeam);
    insert pitchTeamList;

    //Declaracion de la visita
    dwp_kitv__Visit__c visitTest = PitchUtilTest.createVisit(acc,opp);
    insert visitTest;

    //Declaracion del equipo de la visita
    List<dwp_kitv__Visit_Management_Team__c> visitTeamList = new List<dwp_kitv__Visit_Management_Team__c>();
    dwp_kitv__Visit_Management_Team__c visitTeam = PitchUtilTest.createVisitTeam(visitTest,userList[0]);
    visitTeamList.add(visitTeam);
    dwp_kitv__Visit_Management_Team__c visitTeam2 = PitchUtilTest.createVisitTeam(visitTest,userList[1]);
    visitTeamList.add(visitTeam2);
    insert visitTeamList;

    //Declaracion del topic de la visita
    List<dwp_kitv__Visit_Topic__c> topicList = new List<dwp_kitv__Visit_Topic__c>();
    dwp_kitv__Visit_Topic__c visTopicTest = PitchUtilTest.createVisitTopic(visitTest,opp);
    visTopicTest.pitch_visit_topic_id__c = pitchList[0].Id;
    topicList.add(visTopicTest);
    insert topicList;

    Test.startTest();
    VisitRelPitchTriggerHandler visPitchHandler = new VisitRelPitchTriggerHandler();
    visPitchHandler.completePitchTeam(topicList);
    System.assertNotEquals(topicList,null,'Lista de topic de visita vacio');
    Test.stopTest();
  }

}