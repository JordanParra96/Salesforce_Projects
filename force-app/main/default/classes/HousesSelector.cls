/**
 * @description This class is used to select House records from the database.
 */
public with sharing class HousesSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for HousessSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      House__c.Name,
      House__c.Address__c,
      House__c.State__c,
      House__c.City__c,
      House__c.Zip__c
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for House__c.
   */
  public Schema.SObjectType getSObjectType() {
    return House__c.sObjectType;
  }

  /**
   * @description Selects Account records by their IDs.
   * @param idSet - Set of IDs to select Houses by.
   * @return List<House__c> - List of House__c records matching the provided IDs.
   */
  public List<House__c> selectById(Set<ID> idSet) {
    return (List<House__c>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all House__c records.
   * @param recordLimit - Maximum number of records to return.
   * @return List<House__c> - List of House__c records.
   */
  public List<House__c> selectAll(Integer recordLimit) {
    return (List<House__c>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
