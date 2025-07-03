/**
 * @description
 * This trigger is responsible for handling events on the Account object.
 */
trigger AccountsTrigger on Account(
  after delete,
  after insert,
  after update,
  before delete,
  before insert,
  before update
) {
  fflib_SObjectDomain.triggerHandler(Accounts.class);
}
