/*
 * @description Test class for Employee Change Event trigger.
 */
@isTest
public class EmployeeChangesTest {
  /**
   * @description Test method for creating and updating an Employee record.
   */
  @isTest
  static void testCreateAndUpdateEmployee() {
    Test.enableChangeDataCapture();

    Employee__c[] empList = TestFactory.generateEmployees(1, true);

    Test.getEventBus().deliver();

    Task[] taskList = new TaskSelector().selectAll();
    System.assertEquals(
      1,
      taskList.size(),
      'The change event trigger did not create the expected task.'
    );

    Employee__c[] empRecords = new EmployeeSelector().selectAll();

    Employee__c emp = empRecords[0];
    emp.First_Name__c = 'Codey';
    emp.Tenure__c = null;
    update emp;

    Test.getEventBus().deliver();

    Task[] taskList2 = new TaskSelector().selectAll();
    System.assertEquals(
      2,
      taskList2.size(),
      'The change event trigger did not create the expected task.'
    );
  }
}
