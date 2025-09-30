trigger OrdersTrigger on Order(before update) {
  OrderItemUtility.addBonusBouquet(Trigger.new);
}
