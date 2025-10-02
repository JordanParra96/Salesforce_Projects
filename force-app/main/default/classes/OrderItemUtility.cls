/**
 * @description OrderItemUtility class to add a free bouquet when an order is activated
 */
public with sharing class OrderItemUtility {
  /**
   * @description Class method to add a bonus bouquet to an order when its status is updated to 'Activated'.
   * @param ordersFromTrigger List of Order records from the trigger context.
   */
  public static void addBonusBouquet(List<Order> ordersFromTrigger) {
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ OrderItem.SObjectType }
    );

    List<Product2> bonusProductList = new ProductSelector()
      .selectByProductCode(new Set<String>{ 'BOT-BB-12' }, 1);

    Product2 bonusProduct = new Product2();

    if (bonusProductList.size() > 0) {
      bonusProduct = bonusProductList[0];
      List<PricebookEntry> entryList = new PricebookEntrySelector()
        .selectByProductId(new Set<Id>{ bonusProduct.Id }, 1);
      PricebookEntry entry = new PricebookEntry();

      if (entryList.size() > 0) {
        entry = entryList[0];
      }

      List<OrderItem> newBouquets = new List<OrderItem>();

      for (Order currentOrder : ordersFromTrigger) {
        if (currentOrder.Status == 'Activated') {
          OrderItem freeBouquet = new OrderItem(
            OrderId = currentOrder.id,
            PricebookEntryId = entry.id,
            numberOfFlowers__c = 3,
            description = 'FREE Bouquet',
            Quantity = 1,
            colorTheme__c = 'Spectacular Sunset',
            percentOfOpening__c = 0,
            UnitPrice = 0.00
          );
          newBouquets.add(freeBouquet);
          uow.registerNew(freeBouquet);
        }
      }

      uow.commitWork();
    }
  }
}
