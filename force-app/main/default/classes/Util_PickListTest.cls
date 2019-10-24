/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase Util_PickList
* Revision
*/
@isTest
public class Util_PickListTest {

  /*
  * Testeo clase Util_PickList
  */
  @isTest
  public static void getLabelTest() {
  Map<String, String> mapResult = Util_PickList.getLabelFromAPI('Account','Name');
  Util_PickList.getAPIFromLabel('Account','Name','Test');
  Account acc = new Account();
  Util_PickList.getselectOptions(acc, 'Name');
  System.assertNotEquals(mapResult,null,'Mapa no vacio');
  }

}