/**
 * @description Selector class for OrderItem records.
 */
public with sharing class OrderItemSelector extends fflib_SObjectSelector {
  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for OrderItem.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      OrderItem.OrderId,
      OrderItem.PricebookEntryId,
      OrderItem.Description,
      OrderItem.UnitPrice
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for OrderItem.
   */
  public Schema.SObjectType getSObjectType() {
    return OrderItem.sObjectType;
  }

  /**
   * @description Selects OrderItem records by their IDs.
   * @param idSet - Set of IDs to select OrderItem records by.
   * @return List<OrderItem> - List of OrderItem records matching the provided IDs.
   */
  public List<OrderItem> selectById(Set<ID> idSet) {
    return (List<OrderItem>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects OrderItem records by their Order IDs.
   * @param orderIdSet - Set of Order IDs to select OrderItem records by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<OrderItem> - List of OrderItem records matching the provided Order IDs.
   */
  public List<OrderItem> selectByOrderId(
    Set<Id> orderIdSet,
    Integer recordLimit
  ) {
    return (List<OrderItem>) Database.query(
      newQueryFactory()
        .setCondition('OrderId IN :orderIdSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all OrderItem records without any limit.
   * @return List<OrderItem> - List of all OrderItem records.
   */
  public List<OrderItem> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all OrderItem records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<OrderItem> - List of OrderItem records.
   */
  public List<OrderItem> selectAll(Integer recordLimit) {
    return (List<OrderItem>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
