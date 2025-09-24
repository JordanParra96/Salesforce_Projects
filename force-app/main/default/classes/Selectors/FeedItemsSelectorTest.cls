/**
 * @description Test class for the FeedItemsSelector class.
 */
@isTest
private class FeedItemsSelectorTest {
  /**
   * @description Test method for selecting Users by ID.
   */
  @isTest
  static void selectById() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType, FeedItem.SObjectType }
    );

    Account testAccount = new Account(Name = 'Test Account');
    uow.registerNew(testAccount);
    for (Integer j = 0; j < 2; j++) {
      FeedItem f = new FeedItem(
        Body = 'Test FeedItem ' + j,
        Title = 'Test Title' + j
      );
      uow.registerNew(f, FeedItem.ParentId, testAccount);
    }

    uow.commitWork();

    // Select FeedItems by ID
    Set<Id> feedIds = new Set<Id>();
    for (FeedItem f : [SELECT Id FROM FeedItem]) {
      feedIds.add(f.Id);
    }
    List<FeedItem> feedItems = new FeedItemsSelector().selectById(feedIds);
    System.assertEquals(2, feedItems.size());
    for (FeedItem f : feedItems) {
      System.assertNotEquals(null, f.Body);
      System.assertNotEquals(null, f.Title);
    }
  }

  /**
   * @description Test method for selecting all FeedItems.
   */
  @isTest
  static void selectAll() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Account.SObjectType, FeedItem.SObjectType }
    );

    Account testAccount = new Account(Name = 'Test Account');
    uow.registerNew(testAccount);
    for (Integer j = 0; j < 2; j++) {
      FeedItem f = new FeedItem(
        Body = 'Test FeedItem ' + j,
        Title = 'Test Title' + j
      );
      uow.registerNew(f, FeedItem.ParentId, testAccount);
    }
    uow.commitWork();
    System.assertEquals(2, [SELECT Id FROM FeedItem].size());
    List<FeedItem> feedItems = new FeedItemsSelector().selectAll(10);
    System.assertEquals(2, feedItems.size());
    for (FeedItem f : feedItems) {
      System.assertNotEquals(null, f.Body);
      System.assertNotEquals(null, f.Title);
    }
  }
}
