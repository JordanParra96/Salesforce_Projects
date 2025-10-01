/**
 * @description Test class for ProductSelector
 */
@isTest
public with sharing class ProductSelectorTest {
  /**
   * @description Setup method to create test data.
   */
  @TestSetup
  static void makeData() {
    TestFactory.generateProducts(5, true);
  }

  /**
   * @description Test method for ProductSelector class.
   */
  @isTest
  static void selectById() {
    List<Product2> products = new ProductSelector().selectAll(5);
    List<Product2> selectedProducts = new ProductSelector()
      .selectById(
        new Set<Id>{ products[0].Id, products[1].Id, products[2].Id }
      );

    System.assertEquals(
      3,
      selectedProducts.size(),
      'Should select 3 Product2 records by ID'
    );
  }

  /**
   * @description Test method for selecting Product2 records by name.
   */
  @isTest
  static void selectByName() {
    Set<String> nameSet = new Set<String>{ 'Product 0', 'Product 1' };
    List<Product2> products = new ProductSelector().selectByName(nameSet, 10);

    System.assertEquals(
      2,
      products.size(),
      'Should select 2 Product2 records by name'
    );
  }

  /**
   * @description Test method for selecting Product2 records by product code.
   */
  @isTest
  static void selectByProductCode() {
    Set<String> productCodeSet = new Set<String>{ 'PCode0', 'PCode1' };
    List<Product2> products = new ProductSelector()
      .selectByProductCode(productCodeSet, 10);

    System.assertEquals(
      2,
      products.size(),
      'Should select 2 Product2 records by product code'
    );
  }

  /**
   * @description Test method for selecting all Product2 records.
   */
  @isTest
  static void selectAll() {
    List<Product2> products = new ProductSelector().selectAll();

    System.assert(
      products.size() >= 5,
      'Should select at least 5 Product2 records in total'
    );
  }

  /**
   * @description Test method for selecting all Product2 records with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<Product2> products = new ProductSelector().selectAll(3);
    System.assertEquals(
      3,
      products.size(),
      'Should select 3 Product2 records when limit is set to 3'
    );
  }
}
