/**
 * @description Test class for the UsersSelector class.
 */
@isTest
private class UsersSelectorTest {
  /**
   * @description Test method for selecting Users by ID.
   */
  @isTest
  static void selectById() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ User.SObjectType }
    );

    List<User> userList = new List<User>{
      new User(
        LastName = 'TEST',
        FirstName = 'User1',
        Alias = 'u1',
        Email = 'test1@userselector.com',
        Username = 'test1@userselector.com',
        ProfileId = UserInfo.getProfileId(),
        TimeZoneSidKey = 'GMT',
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        LocaleSidKey = 'en_US'
      ),
      new User(
        LastName = 'TEST',
        FirstName = 'User2',
        Alias = 'u2',
        Email = 'test2@userselector.com',
        Username = 'test2@userselector.com',
        ProfileId = UserInfo.getProfileId(),
        TimeZoneSidKey = 'GMT',
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        LocaleSidKey = 'en_US'
      )
    };
    uow.registerNew(userList);
    uow.commitWork();
    Set<Id> userIds = new Set<Id>{ userList[0].Id, userList[1].Id };
    List<User> users = new UsersSelector().selectById(userIds);
    System.assertEquals(2, users.size(), 'Should select 2 users by ID');
  }

  /**
   * @description Test method for selecting Users by lastName.
   */
  @IsTest
  static void selectByLastname() {
    // Create a Unit Of Work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
      new List<Schema.SObjectType>{ User.SObjectType }
    );

    List<User> userList = new List<User>{
      new User(
        LastName = 'TEST',
        FirstName = 'User1',
        Alias = 'u1',
        Email = 'test1@userselector.com',
        Username = 'test1@userselector.com',
        ProfileId = UserInfo.getProfileId(),
        TimeZoneSidKey = 'GMT',
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        LocaleSidKey = 'en_US'
      ),
      new User(
        LastName = 'TEST',
        FirstName = 'User2',
        Alias = 'u2',
        Email = 'test2@userselector.com',
        Username = 'test2@userselector.com',
        ProfileId = UserInfo.getProfileId(),
        TimeZoneSidKey = 'GMT',
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey = 'UTF-8',
        LocaleSidKey = 'en_US'
      )
    };
    uow.registerNew(userList);
    uow.commitWork();

    Set<String> lastnameSet = new Set<String>{ 'TEST' };
    List<User> users = new UsersSelector().selectByLastname(lastnameSet, 10);

    System.assertEquals(2, users.size(), 'Should select 2 users by lastName');
  }

  /**
   * @description Test method for selecting all Users.
   */
  @IsTest
  static void selectAll() {
    List<User> users = new UsersSelector().selectAll(10);
    System.assertNotEquals(0, users.size(), 'Should select all users');
  }
}
