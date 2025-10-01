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

    Pricebook2 pr = TestFactory.generatePricebooks(1, true)[0];

    String prID2 = Test.getStandardPricebookId();

    Map<String, Object> pbParams = new Map<String, Object>{
      'pbId' => prID2,
      'product' => testProduct,
      'unitPrice' => 100.00,
      'isActive' => true,
      'doInsert' => true
    };

    PricebookEntry standardPbe = TestFactory.getPricebookEntry(pbParams);

    Map<String, Object> orderParams = new Map<String, Object>{
      'account' => testAccount,
      'effectiveDate' => Date.today(),
      'status' => 'Draft',
      'pbId' => prID2,
      'doInsert' => true
    };

    Order testOrder = TestFactory.getOrder(orderParams);

    testOrder.Status = 'Activated';

    Test.startTest();
    update testOrder;
    Test.stopTest();

    List<OrderItem> orderItems = new OrderItemSelector()
      .selectByOrderId(new Set<Id>{ testOrder.Id }, 10);

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
