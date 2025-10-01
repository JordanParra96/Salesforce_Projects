/**
 * @description A factory class for creating test Order records.
 */
@isTest
public class TestOrderFactory {
  /**
   * @description Generates an Order associated with the specified Account.
   * @param params A map containing parameters for the Order:
   *               - account: The Account to associate with.
   *               - effectiveDate: The effective date of the Order.
   *               - status: The status of the Order.
   *               - pbId: The Id of the Pricebook2 to associate with.
   *               - doInsert: Whether to insert the Order into the database.
   *               - uow: The unit of work to use for inserting the Order.
   * @return The created Order.
   */
  public static Order getOrder(Map<String, Object> params) {
    TestFactory.clearData();
    Account acc = (Account) params.get('account');
    Date effectiveDate = (Date) params.get('effectiveDate');
    String status = (String) params.get('status');
    String pbId = (String) params.get('pbId');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    Order o = new Order(
      EffectiveDate = effectiveDate,
      Status = status,
      Pricebook2Id = pbId
    );
    if (doInsert) {
      uow.registerRelationship(o, Order.AccountId, acc);
      uow.registerNew(o);
      uow.commitWork();
    }
    return o;
  }

  /**
   * @description Generates a specified number of OrderItem records associated with an Order and Product2.
   * @param numOrderItems The number of OrderItem records to create.
   * @param doInsert Whether to insert the OrderItem records into the database.
   * @param uow The unit of work to use for inserting the OrderItem records.
   * @return An array of created OrderItem records.
   */
  public static OrderItem[] generateOrderItems(
    Integer numOrderItems,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    Account accTest = TestFactory.getAccount('default account ltd', true);
    Order orderTest = TestFactory.getOrder(
      new Map<String, Object>{
        'account' => accTest,
        'effectiveDate' => Date.today(),
        'status' => 'Draft',
        'pbId' => Test.getStandardPricebookId(),
        'doInsert' => true
      }
    );

    Product2 prdTest = TestFactory.generateSpecificProducts(
      new List<String>{ 'BOT-BB-12' },
      true
    )[0];

    String prID2 = Test.getStandardPricebookId();

    PricebookEntry pbe = TestFactory.getPriceBookEntry(
      new Map<String, Object>{
        'pbId' => prID2,
        'product' => prdTest,
        'unitPrice' => 100.00,
        'isActive' => true,
        'doInsert' => true
      }
    );
    TestFactory.clearData();

    List<OrderItem> orderItems = new List<OrderItem>();

    for (Integer i = 0; i < numOrderItems; i++) {
      OrderItem oItem = new OrderItem(
        numberOfFlowers__c = 5,
        Description = 'FREE Bouquet',
        Quantity = 1,
        colorTheme__c = 'Spectacular Sunset',
        percentOfOpening__c = 0,
        UnitPrice = 0.00
      );
      orderItems.add(oItem);

      if (doInsert) {
        uow.registerRelationship(oItem, OrderItem.OrderId, orderTest);
        uow.registerRelationship(oItem, OrderItem.PricebookEntryId, pbe);
      }
    }
    if (doInsert) {
      uow.registerNew(orderItems);
      uow.commitWork();
    }
    return orderItems;
  }
}
