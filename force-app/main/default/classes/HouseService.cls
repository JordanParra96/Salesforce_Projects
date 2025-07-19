/**
 * @description  Service class for handling House__c records.
 */
public with sharing class HouseService {
  /**
   * @description Retrieves a list of House__c records with selected fields, limited to 10.
   * @return List of House__c records.
   */
  @AuraEnabled(cacheable=true)
  public static List<House__c> getRecords() {
    try {
      // Create a Unit Of Work
      fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
        new List<Schema.SObjectType>{ House__c.SObjectType }
      );
      // Create a list of House records from a SOQL query
      List<House__c> lstHouses = new HousesSelector().selectAll(10);
      return lstHouses;
    }
    // Code to handle exception
    catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }
}
