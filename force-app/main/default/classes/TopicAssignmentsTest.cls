/**
 * @description Test class for Topic Assignement domain class.
 */
@isTest
private class TopicAssignmentsTest {
  /**
   * @description Test method for TopicAssignments domain class constructor
   * and onAfterInsert method.
   */
  @isTest
  static void onAfterInsert() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{
        Account.SObjectType,
        FeedItem.SObjectType,
        Topic.SObjectType,
        TopicAssignment.SObjectType
      }
    );

    Account testAccount = new Account(Name = 'Test Account');
    uow.registerNew(testAccount);
    // Create a test feed item
    FeedItem testFeedItem = new FeedItem(
      Body = 'Test FeedItem Body',
      Title = 'Test FeedItem Title'
    );
    uow.registerNew(testFeedItem, FeedItem.ParentId, testAccount);

    Topic testTopic = new Topic(Name = 'TestAlert');
    uow.registerNew(testTopic);

    TopicAssignment testTopicAssignment = new TopicAssignment();

    uow.registerRelationship(
      testTopicAssignment,
      TopicAssignment.TopicId,
      testTopic
    );

    uow.registerNew(
      testTopicAssignment,
      TopicAssignment.EntityId,
      testFeedItem
    );
    Test.startTest();
    uow.commitWork();
    Test.stopTest();
    // Verify that the TopicAssignment was created
    List<TopicAssignment> topicAssignments = new TopicAssignmentsSelector()
      .selectById(new Set<Id>{ testTopicAssignment.Id });
    System.assertEquals(
      1,
      topicAssignments.size(),
      'One TopicAssignment should be created'
    );
    System.assertEquals(
      testFeedItem.Id,
      topicAssignments[0].EntityId,
      'EntityId should match the FeedItem Id'
    );
    System.assertEquals(
      testTopic.Id,
      topicAssignments[0].TopicId,
      'TopicId should match the Topic Id'
    );
  }
}
