@IsTest(seeAllData=false)
private class TodoCtrlTest {
  @IsTest
  static void testGetTodoItemsFiltersAndOrder() {
    List<Todo_Item__c> todosForAcc1 = TestFactory.generateTodoItemsWithDates(
      new Map<String, Object>{
        'dueDates' => new List<Date>{
          Date.today().addDays(-5),
          Date.today().addDays(5)
        },
        'isComplete' => false,
        'doInsert' => true
      }
    );

    Todo_Item__c completedTodo = TestFactory.getAccountWithTodoItem(
      new Map<String, Object>{
        'name' => 'Completed Task',
        'dueDate' => Date.today().addDays(10),
        'isComplete' => true,
        'doInsert' => true
      }
    );

    Todo_Item__c otherTodo = TestFactory.getAccountWithTodoItem(
      new Map<String, Object>{
        'name' => 'Other Account Task',
        'dueDate' => Date.today(),
        'isComplete' => false,
        'doInsert' => true
      }
    );

    // Call the controller
    List<Todo_Item__c> results = TodoCtrl.getTodoItems(
      todosForAcc1[0].RelatedRecordId__c
    );

    // Assertions: only the two incomplete items for acc1 should be returned
    System.assertEquals(
      2,
      results.size(),
      'Should return two incomplete todo items for acc1'
    );

    // Ordered by Due_Date__c ascending
    System.assertEquals(
      todosForAcc1[0].Name,
      results[0].Name,
      'First item should be the past due item'
    );
    System.assertEquals(
      todosForAcc1[1].Name,
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
        todosForAcc1[0].RelatedRecordId__c,
        t.RelatedRecordId__c,
        'RelatedRecordId__c should match the requested record'
      );
    }
  }

  @IsTest
  static void testGetTodoItemsReturnsEmptyForNoMatches() {
    // Create an account but no todo items for it
    Account acc = TestFactory.getAccount('Empty Account', true);

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

  @IsTest
  static void testGetTodoItemsWithMixedItems() {
    List<Todo_Item__c> todos = TestFactory.generateMixedTodoItems(
      new Map<String, Object>{
        'numComplete' => 3,
        'numIncomplete' => 5,
        'doInsert' => true
      }
    );

    // Get todos - should only return incomplete ones
    List<Todo_Item__c> results = TodoCtrl.getTodoItems(
      todos[0].RelatedRecordId__c
    );

    System.assertEquals(
      5,
      results.size(),
      'Should return only incomplete items'
    );

    for (Todo_Item__c todo : results) {
      System.assertEquals(
        false,
        todo.Is_Complete__c,
        'All returned todos should be incomplete'
      );
    }
  }
}
