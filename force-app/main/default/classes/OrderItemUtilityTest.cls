/**
 * @description Test class for OrderItemUtility
 */
@IsTest
private class OrderItemUtilityTest {
  /**
   * @description Test method for OrderItemUtility class method addBonusBouquet.
   */
  @IsTest
  static void onBeforeUpdate() {
    Account testAccount = TestFactory.getAccount('Test Account', true);

    Product2 testProduct = TestFactory.generateSpecificProducts(
      new List<String>{ 'BOT-BB-12' },
      true
    )[0];

    Pricebook2 pr = new Pricebook2();
    pr.Name = 'Jhon';
    pr.IsActive = true;
    insert pr;

    String prID2 = Test.getStandardPricebookId();

    PricebookEntry standardPbe = new PricebookEntry(
      Pricebook2Id = prID2,
      Product2Id = testProduct.Id,
      UnitPrice = 100.00,
      IsActive = true
    );
    insert standardPbe;

    Order testOrder = new Order(
      AccountId = testAccount.Id,
      EffectiveDate = Date.today(),
      Status = 'Draft',
      Pricebook2Id = prID2
    );
    insert testOrder;

    testOrder.Status = 'Activated';

    Test.startTest();
    update testOrder;
    Test.stopTest();

    List<OrderItem> orderItems = [
      SELECT Id, OrderId, PricebookEntryId, Description, UnitPrice
      FROM OrderItem
      WHERE OrderId = :testOrder.Id
    ];

    System.assertEquals(
      1,
      orderItems.size(),
      'One bonus bouquet should be added to the order'
    );
    System.assertEquals(
      'FREE Bouquet',
      orderItems[0].Description,
      'The description of the bonus bouquet should be "FREE Bouquet"'
    );
    System.assertEquals(
      0.00,
      orderItems[0].UnitPrice,
      'The unit price of the bonus bouquet should be 0.00'
    );
  }
}
