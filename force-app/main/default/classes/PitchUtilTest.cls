/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Clase Util para los tests de Pitch
* Revision
*/
@isTest
public class PitchUtilTest {

  /*Nueva cuenta*/
  public static Account createAccount() {
    Account acc = new Account();
    acc.Name = 'Account Test';
    return acc;
  }

  /*Nuevo pitch*/
  public static Pitch__c createPitch(Account acc) {
    Pitch__c pitchTest = new Pitch__c();
    pitchTest.Name = 'Pitch Test';
    pitchTest.participant_id__c = acc.Id;
    pitchTest.solution_category_name__c = 'GTB';
    pitchTest.solution_name_path_desc__c = 'Cash Management';
    pitchTest.country_name__c = 'Spain';
    return pitchTest;
  }

  /*Nuevo grupo pitch*/
  public static Group createPitchGroup(Pitch__c pitchTest) {
    Group testGroup = new Group();
    testGroup.Name = pitchTest.Id;
    return testGroup;
  }

  /*Nuevo share del pitch*/
  public static Pitch__Share pitchShareTest(Pitch__c pitchTest, BBVA_Pitch_Team__c pitchTeamTest) {
    Pitch__Share pitchShareTest = new Pitch__Share();
    pitchShareTest.ParentId = pitchTest.Id;
    pitchShareTest.UserOrGroupId = pitchTeamTest.external_user_id__c;
    pitchShareTest.AccessLevel = 'Edit';
    return pitchShareTest;
  }

  /*Nuevo usuario*/
  public static User createUser() {
    Id profId = [Select Id from Profile Limit 1].Id;
    User userTest = new User();
    userTest.Lastname ='LastNameTest';
    userTest.Alias = 'Alias';
    userTest.Email = 'Alias@bbva.com';
    userTest.username = createUserName() + '@bbva.com';
    userTest.CommunityNickname = createUserName() + 'ComunityNickNameTest2';
    userTest.ProfileId = profId;
    userTest.EmailEncodingKey = 'UTF-8';
    userTest.Timezonesidkey='Europe/London';
    userTest.Localesidkey='en_US';
    userTest.languagelocalekey='en_US';
    return userTest;
  }

  /*Nuevo userName*/
  public static string createUserName() {
    return 'test_' + string.valueOf(system.now().hour()) + string.valueOf(system.now().minute()) + string.valueOf(system.now().second()) + string.valueOf(system.now().millisecond());
  }

  /*Nuevo equipo del pitch*/
  public static BBVA_Pitch_Team__c createPitchTeam(Pitch__c pitch, User userTest) {
    BBVA_Pitch_Team__c pitchTeam = new BBVA_Pitch_Team__c();
    pitchTeam.external_reference_id__c = pitch.Id;
    pitchTeam.external_user_id__c = userTest.Id;
    return pitchTeam;
  }

  /*Nueva oportunidad*/
  public static Opportunity createOpportunity(Account acc) {
    Opportunity oppTest = new Opportunity();
    oppTest.Name = 'Opportunity Test';
    oppTest.AccountId = acc.Id;
    oppTest.CloseDate = system.today();
    oppTest.StageName = 'Prospecting';
    return oppTest;
  }

  /*Nueva relacion entre oportunidad y pitch*/
  public static Related_opportunity_pitch__c createRelOppPitch(Opportunity opp, Pitch__c pitchTest) {
    Related_opportunity_pitch__c relPitchOpp = new Related_opportunity_pitch__c();
    relPitchOpp.opportunity_pitch_id__c = opp.Id;
    relPitchOpp.pitch_opportunity_id__c = pitchTest.Id;
    return relPitchOpp;
  }

  /*Nuevo miembro de la oportunidad*/
  public static OpportunityTeamMember createOppTeam(Opportunity opp, User userTest) {
    OpportunityTeamMember oppTeam = new OpportunityTeamMember();
    oppTeam.OpportunityId = opp.Id;
    oppTeam.UserId = userTest.Id;
    return oppTeam;
  }

  /*Nueva visita*/
  public static dwp_kitv__Visit__c createVisit(Account acc, Opportunity opp) {
    dwp_kitv__Visit__c vis = new dwp_kitv__Visit__c();
    vis.dwp_kitv__account_id__c= acc.Id;
    vis.Name = 'VISIT TEST';
    vis.dwp_kitv__visit_duration_number__c = '15';
    vis.dwp_kitv__visit_start_date__c = Date.today();
    return vis;
  }

  /*Nuevo VisitTopic*/
  public static dwp_kitv__Visit_Topic__c createVisitTopic(dwp_kitv__Visit__c vis, Opportunity opp) {
    dwp_kitv__Visit_Topic__c visTopic = new dwp_kitv__Visit_Topic__c();
    visTopic.dwp_kitv__visit_id__c = vis.Id;
    visTopic.dwp_kitv__opportunity_id__c = opp.id;
    visTopic.dwp_kitv__topic_desc__c = 'VISIT TOPIC TEST';
    return visTopic;
  }

  /*Nuevo miembro del equipo de la visita*/
  public static dwp_kitv__Visit_Management_Team__c createVisitTeam(dwp_kitv__Visit__c vis, User user) {
    dwp_kitv__Visit_Management_Team__c visTeam = new dwp_kitv__Visit_Management_Team__c();
    visTeam.dwp_kitv__visit_id__c = vis.Id;
    visTeam.dwp_kitv__user_id__c = user.Id;
    return visTeam;
  }

}