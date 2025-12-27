@IsTest(seeAllData=false)
private class TodoCtrlTest {
  @IsTest
  static void testGetTodoItemsFiltersAndOrder() {
    // Create two parent records to verify filtering by RelatedRecordId__c
    Account acc1 = new Account(Name = 'Test Account 1');
    Account acc2 = new Account(Name = 'Test Account 2');
    insert new List<Account>{ acc1, acc2 };

    // Create todo items for acc1 (one past, one future) and one completed item that should be excluded
    Todo_Item__c pastTodo = new Todo_Item__c(
      Name = 'Past Task',
      RelatedRecordId__c = acc1.Id,
      Due_Date__c = Date.today().addDays(-2),
      Is_Complete__c = false
    );

    Todo_Item__c futureTodo = new Todo_Item__c(
      Name = 'Future Task',
      RelatedRecordId__c = acc1.Id,
      Due_Date__c = Date.today().addDays(5),
      Is_Complete__c = false
    );

    Todo_Item__c completedTodo = new Todo_Item__c(
      Name = 'Completed Task',
      RelatedRecordId__c = acc1.Id,
      Due_Date__c = Date.today().addDays(10),
      Is_Complete__c = true
    );

    // A todo for acc2 which should not be returned when querying acc1
    Todo_Item__c otherTodo = new Todo_Item__c(
      Name = 'Other Account Task',
      RelatedRecordId__c = acc2.Id,
      Due_Date__c = Date.today(),
      Is_Complete__c = false
    );

    insert new List<Todo_Item__c>{
      pastTodo,
      futureTodo,
      completedTodo,
      otherTodo
    };

    // Call the controller
    List<Todo_Item__c> results = TodoCtrl.getTodoItems(acc1.Id);

    // Assertions: only the two incomplete items for acc1 should be returned
    System.assertEquals(
      2,
      results.size(),
      'Should return two incomplete todo items for acc1'
    );

    // Ordered by Due_Date__c ascending: pastTodo should come before futureTodo
    System.assertEquals(
      pastTodo.Name,
      results[0].Name,
      'First item should be the past due item'
    );
    System.assertEquals(
      futureTodo.Name,
      results[1].Name,
      'Second item should be the future item'
    );

    // Ensure none of the returned items are marked complete
    for (Todo_Item__c t : results) {
      System.assertEquals(
        false,
        t.Is_Complete__c,
        'Returned items must be incomplete'
      );
      System.assertEquals(
        acc1.Id,
        t.RelatedRecordId__c,
        'RelatedRecordId__c should match the requested record'
      );
    }
  }

  @IsTest
  static void testGetTodoItemsReturnsEmptyForNoMatches() {
    // Create an account but no todo items for it
    Account acc = new Account(Name = 'Empty Account');
    insert acc;

    List<Todo_Item__c> results = TodoCtrl.getTodoItems(acc.Id);
    System.assertNotEquals(
      null,
      results,
      'Method should return a list (possibly empty)'
    );
    System.assertEquals(
      0,
      results.size(),
      'No todo items should be returned for this account'
    );

    // Also verify passing null returns an empty list rather than throwing
    List<Todo_Item__c> nullResults = TodoCtrl.getTodoItems(null);
    System.assertNotEquals(
      null,
      nullResults,
      'Method should return a list (possibly empty) even when passed null'
    );
    System.assertEquals(
      0,
      nullResults.size(),
      'No todo items should be returned when relatedRecordId is null'
    );
  }
}
