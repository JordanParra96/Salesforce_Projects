/**
 * @description Selector class for Employee__c object.
 */
public with sharing class EmployeeSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for EmployeeSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Employee__c.Name,
      Employee__c.OwnerId,
      Employee__c.Last_Name__c,
      Employee__c.First_Name__c,
      Employee__c.Tenure__c
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Employee__c.
   */
  public Schema.SObjectType getSObjectType() {
    return Employee__c.sObjectType;
  }

  /**
   * @description Selects Employee records by their IDs.
   * @param idSet - Set of IDs to select Employees by.
   * @return List<Employee__c> - List of Employee records matching the provided IDs.
   */
  public List<Employee__c> selectById(Set<ID> idSet) {
    return (List<Employee__c>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all Employee records up to a specified limit.
   * @return List<Employee__c> - List of all Employee records.
   */
  public List<Employee__c> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Employee records up to a specified limit.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Employee__c> - List of all Employee records.
   */
  public List<Employee__c> selectAll(Integer recordLimit) {
    return (List<Employee__c>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
