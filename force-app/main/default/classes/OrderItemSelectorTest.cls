/**
 * @description Test class for OrderItemSelector
 */
@isTest
private class OrderItemSelectorTest {
  /**
   * @description Setup method to create test data.
   */
  @TestSetup
  static void makeData() {
    TestFactory.generateOrderItems(3, true);
  }

  /**
   * @description Test method for PrivateObjectSelector class.
   */
  @isTest
  static void selectById() {
    List<OrderItem> oiList = new OrderItemSelector().selectAll(3);
    list<OrderItem> ois = new OrderItemSelector()
      .selectById(new Set<Id>{ oiList[0].Id, oiList[1].Id, oiList[2].Id });

    System.assertEquals(
      3,
      ois.size(),
      'Should select 3 OrderItem records by ID'
    );
  }

  /**
   * @description Test method for selecting OrderItem records by OrderId.
   */
  @isTest
  static void selectByOrderId() {
    List<OrderItem> oiList = new OrderItemSelector().selectAll(3);
    list<OrderItem> ois = new OrderItemSelector()
      .selectByOrderId(new Set<Id>{ oiList[0].OrderId }, 10);

    System.assert(
      ois.size() >= 1,
      'Should select at least 1 OrderItem record by Order ID'
    );
  }

  /**
   * @description Test method for selecting all OrderItem records.
   */
  @isTest
  static void selectAll() {
    List<OrderItem> ois = new OrderItemSelector().selectAll();
    System.assert(
      ois.size() >= 3,
      'Should select at least 3 OrderItem records in total'
    );
  }

  /**
   * @description Test method for selecting all OrderItem records with a limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<OrderItem> ois = new OrderItemSelector().selectAll(2);
    System.assertEquals(
      2,
      ois.size(),
      'Should select exactly 2 OrderItem records'
    );
  }
}
