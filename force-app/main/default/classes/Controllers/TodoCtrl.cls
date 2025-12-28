/**
 * @description Controller class for managing Todo Items in Lightning Components.
 */
public with sharing class TodoCtrl {
  /**
   * @description Retrieves a list of incomplete Todo Items related to a specific record.
   * @param relatedRecordId The ID of the related record to filter Todo Items.
   * @return A list of incomplete Todo_Item__c records.
   */
  @AuraEnabled(cacheable=true)
  public static List<Todo_Item__c> getTodoItems(String relatedRecordId) {
    List<Todo_Item__c> todoItems = new TodoItemSelector()
      .selectByRelatedRecordIdAndIsNotComplete(
        new Set<String>{ relatedRecordId },
        100
      );
    return todoItems;
  }
}
