import 'package:flutter/foundation.dart';

/// State of the sign-in form. No backend call yet (design-only phase).
class SigninController extends ChangeNotifier {
  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  bool get canSignIn => _email.trim().isNotEmpty && _password.trim().isNotEmpty;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }
}
