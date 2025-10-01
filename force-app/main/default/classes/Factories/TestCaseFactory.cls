/**
 * @description A factory class for creating test Case records.
 */
@isTest
public class TestCaseFactory {
  /**
   * @description Generates a specified number of Cases.
   * @param numCases The number of Cases to create.
   * @param doInsert Whether to insert the Cases into the database.
   * @param uow The unit of work to use for inserting the Cases.
   * @return An array of created Cases.
   */
  public static Case[] generateCases(
    Integer numCases,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    List<Case> cases = new List<Case>();
    for (Integer i = 0; i < numCases; i++) {
      cases.add(new Case(Subject = 'Case ' + i, Status = 'New'));
    }
    if (doInsert) {
      uow.registerNew(cases);
      uow.commitWork();
    }
    return cases;
  }
}
