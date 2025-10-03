/**
 * @description Test class for TaskFactory.
 */
@isTest
public class TestTaskFactory {
  /**
   * @description Generates Tasks for a specified Account using parameters.
   * @param params A map containing parameters for the Task:
   *               - accountId: The Id of the Account to associate with.
   *               - subject: The subject of the Task.
   *               - numTasks: The number of Tasks to create.
   *               - doInsert: Whether to insert the Tasks into the database.
   *               - uow: The unit of work to use for inserting the Tasks.
   * @return An array of created Tasks.
   */
  public static Task[] generateTasksForAccount(Map<String, Object> params) {
    TestFactory.clearData();
    Id accountId = (Id) params.get('accountId');
    String subject = (String) params.get('subject');
    Integer numTasks = (Integer) params.get('numTasks');
    Boolean doInsert = (Boolean) params.get('doInsert');
    fflib_SObjectUnitOfWork uow = (fflib_SObjectUnitOfWork) params.get('uow');

    List<Task> tasks = new List<Task>();
    for (Integer i = 0; i < numTasks; i++) {
      Task t = new Task(
        WhatId = accountId,
        Subject = subject + ' ' + i,
        Status = 'Not Started',
        Priority = 'Normal'
      );
      tasks.add(t);
      if (doInsert) {
        uow.registerNew(t);
      }
    }
    if (doInsert) {
      uow.commitWork();
    }
    return tasks;
  }
}
