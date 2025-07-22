/**
 * @description This class is used to select FeedItem records from the database.
 */
public with sharing class FeedItemsSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for UsersSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      FeedItem.Body,
      FeedItem.Title,
      FeedItem.ParentId
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for FeedItem.
   */
  public Schema.SObjectType getSObjectType() {
    return FeedItem.sObjectType;
  }

  /**
   * @description Selects FeedItem records by their IDs.
   * @param idSet - Set of IDs to select FeedItem by.
   * @return List<FeedItem> - List of FeedItem records matching the provided IDs.
   */
  public List<FeedItem> selectById(Set<ID> idSet) {
    return (List<FeedItem>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects all FeedItem records.
   * @param recordLimit - Maximum number of records to return.
   * @return List<FeedItem> - List of FeedItem records.
   */
  public List<FeedItem> selectAll(Integer recordLimit) {
    return (List<FeedItem>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
