/*
 * @description Test class for TaskSelector
 */
@isTest
private class TaskSelectorTest {
  /**
   * @description Test data setup method.
   */
  @TestSetup
  static void makeData() {
    Account a = TestFactory.getAccount('Test Account', true);
    Map<String, Object> params = new Map<String, Object>{
      'accountId' => a.Id,
      'subject' => 'Test Task',
      'numTasks' => 5,
      'doInsert' => true
    };

    Task[] tasks = TestFactory.generateTasksForAccount(params);
  }

  /**
   * @description Test method for selecting Tasks by ID.
   */
  @isTest
  static void selectById() {
    List<Task> taskList = new TaskSelector().selectAll(5);
    List<Task> tasks = new TaskSelector()
      .selectById(
        new Set<Id>{
          taskList[0].Id,
          taskList[1].Id,
          taskList[2].Id,
          taskList[3].Id,
          taskList[4].Id
        }
      );
    System.Assert.areEqual(5, tasks.size());
  }

  /**
   * @description Test method for selecting all Tasks.
   */
  @isTest
  static void selectAll() {
    List<Task> tasks = new TaskSelector().selectAll();
    System.Assert.isTrue(
      tasks.size() >= 5,
      'Should select at least 5 tasks in total'
    );
  }

  /**
   * @description Test method for selecting all Tasks with limit.
   */
  @isTest
  static void selectAllWithLimit() {
    List<Task> tasks = new TaskSelector().selectAll(3);
    System.Assert.areEqual(3, tasks.size(), 'Should select 3 tasks');
  }
}
