/**
 * @description REST resource for closing cases via HTTP POST.
 */
@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
  /**
   * @description Closes a case with the specified reason.
   * @param closeReason The reason for closing the case.
   */
  @HttpPost
  global static void closeCase(String closeReason) {
    // Parse context
    RestRequest req = RestContext.request;
    String[] uriParts = req.requestURI.split('/');
    Id caseId = uriParts[2];
    // Call the service
    CaseService.closeCases(new Set<Id>{ caseId }, closeReason);
  }
}
