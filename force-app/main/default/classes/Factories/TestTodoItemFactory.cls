/**
 * @description A factory class for creating test Todo_Item__c records.
 */
@isTest
public class TestTodoItemFactory {
  /**
   * @description Generates a single Todo_Item__c with specified parameters.
   * @param params A map containing parameters for the Todo_Item__c:
   *               - name: The name of the Todo_Item__c.
   *               - relatedRecord: The related record (e.g., Account).
   *               - dueDate: The due date for the Todo_Item__c.
   *               - isComplete: Whether the Todo_Item__c is complete.
   *               - doInsert: Whether to insert the Todo_Item__c into the database.
   *               - uow: The unit of work to use for inserting the Todo_Item__c.
   * @return The created Todo_Item__c.
   */
  public static Todo_Item__c getTodoItem(Map<String, Object> params) {
    String name = (String) params.get('name');
    SObject relatedRecord = (SObject) params.get('relatedRecord');
    Date dueDate = (Date) params.get('dueDate');
    Boolean isComplete = (Boolean) params.get('isComplete');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    Todo_Item__c todoItem = new Todo_Item__c(
      Name = name,
      Due_Date__c = dueDate,
      Is_Complete__c = isComplete
    );

    if (doInsert) {
      uow.registerRelationship(
        todoItem,
        Todo_Item__c.RelatedRecordId__c,
        relatedRecord
      );
      uow.registerNew(todoItem);
      uow.commitWork();
    }

    return todoItem;
  }

  /**
   * @description Generates a specified number of Todo_Item__c records for a related record.
   * @param params A map containing parameters for the Todo_Item__c records:
   *               - numTodos: The number of Todo_Item__c records to create.
   *               - relatedRecord: The related record (e.g., Account).
   *               - doInsert: Whether to insert the Todo_Item__c records into the database.
   *               - uow: The unit of work to use for inserting the Todo_Item__c records.
   * @return An array of created Todo_Item__c records.
   */
  public static Todo_Item__c[] generateTodoItems(Map<String, Object> params) {
    Integer numTodos = (Integer) params.get('numTodos');
    SObject relatedRecord = (SObject) params.get('relatedRecord');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    List<Todo_Item__c> todos = new List<Todo_Item__c>();
    for (Integer i = 0; i < numTodos; i++) {
      Todo_Item__c todo = new Todo_Item__c(
        Name = 'Todo Item ' + i,
        Due_Date__c = Date.today().addDays(i),
        Is_Complete__c = false
      );
      todos.add(todo);
      uow.registerRelationship(
        todo,
        Todo_Item__c.RelatedRecordId__c,
        relatedRecord
      );
    }

    if (doInsert) {
      uow.registerNew(todos);
      uow.commitWork();
    }

    return todos;
  }

  /**
   * @description Generates a mix of complete and incomplete Todo_Item__c records for testing filtering.
   * @param params A map containing parameters for the Todo_Item__c records:
   *               - numComplete: The number of complete Todo_Item__c records to create.
   *               - numIncomplete: The number of incomplete Todo_Item__c records to create.
   *               - relatedRecordId: The Id of the related record (e.g., Account).
   *               - doInsert: Whether to insert the Todo_Item__c records into the database.
   *               - uow: The unit of work to use for inserting the Todo_Item__c records.
   * @return An array of created Todo_Item__c records (both complete and incomplete).
   */
  public static Todo_Item__c[] generateMixedTodoItems(
    Map<String, Object> params
  ) {
    Integer numComplete = (Integer) params.get('numComplete');
    Integer numIncomplete = (Integer) params.get('numIncomplete');
    String relatedRecordId = (String) params.get('relatedRecordId');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    List<Todo_Item__c> todos = new List<Todo_Item__c>();

    // Add incomplete todos
    for (Integer i = 0; i < numIncomplete; i++) {
      todos.add(
        new Todo_Item__c(
          Name = 'Incomplete Todo ' + i,
          RelatedRecordId__c = relatedRecordId,
          Due_Date__c = Date.today().addDays(i),
          Is_Complete__c = false
        )
      );
    }

    // Add complete todos
    for (Integer i = 0; i < numComplete; i++) {
      todos.add(
        new Todo_Item__c(
          Name = 'Complete Todo ' + i,
          RelatedRecordId__c = relatedRecordId,
          Due_Date__c = Date.today().addDays(-(i + 1)),
          Is_Complete__c = true
        )
      );
    }

    if (doInsert) {
      uow.registerNew(todos);
      uow.commitWork();
    }

    return todos;
  }

  /**
   * @description Generates Todo_Item__c records with specified due dates for testing date-based filtering and ordering.
   * @param params A map containing parameters for the Todo_Item__c records:
   *               - dueDates: A list of dates for the Todo_Item__c records.
   *               - relatedRecord: The related record (e.g., Account).
   *               - isComplete: Whether the generated Todo_Item__c records are complete.
   *               - doInsert: Whether to insert the Todo_Item__c records into the database.
   *               - uow: The unit of work to use for inserting the Todo_Item__c records.
   * @return An array of created Todo_Item__c records with specified due dates.
   */
  public static Todo_Item__c[] generateTodoItemsWithDates(
    Map<String, Object> params
  ) {
    List<Date> dueDates = (List<Date>) params.get('dueDates');
    SObject relatedRecord = (SObject) params.get('relatedRecord');
    Boolean isComplete = (Boolean) params.get('isComplete');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    List<Todo_Item__c> todos = new List<Todo_Item__c>();
    for (Integer i = 0; i < dueDates.size(); i++) {
      Todo_Item__c todo = new Todo_Item__c(
        Name = 'Todo Item ' + i,
        Due_Date__c = dueDates[i],
        Is_Complete__c = isComplete
      );
      todos.add(todo);
      uow.registerRelationship(
        todo,
        Todo_Item__c.RelatedRecordId__c,
        relatedRecord
      );
    }

    if (doInsert) {
      uow.registerNew(todos);
      uow.commitWork();
    }

    return todos;
  }
}
