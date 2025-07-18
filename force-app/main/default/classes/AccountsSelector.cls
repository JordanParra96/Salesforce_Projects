/**
 * @description This class is used to select Account records from the database.
 */
public with sharing class AccountsSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for AccountsSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Account.Name,
      Account.Description,
      Account.AnnualRevenue
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Account.
   */
  public Schema.SObjectType getSObjectType() {
    return Account.sObjectType;
  }

  /**
   * @description Selects Account records by their IDs.
   * @param idSet - Set of IDs to select Accounts by.
   * @return List<Account> - List of Account records matching the provided IDs.
   */
  public List<Account> selectById(Set<ID> idSet) {
    return (List<Account>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects Account records by their names.
   * @param nameSet - Set of names to select Accounts by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Account> - List of Account records matching the provided names.
   */
  public List<Account> selectByName(Set<String> nameSet, Integer recordLimit) {
    return (List<Account>) Database.query(
      newQueryFactory()
        .setCondition('Name IN :nameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }
}
