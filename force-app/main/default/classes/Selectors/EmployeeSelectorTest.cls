/*
 * @description Test class for EmployeeSelector
 */
@isTest
private class EmployeeSelectorTest {
  /**
   * @description Test method for EmployeeSelector class.
   */
  @TestSetup
  static void makeData() {
    Employee__c[] empList = TestFactory.generateEmployees(5, true);
  }

  /**
   * @description Test method for selecting Employees by ID.
   */
  @IsTest
  static void selectById() {
    List<Employee__c> empList = new EmployeeSelector().selectAll(5);
    List<Employee__c> employees = new EmployeeSelector()
      .selectById(new Set<Id>{ empList[0].Id, empList[1].Id, empList[2].Id });

    System.assertEquals(3, employees.size(), 'Should select 3 employees by ID');
  }

  /**
   * @description Test method for selecting all Employees.
   */
  @IsTest
  static void selectAll() {
    List<Employee__c> employees = new EmployeeSelector().selectAll();

    System.assert(
      employees.size() >= 5,
      'Should select at least 5 employees in total'
    );
  }

  /**
   * @description Test method for selecting all Employees with a limit.
   */
  @IsTest
  static void selectAllWithLimit() {
    List<Employee__c> employees = new EmployeeSelector().selectAll(3);
    System.assertEquals(
      3,
      employees.size(),
      'Should select 3 employees with limit'
    );
  }
}
