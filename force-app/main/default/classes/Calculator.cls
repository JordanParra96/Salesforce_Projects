/**
 * @description This class provides basic arithmetic operations.
 * It includes methods for addition, subtraction, multiplication, and division.
 * Each method throws a custom exception for specific error conditions.
 */
public class Calculator {
  /**
   * @description Custom exception class for the Calculator.
   */
  public class CalculatorException extends Exception {
  }

  /**
   * @description Adds two integers and returns the result.
   * @param a First integer
   * @param b Second integer
   * @return The sum of a and b
   */
  public static Integer add(Integer a, Integer b) {
    return a + b;
  }

  /**
   * @description Subtracts the second integer from the first and returns the result.
   * @param a First integer
   * @param b Second integer
   * @return The result of a minus b
   */
  public static Integer substract(Integer a, Integer b) {
    return a - b;
  }

  /**
   * @description Multiplies two integers and returns the result.
   * Throws an exception if either integer is zero.
   * @param a First integer
   * @param b Second integer
   * @return The product of a and b
   */
  public static Integer multiply(Integer a, Integer b) {
    if (b == 0 || a == 0) {
      throw new CalculatorException(
        'It doesn\'t make sense to multiply by zero'
      );
    }
    return a * b;
  }

  /**
   * @description Divides the first integer by the second and returns the result.
   * Throws an exception if the denominator is zero or if the result is negative.
   * @param numerator The integer to be divided
   * @param denominator The integer to divide by
   * @return The quotient of numerator divided by denominator
   */
  public static Decimal divide(Integer numerator, Integer denominator) {
    if (denominator == 0) {
      throw new CalculatorException('You still can\'t divide by zero');
    }
    Decimal returnValue = numerator / denominator;
    if (returnValue < 0) {
      throw new CalculatorException(
        'Division returned a negative value.' + returnValue
      );
    }
    return returnValue;
  }
}
