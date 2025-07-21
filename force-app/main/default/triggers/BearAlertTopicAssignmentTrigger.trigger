/**
 * @description
 * This trigger is responsible for handling events on the TopicAssignment object.
 */
trigger BearAlertTopicAssignmentTrigger on TopicAssignment(
  after delete,
  after insert,
  after update,
  before delete,
  before insert,
  before update
) {
  fflib_SObjectDomain.triggerHandler(TopicAssignments.class);
}
