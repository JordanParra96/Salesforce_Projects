/**
 * @description Domain class for TopicAssignments objects.
 */
public with sharing class TopicAssignments extends fflib_SObjectDomain {
  /**
   * @description Constructor for TopicAssignments domain class.
   * @param sOjectList List of TopicAssignment SObjects.
   */
  public TopicAssignments(list<TopicAssignment> sOjectList) {
    super(sOjectList);
  }

  /**
   * @description Factory method to create an instance of TopicAssignments.
   * @param sObjectList List of TopicAssignment SObjects.
   * @return An instance of TopicAssignments domain class.
   */
  public class Constructor implements fflib_SObjectDomain.IConstructable {
    /**
     * @description Constructs an instance of Accounts domain class.
     * @param sObjectList List of Account SObjects.
     * @return An instance of Accounts domain class.
     */
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new TopicAssignments(sObjectList);
    }
  }

  public override void onAfterInsert() {
    // Get FeedItem posts only
    Set<Id> feedIds = new Set<Id>();
    for (TopicAssignment ta : (List<TopicAssignment>) Records) {
      if (
        ta.EntityId.getSObjectType().getDescribe().getName().equals('FeedItem')
      ) {
        feedIds.add(ta.EntityId);
      }
    }

    // Load FeedItem bodies
    Map<Id, FeedItem> feedItems = new Map<Id, FeedItem>(
      new FeedItemsSelector().selectById(feedIds)
    );

    // Create messages for each FeedItem that contains the BearAlert topic
    List<String> messages = new List<String>();
    for (
      TopicAssignment ta : new TopicAssignmentsSelector()
        .selectByTopicName((List<TopicAssignment>) Records, 'BearAlert', 50000)
    ) {
      messages.add(
        feedItems.get(ta.EntityId).body.stripHtmlTags().abbreviate(255)
      );
    }

    // Publish messages as notifications
    List<Notification__e> notifications = new List<Notification__e>();
    for (String message : messages) {
      notifications.add(new Notification__e(Message__c = message));
    }

    List<Database.SaveResult> results = EventBus.publish(notifications);

    // Inspect publishing results
    for (Database.SaveResult result : results) {
      system.debug(
        LoggingLevel.INFO,
        'Notification published: ' +
          result.isSuccess() +
          ', ' +
          result.getErrors()
      );
    }
  }
}
