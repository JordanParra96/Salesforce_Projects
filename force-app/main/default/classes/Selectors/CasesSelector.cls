/**
 * @description This class is used to select Case records from the database.
 */
public with sharing class CasesSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for CasesSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Case.IsClosed,
      Case.Status,
      Case.reason
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Case.
   */
  public Schema.SObjectType getSObjectType() {
    return Case.sObjectType;
  }

  /**
   * @description Selects Case records by their IDs.
   * @param idSet - Set of IDs to select Case by.
   * @return List<Case> - List of Case records matching the provided IDs.
   */
  public List<Case> selectById(Set<ID> idSet) {
    return (List<Case>) selectSObjectsById(idSet);
  }
}
