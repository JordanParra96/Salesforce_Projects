/**
 * @description A factory class for creating test User records.
 */
@isTest
public class TestUserFactory {
  /**
   * @description Generates a User with the specified profile name.
   * @param profileName The name of the Profile for the User.
   * @param doInsert Whether to insert the User into the database.
   * @param uow The unit of work to use for inserting the User.
   * @return The created User.
   */
  public static User generateUser(
    String profileName,
    Boolean doInsert,
    fflib_SObjectUnitOfWork uow
  ) {
    User u = new User(
      ProfileId = new ProfileSelector()
          .selectByName(new Set<String>{ profileName }, 1)[0]
        .Id,
      LastName = 'last',
      Email = 'Cpt.Awesome@awesomesauce.com',
      Username = 'Cpt.Awesome.' +
        DateTime.now().getTime() +
        '@awesomesauce.com',
      CompanyName = 'Testing Co',
      Title = 'Captian',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US'
    );
    if (doInsert) {
      uow.registerNew(u);
    }
    uow.commitWork();
    return u;
  }
}
