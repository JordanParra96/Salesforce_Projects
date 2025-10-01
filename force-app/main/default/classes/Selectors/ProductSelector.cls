/**
 * @description This class is used to select Product records from the database.
 */
public with sharing class ProductSelector extends fflib_SObjectSelector {
  /**
   * @description Constructor for ProductSelector.
   * @return list<Schema.SObjectField> - List of SObject fields to be selected.
   */
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Product2.Name,
      Product2.ProductCode,
      Product2.IsActive
    };
  }

  /**
   * @description Returns the SObject type for the selector.
   * @return Schema.SObjectType - The SObject type for Product.
   */
  public Schema.SObjectType getSObjectType() {
    return Product2.sObjectType;
  }

  /**
   * @description Selects Product records by their IDs.
   * @param idSet - Set of IDs to select Products by.
   * @return List<Account> - List of Account records matching the provided IDs.
   */
  public List<Product2> selectById(Set<ID> idSet) {
    return (List<Product2>) selectSObjectsById(idSet);
  }

  /**
   * @description Selects Product records by their names.
   * @param nameSet - Set of names to select Products by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Product2> - List of Product records matching the provided names.
   */
  public List<Product2> selectByName(Set<String> nameSet, Integer recordLimit) {
    return (List<Product2>) Database.query(
      newQueryFactory()
        .setCondition('Name IN :nameSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects Product records by their product codes.
   * @param productCodeSet - Set of product codes to select Products by.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Product2> - List of Product records matching the provided product codes.
   */
  public List<Product2> selectByProductCode(
    Set<String> productCodeSet,
    Integer recordLimit
  ) {
    return (List<Product2>) Database.query(
      newQueryFactory()
        .setCondition('ProductCode IN :productCodeSet')
        .setLimit(recordLimit)
        .toSOQL()
    );
  }

  /**
   * @description Selects all Product records without any limit.
   * @return List<Product2> - List of all Product records.
   */
  public List<Product2> selectAll() {
    return this.selectAll(50000);
  }

  /**
   * @description Selects all Product records with a limit on the number of records returned.
   * @param recordLimit - Maximum number of records to return.
   * @return List<Product2> - List of Account records.
   */
  public List<Product2> selectAll(Integer recordLimit) {
    return (List<Product2>) Database.query(
      newQueryFactory().setLimit(recordLimit).toSOQL()
    );
  }
}
