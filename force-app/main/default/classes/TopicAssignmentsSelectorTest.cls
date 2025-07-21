/**
 * @description Test class for the TopicAssignmentsSelector class.
 */
@isTest
private class TopicAssignmentsSelectorTest {
  /**
   * @description Setup method to create test data.
   * This method is executed before each test method in this class.
   */
  @TestSetup
  static void makeData() {
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

    uow.commitWork();
  }
  /**
   * @description Test method for selecting TopicAssignment by ID.
   */
  @isTest
  static void selectById() {
    // Select TopicAssignments by ID
    Set<Id> topicAssignmentIds = new Set<Id>();
    for (TopicAssignment ta : [SELECT Id FROM TopicAssignment]) {
      topicAssignmentIds.add(ta.Id);
    }
    List<TopicAssignment> topicAssignments = new TopicAssignmentsSelector()
      .selectById(topicAssignmentIds);
    System.assertEquals(1, topicAssignments.size());
  }

  /**
   * @description Test method for selecting all TopicAssignments.
   */
  @isTest
  static void selectAll() {
    // Select TopicAssignments by ID
    Set<Id> topicAssignmentIds = new Set<Id>();
    for (TopicAssignment ta : [SELECT Id FROM TopicAssignment]) {
      topicAssignmentIds.add(ta.Id);
    }
    List<TopicAssignment> topicAssignments = new TopicAssignmentsSelector()
      .selectAll(100);
    System.assertEquals(1, topicAssignments.size());
  }

  /**
   * @description Test method for selecting TopicAssignments by Topic Name.
   */
  @isTest
  static void selectByTopicName() {
    List<TopicAssignment> topicAssignments = new TopicAssignmentsSelector()
      .selectByTopicName([SELECT Id FROM TopicAssignment], 'TestAlert', 100);
    System.assertEquals(1, topicAssignments.size());
    System.assertEquals('TestAlert', topicAssignments[0].Topic.Name);
  }
}
