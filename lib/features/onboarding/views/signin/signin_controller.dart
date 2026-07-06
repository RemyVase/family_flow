import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// State of the sign-in form; authentication goes through [AuthService].
class SigninController extends ChangeNotifier {
  SigninController(this._authService);

  final AuthService _authService;

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  AuthError? _error;
  AuthError? get error => _error;

  bool get canSignIn =>
      !_isSubmitting && _email.trim().isNotEmpty && _password.isNotEmpty;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  /// Signs in; on success the router's auth guard moves the user forward.
  /// Returns false and exposes [error] on failure.
  Future<bool> submit() async {
    if (!canSignIn) return false;
    _isSubmitting = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.signIn(email: _email, password: _password);
      return true;
    } on AuthException catch (e) {
      _error = e.error;
      return false;
    } catch (e, st) {
      _error = AuthError.unknown;
      await reportError(e, st);
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
