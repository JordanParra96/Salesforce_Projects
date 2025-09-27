/**
 * @description Selector class for Private_Object__c records.
 */
public with sharing class PrivateObjectSelector extends fflib_SObjectSelector {
  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Private_Object__c.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Private_Object__c.Account__c,
      Private_Object__c.Notes__c,
      Private_Object__c.Name
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Private_Object__c.
   */
  public Schema.SObjectType getSObjectType() {
    return Private_Object__c.sObjectType;
  }

  /**
   * @description Selects Private_Object__c records by their IDs.
   * @param idSet - Set of IDs to select Private_Object__c records by.
   * @return List<Private_Object__c> - List of Private_Object__c records matching the provided IDs.
   */
  public List<Private_Object__c> selectById(Set<ID> idSet) {
    return (List<Private_Object__c>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects Private_Object__c records by their names.
   * @param nameSet - Set of names to select Private_Object__c records by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Private_Object__c> - List of Private_Object__c records matching the provided names.
   */
  public List<Private_Object__c> selectByName(
    Set<String> nameSet,
    Integer recordLimit
  ) {
    return (List<Private_Object__c>) Database.query(
      newQueryFactory()
        .setCondition('Name IN :nameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all Private_Object__c records without any limit.
   * @return List<Private_Object__c> - List of all Private_Object__c records.
   */
  public List<Private_Object__c> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Private_Object__c records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Private_Object__c> - List of Private_Object__c records.
   */
  public List<Private_Object__c> selectAll(Integer recordLimit) {
    return (List<Private_Object__c>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
