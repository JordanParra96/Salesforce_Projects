/**
 * @description Controller class for managing Todo Items in Lightning Components.
 */
public with sharing class TodoCtrl {
  /**
   * @description Retrieves a list of incomplete Todo Items related to a specific record.
   * @param relatedRecordId The ID of the related record to filter Todo Items.
   * @return A list of incomplete Todo_Item__c records.
   * @throws AuraHandledException if any error occurs during the query.
   */
  @AuraEnabled(cacheable=true)
  public static List<Todo_Item__c> getTodoItems(String relatedRecordId) {
    return [
      SELECT Id, Name, Is_Complete__c, Due_Date__c, RelatedRecordId__c
      FROM Todo_Item__c
      WHERE RelatedRecordId__c = :relatedRecordId AND Is_Complete__c = FALSE
      WITH USER_MODE
      ORDER BY Due_Date__c
    ];
  }
}
