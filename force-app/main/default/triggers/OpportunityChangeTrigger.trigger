/**
 * @description
 * This trigger is responsible for handling events on the OpportunityChangeEvent object.
 */
trigger OpportunityChangeTrigger on OpportunityChangeEvent(after insert) {
  OpportunityChanges oppChangeHandler = new OpportunityChanges(Trigger.new);
  oppChangeHandler.handleAfterInsert();
}
