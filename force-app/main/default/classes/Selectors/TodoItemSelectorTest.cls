/**
 * @description Test class for TodoItemSelector.
 */
@isTest
private class TodoItemSelectorTest {
  /**
   * @description Test method for selecting Todo Items by ID.
   */
  @isTest
  static void selectById() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Todo_Item__c.SObjectType }
    );

    List<Todo_Item__c> todoItemList = new List<Todo_Item__c>{
      new Todo_Item__c(
        Name = 'Test Todo 1',
        RelatedRecordId__c = null,
        Due_Date__c = Date.today().addDays(1),
        Is_Complete__c = false
      ),
      new Todo_Item__c(
        Name = 'Test Todo 2',
        RelatedRecordId__c = null,
        Due_Date__c = Date.today().addDays(2),
        Is_Complete__c = false
      )
    };
    uow.registerNew(todoItemList);
    uow.commitWork();
    Set<Id> todoItemIds = new Set<Id>{ todoItemList[0].Id, todoItemList[1].Id };
    List<Todo_Item__c> todoItems = new TodoItemSelector()
      .selectById(todoItemIds);
    System.assertEquals(
      2,
      todoItems.size(),
      'Should select 2 Todo Items by ID'
    );
  }

  /**
   * @description Test method for selecting all Todo Items.
   */
  @isTest
  static void selectAll() {
    List<Todo_Item__c> todoItems = new TodoItemSelector().selectAll();
    System.assertEquals(0, todoItems.size(), 'Should select all Todo Items');
  }

  /**
   * @description Test method for selecting all Todo Items with limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<Todo_Item__c> todoItems = new TodoItemSelector().selectAll(1);
    System.assertEquals(
      0,
      todoItems.size(),
      'Should select Todo Items with specified limit'
    );
  }

  /**
   * @description Test method for selecting Todo Items by RelatedRecordId__c and Is_Complete__c.
   */
  @isTest
  static void selectByRelatedRecordIdAndIsNotComplete() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Todo_Item__c.SObjectType }
    );

    String relatedRecordId1 = 'a'.repeat(15);
    String relatedRecordId2 = 'b'.repeat(15);

    List<Todo_Item__c> todoItemList = new List<Todo_Item__c>{
      new Todo_Item__c(
        Name = 'Test Todo 1',
        RelatedRecordId__c = relatedRecordId1,
        Due_Date__c = Date.today().addDays(1),
        Is_Complete__c = false
      ),
      new Todo_Item__c(
        Name = 'Test Todo 2',
        RelatedRecordId__c = relatedRecordId1,
        Due_Date__c = Date.today().addDays(2),
        Is_Complete__c = true
      ),
      new Todo_Item__c(
        Name = 'Test Todo 3',
        RelatedRecordId__c = relatedRecordId2,
        Due_Date__c = Date.today().addDays(3),
        Is_Complete__c = false
      )
    };
    uow.registerNew(todoItemList);
    uow.commitWork();

    Set<String> relatedRecordIds = new Set<String>{ relatedRecordId1 };
    List<Todo_Item__c> todoItems = new TodoItemSelector()
      .selectByRelatedRecordIdAndIsNotComplete(relatedRecordIds, 10);
    System.assertEquals(
      1,
      todoItems.size(),
      'Should select 1 Todo Item by RelatedRecordId__c and Is_Complete__c'
    );
  }
}
