import 'package:fall_detector/utils/constants.dart';
import 'package:fall_detector/utils/validation_utils.dart';
import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  String email, password;

  final _activation = {
    'email': false,
    'password': false,
  };

  bool formActivated() {
    return !_activation.containsValue(false);
  }

  void activateEmail(String value) {
    _activation['email'] = true;
  }

  void activatePassword(String value) {
    _activation['password'] = true;
  }

  String validateEmail(String value) {
    if (value.isEmpty && _activation['email']) {
      return AppConstants.emptyEmail;
    } else if (!ValidationUtils.isEmail(value) && _activation['email']) {
      return AppConstants.invalidEmailMsg;
    }
    email = value;
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty && _activation['password']) {
      return AppConstants.emptyPassword;
    } else if (!ValidationUtils.isValidWithLimit(value) && _activation['email']) {
      return AppConstants.passwordToShort;
    }
    password = value;
    return null;
  }
}
