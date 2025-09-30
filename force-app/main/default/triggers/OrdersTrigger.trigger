/**
 * @description
 * This trigger is responsible for handling events on the Order object.
 */
trigger OrdersTrigger on Order(
  after insert,
  after update,
  before delete,
  before insert,
  before update
) {
  fflib_SObjectDomain.triggerHandler(Orders.class);
}
