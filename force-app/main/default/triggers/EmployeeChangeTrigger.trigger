/**
 * @description
 * This trigger is responsible for handling events on the Employee__ChangeEvent object.
 */
trigger EmployeeChangeTrigger on Employee__ChangeEvent(after insert) {
  EmployeeChanges empChangeHandler = new EmployeeChanges(Trigger.new);
  empChangeHandler.handleAfterInsert();
}
