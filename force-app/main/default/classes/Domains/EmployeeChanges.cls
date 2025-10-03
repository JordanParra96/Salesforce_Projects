/**
 * @description Domain class for Employee Change Event objects.
 */
public with sharing class EmployeeChanges {
  public List<SObject> records;
  /**
   * @description Constructor for EmployeeChanges domain class.
   * @param sOjectList List of Employee Change Event SObjects.
   */
  public EmployeeChanges(List<SObject> sOjectList) {
    this.records = sOjectList;
  }

  /**
   * @description After insert trigger handler to process Employee Change Events.
   */
  public void handleAfterInsert() {
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ Task.SObjectType }
    );
    List<Task> tasks = new List<Task>();
    for (
      Employee__ChangeEvent emp : (List<Employee__ChangeEvent>) this.records
    ) {
      tasks.add(processEmployeeChangeEvent(emp));
      uow.registerNew(processEmployeeChangeEvent(emp));
    }

    if (tasks.size() > 0) {
      uow.commitWork();
    }
  }

  private Task processEmployeeChangeEvent(Employee__ChangeEvent emp) {
    EventBus.ChangeEventHeader header = emp.ChangeEventHeader;
    if (header.changetype == 'UPDATE') {
      System.debug(LoggingLevel.DEBUG, 'List of all changed fields:');
      for (String field : header.changedFields) {
        if (null == emp.get(field)) {
          System.debug(
            LoggingLevel.DEBUG,
            'Deleted field value (set to null): ' + field
          );
        } else {
          System.debug(
            LoggingLevel.DEBUG,
            'Changed field value: ' + field + '. New Value: ' + emp.get(field)
          );
        }
      }
    }
    // Get record fields and display only if not null.
    System.debug(
      LoggingLevel.DEBUG,
      'Some Employee record field values from the change event:'
    );
    if (emp.First_Name__c != null) {
      System.debug(LoggingLevel.DEBUG, 'First Name: ' + emp.First_Name__c);
    }
    if (emp.Last_Name__c != null) {
      System.debug(LoggingLevel.DEBUG, 'Last Name: ' + emp.Last_Name__c);
    }
    if (emp.Name != null) {
      System.debug(LoggingLevel.DEBUG, 'Name: ' + emp.Name);
    }
    if (emp.Tenure__c != null) {
      System.debug(LoggingLevel.DEBUG, 'Tenure: ' + emp.Tenure__c);
    }
    // Create a followup task
    Task tk = new Task();
    tk.Subject = 'Follow up on employee record(s): ' + header.recordIds;
    tk.OwnerId = header.CommitUser;
    return tk;
  }
}
