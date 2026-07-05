import 'package:flutter/foundation.dart';

/// State of the signup form. No backend call yet (design-only phase).
class SignupController extends ChangeNotifier {
  String _firstName = '';
  String get firstName => _firstName;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  bool get canContinue =>
      _firstName.trim().isNotEmpty && _email.trim().isNotEmpty;

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }
}
