/**
 * @description Selector class for PricebookEntry SObject.
 * This class provides methods to query PricebookEntry records based on various criteria.
 * It extends the fflib_SObjectSelector to leverage common selector functionalities.
 */
public with sharing class PricebookEntrySelector extends fflib_SObjectSelector {
  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for PricebookEntry.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      PricebookEntry.Product2Id,
      PricebookEntry.Name
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Private_Object__c.
   */
  public Schema.SObjectType getSObjectType() {
    return PricebookEntry.sObjectType;
  }

  /**
   * @description Selects PricebookEntry records by their IDs.
   * @param idSet - Set of IDs to select PricebookEntry records by.
   * @return List<PricebookEntry> - List of PricebookEntry records matching the provided IDs.
   */
  public List<PricebookEntry> selectById(Set<ID> idSet) {
    return (List<PricebookEntry>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects PricebookEntry records by their associated Product2 IDs.
   * @param productIdSet - Set of Product2 IDs to select PricebookEntry records by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<PricebookEntry> - List of PricebookEntry records matching the provided Product2 IDs.
   */
  public List<PricebookEntry> selectByProductId(
    Set<Id> productIdSet,
    Integer recordLimit
  ) {
    return (List<PricebookEntry>) Database.query(
      newQueryFactory()
        .setCondition('Product2Id IN :productIdSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all PricebookEntry records without any limit.
   * @return List<PricebookEntry> - List of all PricebookEntry records.
   */
  public List<PricebookEntry> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all PricebookEntry records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<PricebookEntry> - List of PricebookEntry records.
   */
  public List<PricebookEntry> selectAll(Integer recordLimit) {
    return (List<PricebookEntry>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
