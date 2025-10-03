/**
 * @description Test class for Employee Change Event trigger.
 */
@isTest
public class TestEmployeeChangeTrigger {
  /**
   * @description Test method for creating and updating an Employee record.
   */
  @isTest
  static void testCreateAndUpdateEmployee() {
    Test.enableChangeDataCapture();

    insert new Employee__c(
      Name = 'e-101',
      First_Name__c = 'Astro',
      Last_Name__c = 'Test',
      Tenure__c = 1
    );

    Test.getEventBus().deliver();

    Task[] taskList = [SELECT Id, Subject FROM Task];
    System.assertEquals(
      1,
      taskList.size(),
      'The change event trigger did not create the expected task.'
    );

    Employee__c[] empRecords = [
      SELECT Id, OwnerId, First_Name__c, Tenure__c
      FROM Employee__c
    ];

    Employee__c emp = empRecords[0];
    emp.First_Name__c = 'Codey';
    emp.Tenure__c = null;
    update emp;

    Test.getEventBus().deliver();

    Task[] taskList2 = [SELECT Id, Subject FROM Task];
    System.assertEquals(
      2,
      taskList2.size(),
      'The change event trigger did not create the expected task.'
    );
  }
}
