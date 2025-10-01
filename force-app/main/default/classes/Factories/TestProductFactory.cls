/**
 * @description A factory class for creating test Product2 records.
 */
@isTest
public class TestProductFactory {
  /**
   * @description Generates a specified number of Product2 records.
   * @param numProducts The number of Product2 records to create.
   * @param doInsert Whether to insert the Product2 records into the database.
   * @param uow The unit of work to use for inserting the Product2 records.
   * @return An array of created Product2 records.
   */
  public static Product2[] generateProducts(
    Integer numProducts,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    List<Product2> products = new List<Product2>();
    for (Integer i = 0; i < numProducts; i++) {
      products.add(
        new Product2(
          Name = 'Product ' + i,
          ProductCode = 'PCode' + i,
          IsActive = true
        )
      );
    }
    if (doInsert) {
      uow.registerNew(products);
      uow.commitWork();
    }
    return products;
  }

  /**
   * @description Generates Product2 records with specified product codes.
   * @param productCodes A list of product codes for the Product2 records to create.
   * @param doInsert Whether to insert the Product2 records into the database.
   * @param uow The unit of work to use for inserting the Product2 records.
   * @return An array of created Product2 records.
   */
  public static Product2[] generateSpecificProducts(
    List<String> productCodes,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    List<Product2> products = new List<Product2>();
    for (String code : productCodes) {
      products.add(
        new Product2(
          Name = 'Product ' + code,
          ProductCode = code,
          IsActive = true
        )
      );
    }
    if (doInsert) {
      uow.registerNew(products);
      uow.commitWork();
    }
    return products;
  }
}
