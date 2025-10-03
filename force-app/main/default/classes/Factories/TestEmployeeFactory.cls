/**
 * @description Factory class for generating test Employee__c records.
 */
@isTest
public class TestEmployeeFactory {
  /**
   * @description Generates a specified number of Employee__c records.
   * @param numEmployees The number of Employee__c records to create.
   * @param doInsert Whether to insert the Employee__c records into the database.
   * @param uow The unit of work to use for inserting the Employee__c records.
   * @return An array of created Employee__c records.
   */
  public static Employee__c[] generateEmployees(
    Integer numEmployees,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    TestFactory.clearData();
    List<Employee__c> employees = new List<Employee__c>();

    for (Integer i = 0; i < numEmployees; i++) {
      Employee__c emp = new Employee__c(
        Name = 'e-' + String.valueOf(100 + i),
        First_Name__c = 'FirstName' + String.valueOf(i),
        Last_Name__c = 'LastName' + String.valueOf(i),
        Tenure__c = i + 1
      );
      employees.add(emp);
    }

    if (doInsert) {
      uow.registerNew(employees);
      uow.commitWork();
    }
    return employees;
  }
}
