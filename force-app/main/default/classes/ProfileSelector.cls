/**
 * @description Selector class for Profile sObject.
 */
public with sharing class ProfileSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for ProfileSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{ Profile.Name };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Profile.
   */
  public Schema.SObjectType getSObjectType() {
    return Profile.sObjectType;
  }

  /**
   * @description Selects Profile records by their IDs.
   * @param idSet - Set of IDs to select Profiles by.
   * @return List<Profile> - List of Profile records matching the provided IDs.
   */
  public List<Profile> selectById(Set<ID> idSet) {
    return (List<Profile>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects Profile records by their names.
   * @param nameSet - Set of names to select Profiles by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Profile> - List of Profile records matching the provided names.
   */
  public List<Profile> selectByName(Set<String> nameSet, Integer recordLimit) {
    return (List<Profile>) Database.query(
      newQueryFactory()
        .setCondition('Name IN :nameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all profile records without any limit.
   * @return List<Profile> - List of all Profile records.
   */
  public List<Profile> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all profile records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Profile> - List of all Profile records.
   */
  public List<Profile> selectAll(Integer recordLimit) {
    return (List<Profile>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
