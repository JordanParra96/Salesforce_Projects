/**
 * @description This class is used to select User records from the database.
 */
public with sharing class UsersSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for UsersSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      User.FirstName,
      User.LastName,
      User.Name
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for User.
   */
  public Schema.SObjectType getSObjectType() {
    return User.sObjectType;
  }

  /**
   * @description Selects User records by their IDs.
   * @param idSet - Set of IDs to select Users by.
   * @return List<User> - List of User records matching the provided IDs.
   */
  public List<User> selectById(Set<ID> idSet) {
    return (List<User>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all User records.
   * @param recordLimit - Maximum number of records to return.
   * @return List<User> - List of User records.
   */
  public List<User> selectAll(Integer recordLimit) {
    return (List<User>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }

  /**
   * @description Selects User records by their lastname.
   * @param lastnameSet - Set of lastnames to select Users by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<User> - List of User records matching the provided lastnames.
   */
  public List<User> selectByLastname(
    Set<String> lastnameSet,
    Integer recordLimit
  ) {
    return (List<User>) Database.query(
      newQueryFactory()
        .setCondition('lastName IN :lastnameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }
}
