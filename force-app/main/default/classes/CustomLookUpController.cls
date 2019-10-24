/********************************************************************************
Name:            CustomLookUpController
Description:     Class CustomLookUpController
Test Class:

Version        Date            Author            Summary of changes
---------------------------------------------------------------------------------------------
1              12/08/2018      Global Desktop    Class creation
**********************************************************************************/
global with sharing class CustomLookUpController { //NOSONAR

  /*
  * @author Global Desktop
  * @Description Funcion principal del custom lookup
  */
  @SuppressWarnings('PMD')
  @AuraEnabled
  global static List < sObject > fetchLookUpValues(String searchKeyWord, String objectName, String productFamily, Boolean custom, Boolean equals, String searchField, String ipUserFilter, Boolean useSOSL,String useSOSLValidations, String useSOSLApiValidations) { //NOSONAR
    system.debug('ObjectName-->' + objectName);
    final String searchKey = searchKeyWord + '%';
    Set<String> setFields = new Set<String>();
    final List < sObject > returnList = new List < sObject > ();
    String sQuery = '';
    String soslQuery = '';

    // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
    try {
      if (custom) {
        String queryFields = 'id, ';
        queryFields +=  String.escapeSingleQuotes(searchField);
        final String ipUserFilterQuery = ipUserFilterEmpty(ipUserFilter);
        Integer whereIterator=0;
        string whereValues ='';
        if (useSOSL) {
          String searchTerms = '';
          for (String search : searchKeyWord.split(' ')) {
            searchTerms = auxMethod1(search,searchTerms);
          }
          for (String validations : useSOSLValidations.split(';')) {
              if(!String.isEmpty(validations)) {
                  setFields.add(validations);
              }
          }
          List<String> lstField = new List<String>(setFields);
          String fields = '';
          soslQuery = auxMethod4(useSOSLApiValidations, objectName, queryFields, soslQuery, searchTerms, fields, whereIterator, lstField, whereValues);
        } else {
          sQuery = auxMethod3(equals, sQuery, queryFields, objectName, searchField, searchKeyWord, searchKey, ipUserFilterQuery);
        }
      } else {
        sQuery = auxMethod5(objectName, searchKey, productFamily, sQuery);
      }
      List<sObject> lstOfRecords = new List<sObject>();
      if(soslQuery != '') {
        List<List<SObject>> searchList = new List<List<SObject>>();
        searchList = Search.query(soslQuery);
        lstOfRecords = searchList[0];
      } else {
        system.debug('Query -->' + sQuery);
        lstOfRecords = Database.query(sQuery); //NOSONAR
      }
      returnList.addAll(lstOfRecords);
      return returnList;
    } catch (Exception e) {
      throw new AuraHandledException(e.getLineNumber() + ': ' + e.getMessage()); //NOSONAR
    }
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 1
  */
  private static String auxMethod1(String search, String searchTerms) {
    if(!String.isEmpty(search)) {
      if(!String.isEmpty(searchTerms)) {
        searchTerms += ' AND ';
      }
      searchTerms += '\'' + String.valueOf(search) + '\'';
      System.debug('mid searchTerms -> ' + searchTerms);
    }
    return searchTerms;
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 5
  */
  private static String auxMethod5(String objectName, String searchKey, String productFamily, String sQuery) {
    if(objectName == Label.ObjectName_Product2) {
      sQuery =  'SELECT id, Name FROM ' +String.escapeSingleQuotes(objectName) + ' WHERE Name LIKE :searchKey AND Family LIKE :productFamily ORDER BY createdDate DESC LIMIT 5';
    } else if (objectName == Label.ObjectName_User) {
      sQuery =  'SELECT id, Name FROM ' +String.escapeSingleQuotes(objectName) + ' WHERE isActive = true AND Name LIKE :searchKey ORDER BY createdDate DESC LIMIT 5';
    } else {
      sQuery =  'SELECT id, Name FROM ' +String.escapeSingleQuotes(objectName) + ' WHERE Name = :searchKey ORDER BY createdDate DESC LIMIT 5';
    }
    return sQuery;
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 4
  */
  @SuppressWarnings('PMD')
  private static String auxMethod4(String useSOSLApiValidations, String objectName, String queryFields, String soslQuery, String searchTerms, String fields, Integer whereIterator, List<String> lstField, String whereValues) {
    if(String.isEmpty(useSOSLApiValidations)){
      fields =  String.escapeSingleQuotes(objectName) + '('+ queryFields + ' ORDER BY createdDate DESC) LIMIT 5';
      soslQuery = 'FIND :searchTerms IN NAME FIELDS RETURNING ' + fields;
    }else{
      whereValues = auxMethod2(useSOSLApiValidations, whereIterator, lstField, whereValues);
      System.debug(whereValues);
      fields =  String.escapeSingleQuotes(objectName) + '('+ queryFields +whereValues+') ORDER BY createdDate DESC) LIMIT 5';
      soslQuery = 'FIND :searchTerms IN NAME FIELDS RETURNING ' + fields ;
    }
    return soslQuery;
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 2
  */
  private static String auxMethod2(String useSOSLApiValidations, Integer whereIterator, List<String> lstField, String whereValues) {
    for(String apinames : useSOSLApiValidations.split(';')){
      System.debug(whereIterator);
      if(whereIterator > 0){
        whereValues += 'AND '+String.escapeSingleQuotes(apinames)+' NOT IN:lstField';
      }else if(whereIterator ==0){
        whereValues +=   ' WHERE('+String.escapeSingleQuotes(apinames)+' NOT IN:lstField ';
      }
      whereIterator++;
    }
    return whereValues;
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 3
  */
  @SuppressWarnings('PMD')
  private static String auxMethod3(Boolean equals, String sQuery, String queryFields, String objectName, String searchField, String searchKeyWord, String searchKey, String ipUserFilterQuery) { //NOSONAR
    if (equals) {
      sQuery =  'SELECT '+ queryFields + ' FROM ' +String.escapeSingleQuotes(objectName) + ' WHERE ' + String.escapeSingleQuotes(searchField) + ' = :searchKeyWord ORDER BY createdDate DESC LIMIT 5';
    } else {
      sQuery =  'SELECT '+ queryFields + ' FROM ' +String.escapeSingleQuotes(objectName) + ' WHERE ' + String.escapeSingleQuotes(searchField) + ' LIKE :searchKey ' + ipUserFilterQuery + ' ORDER BY createdDate DESC LIMIT 5';
    }
    return sQuery;
  }

  /*
  * @author Global Desktop
  * @Description Funcion auxiliar 4
  */
  private static String ipUserFilterEmpty(String ipUserFilter) { //NOSONAR
    String ipUserFilterAux = ipUserFilter;
    if(ipUserFilterAux == null) {
        ipUserFilterAux = '';
    }
    return ipUserFilterAux;
  }
}