@IsTest
private class CalculatorTests {
  /**
   * @description Tests the add method of the Calculator class.
   */
  @IsTest
  static void testAdd() {
    // GIVEN
    Integer a = 5;
    Integer b = 10;
    // WHEN
    Test.startTest();
    Integer result = Calculator.add(a, b);
    Test.stopTest();
    // THEN
    Assert.areEqual(15, result, 'Addition result is incorrect');
  }

  /**
   * @description Tests the substract method of the Calculator class.
   */
  @IsTest
  static void testSubstract() {
    // GIVEN
    Integer a = 5;
    Integer b = 10;
    // WHEN
    Test.startTest();
    Integer result = Calculator.substract(a, b);
    Test.stopTest();
    // THEN
    Assert.areEqual(-5, result, 'Subtraction result is incorrect');
  }

  /**
   * @description Tests the multiply method of the Calculator class.
   */
  @IsTest
  static void testMultiply() {
    // GIVEN
    Integer a = 5;
    Integer b = 10;
    // WHEN
    Test.startTest();
    Integer result = Calculator.multiply(a, b);
    Test.stopTest();
    // THEN
    Assert.areEqual(50, result, 'Multiplication result is incorrect');
  }

  /**
   * @description Tests the multiply method of the Calculator class when multiplying by zero.
   */
  @IsTest
  static void testMultiplybyZero() {
    // GIVEN
    Integer a = 5;
    Integer b = 0;
    // WHEN
    try {
      Test.startTest();
      Integer result = Calculator.multiply(a, b);
      Assert.fail('An exception should have been thrown');
      Test.stopTest();
    } catch (Calculator.CalculatorException e) {
      // THEN
      Assert.isTrue(
        e.getMessage()
          .equalsIgnoreCase('It doesn\'t make sense to multiply by zero'),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }

  /**
   * @description Tests the divide method of the Calculator class.
   */
  @IsTest
  static void testDivide() {
    // GIVEN
    Integer numerator = 10;
    Integer denominator = 2;
    // WHEN
    Test.startTest();
    Decimal result = Calculator.divide(numerator, denominator);
    Test.stopTest();
    // THEN
    Assert.areEqual(5.0, result, 'Division result is incorrect');
  }
  /**
   * @description Tests the divide method of the Calculator class.
   */
  @IsTest
  static void testDivideByZero() {
    // GIVEN
    Integer numerator = 10;
    Integer denominator = 0;

    // WHEN
    try {
      Test.startTest();
      Decimal result = Calculator.divide(numerator, denominator);
      Test.stopTest();
      Assert.fail('An exception should have been thrown');
    } catch (Calculator.CalculatorException e) {
      // THEN
      // THEN
      Assert.isTrue(
        e.getMessage().equalsIgnoreCase('You still can\'t divide by zero'),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }

  /**
   * @description Tests the divide method of the Calculator class when the result is negative.
   */
  @IsTest
  static void testNegativeDivide() {
    // GIVEN
    Integer numerator = 10;
    Integer denominator = -2;

    // WHEN
    try {
      Test.startTest();
      Decimal result = Calculator.divide(numerator, denominator);
      Test.stopTest();
      Assert.fail('An exception should have been thrown');
    } catch (Calculator.CalculatorException e) {
      // THEN
      Assert.isTrue(
        e.getMessage()
          .equalsIgnoreCase('Division returned a negative value.' + -5),
        'Exception message does not match: ' + e.getMessage()
      );
    }
  }
}
