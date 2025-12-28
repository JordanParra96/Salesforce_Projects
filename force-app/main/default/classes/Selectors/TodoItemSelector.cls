/**
 * @description Selector class for Todo_Item__c SObject
 */
public with sharing class TodoItemSelector extends fflib_SObjectSelector {
  /**
   * @description Returns a list of SObject fields to be selected.
   * @return List<Schema.SObjectField> - List of SObject fields for Todo_Item__c.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Todo_Item__c.Is_Complete__c,
      Todo_Item__c.Due_Date__c,
      Todo_Item__c.Name,
      Todo_Item__c.RelatedRecordId__c
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Todo_Item__c.
   */
  public Schema.SObjectType getSObjectType() {
    return Todo_Item__c.sObjectType;
  }

  /**
   * @description Selects Todo_Item__c records by their IDs.
   * @param idSet - Set of IDs to select Todo_Item__c by.
   * @return List<Todo_Item__c> - List of Todo_Item__c records matching the provided IDs.
   */
  public List<Todo_Item__c> selectById(Set<ID> idSet) {
    return (List<Todo_Item__c>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all Todo_Item__c records without any limit.
   * @return List<Todo_Item__c> - List of all Todo_Item__c records.
   */
  public List<Todo_Item__c> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Todo_Item__c records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Todo_Item__c> - List of Todo_Item__c records up to the specified limit.
   */
  public List<Todo_Item__c> selectAll(Integer recordLimit) {
    return (List<Todo_Item__c>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }

  /**
   * @description Selects Todo_Item__c records by RelatedRecordId__c and where Is_Complete__c is false.
   * @param relatedRecordIdSet - Set of RelatedRecordId__c values to filter by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Todo_Item__c> - List of Todo_Item__c records matching the criteria.
   */
  public List<Todo_Item__c> selectByRelatedRecordIdAndIsNotComplete(
    Set<String> relatedRecordIdSet,
    Integer recordLimit
  ) {
    return (List<Todo_Item__c>) Database.query(
      newQueryFactory()
        .setCondition(
          'RelatedRecordId__c IN :relatedRecordIdSet AND Is_Complete__c = false'
        )
        .setLimit(recordLimit)
        .setOrdering('Due_Date__c', fflib_QueryFactory.SortOrder.ASCENDING)
        .toSOQL()
    );
  }
}
