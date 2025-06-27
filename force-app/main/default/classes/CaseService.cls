/**
 * @description Service class for handling Case operations such as closing cases.
 */
public with sharing class CaseService {
  /**
   * @description Closes the cases with the given IDs and sets their Reason field.
   * @param caseIds Set of Case record IDs to close.
   * @param closeReason The reason to set for closing the cases.
   */
  public static void closeCases(Set<Id> caseIds, String closeReason) {
    List<Case> casesToClose = [
      SELECT Id, reason
      FROM Case
      WHERE Id IN :caseIds
      WITH USER_MODE
    ];
    for (Case caseToClose : casesToClose) {
      caseToClose.Status = 'Closed';
      caseToClose.Reason = closeReason;
    }
    update as USER casesToClose;
  }
}
