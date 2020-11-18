class ValidationUtils {
  static bool isEmail(String email) {
    const emailValidationRule =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(emailValidationRule);
    return regExp.hasMatch(email);
  }

  static bool isValidWithLimit(String value, {int maxLength, int minLength = 6}) {
    if (value == null) {
      return false;
    }
    return value.length >= minLength && (maxLength == null || value.length <= maxLength);
  }
}
