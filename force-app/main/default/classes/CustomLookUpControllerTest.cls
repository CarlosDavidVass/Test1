/*
* Author         Global Desktop
* Date           2019/10/04
* Description    Test de la clase CustomLookUpController
* Revision
*/
@isTest
public class CustomLookUpControllerTest {

  /*
  * Testeo clase CustomLookUpController
  */
  @isTest
  public static void lookUpCntTest() {
  List<Account> accList = CustomLookUpController.fetchLookUpValues('aaa', 'Account', 'GTB', true, true, 'Name', '', true, '', '');
  CustomLookUpController.fetchLookUpValues('aaa', 'Account', 'GTB', true, true, 'Name', '', false, '', '');
  CustomLookUpController.fetchLookUpValues('aaa', 'Account', 'GTB', false, true, 'Name', '', true, '', '');
  CustomLookUpController.fetchLookUpValues('aaa', 'Account', 'GTB', true, true, 'Name', '', true, '', 'Name');
  System.assertNotEquals(accList,null,'Lista no vacia');
  }

}