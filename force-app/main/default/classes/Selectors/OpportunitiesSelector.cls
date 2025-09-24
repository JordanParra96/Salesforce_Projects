/**
 * @description This class is used to select Opportunity records from the database.
 */
public with sharing class OpportunitiesSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for OpportunitiesSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Opportunity.Amount,
      Opportunity.AccountId
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Opportunity.
   */
  public Schema.SObjectType getSObjectType() {
    return Opportunity.sObjectType;
  }

  /**
   * @description Selects Opportunity records by their IDs.
   * @param idSet - Set of IDs to select Opportunity by.
   * @return List<Account> - List of Opportunity records matching the provided IDs.
   */
  public List<Opportunity> selectById(Set<ID> idSet) {
    return (List<Opportunity>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects Opportunity records by their names.
   * @param nameSet - Set of names to select Opportunities by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Opportunity> - List of Opportunity records matching the provided names.
   */
  public List<Opportunity> selectByName(
    Set<String> nameSet,
    Integer recordLimit
  ) {
    return (List<Opportunity>) Database.query(
      newQueryFactory()
        .setCondition('Name IN :nameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all Opportunity records without any limit.
   * @return List<Opportunity> - List of all Opportunity records.
   */
  public List<Opportunity> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Opportunity records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Opportunity> - List of Opportunity records.
   */
  public List<Opportunity> selectAll(Integer recordLimit) {
    return (List<Opportunity>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }

  /**
   * @description Selects Opportunity records by their Account IDs.
   * @param accountIds - Set of Account IDs to select Opportunities by.
   * @return List<Opportunity> - List of Opportunity records matching the provided Account IDs.
   */
  public List<Opportunity> selectByAccountId(Set<Id> accountIds) {
    return (List<Opportunity>) Database.query(
      newQueryFactory().setCondition('AccountId IN :accountIds').toSOQL()
    );
  }
}
