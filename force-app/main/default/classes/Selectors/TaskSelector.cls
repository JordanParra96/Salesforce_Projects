/**
 * @description Selector class for Task object.
 */
public with sharing class TaskSelector extends fflib_SObjectSelector {
  /**
   * @description Returns a list of SObject fields to be selected.
   * @return List<Schema.SObjectField> - List of SObject fields for Task.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{ Task.Subject, Task.OwnerId };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Task.
   */
  public Schema.SObjectType getSObjectType() {
    return Task.sObjectType;
  }

  /**
   * @description Selects Task records by their IDs.
   * @param idSet - Set of IDs to select Task by.
   * @return List<Task> - List of Task records matching the provided IDs.
   */
  public List<Task> selectById(Set<ID> idSet) {
    return (List<Task>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all Task records without any limit.
   * @return List<Task> - List of all Task records.
   */
  public List<Task> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Task records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Task> - List of Task records up to the specified limit.
   */
  public List<Task> selectAll(Integer recordLimit) {
    return (List<Task>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
