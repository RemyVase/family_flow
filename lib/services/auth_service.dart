import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/auth/repositories/auth_repository.dart';
import 'package:our_tribe/features/auth/repositories/user_repository.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// App-wide authentication state: who is signed in and which tribe they
/// belong to. Drives the router's redirect (onboarding vs. the app).
class AuthService extends ChangeNotifier {
  AuthService(this._authRepository, this._userRepository) {
    _authSub = _authRepository.watchUserId().listen(
      _onAuthChanged,
      onError: reportError,
    );
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  StreamSubscription<String?>? _authSub;
  StreamSubscription<AppUser?>? _userSub;

  bool _isReady = false;

  /// True once the initial auth state has been resolved; the router should
  /// not redirect before that.
  bool get isReady => _isReady;

  String? _userId;
  String? get userId => _userId;
  bool get isSignedIn => _userId != null;

  AppUser? _user;
  AppUser? get user => _user;

  String? get tribeId => _user?.tribeId;
  bool get hasTribe => tribeId != null;

  String get firstName => _user?.firstName ?? '';
  String get email => _user?.email ?? '';

  void _onAuthChanged(String? userId) {
    _userId = userId;
    _userSub?.cancel();
    _userSub = null;
    _user = null;
    if (userId != null) {
      _userSub = _userRepository.watchUser(userId).listen((user) {
        _user = user;
        _isReady = true;
        notifyListeners();
      }, onError: reportError);
    }
    _isReady = _isReady || userId == null;
    notifyListeners();
  }

  /// Creates the account then its profile document.
  Future<void> signUp({
    required String firstName,
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    final userId = await _authRepository.signUp(
      email: trimmedEmail,
      password: password,
    );
    await _userRepository.saveUser(
      AppUser(id: userId, firstName: firstName.trim(), email: trimmedEmail),
    );
  }

  Future<void> signIn({required String email, required String password}) =>
      _authRepository.signIn(email: email.trim(), password: password);

  Future<void> signOut() => _authRepository.signOut();

  /// Records the tribe the user belongs to (null when leaving it).
  Future<void> setTribeId(String? tribeId) {
    final userId = _userId;
    if (userId == null) return Future.value();
    return _userRepository.setTribeId(userId, tribeId);
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _userSub?.cancel();
    super.dispose();
  }
}
