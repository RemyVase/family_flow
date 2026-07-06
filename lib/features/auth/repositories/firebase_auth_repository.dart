import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/auth/repositories/auth_repository.dart';

/// Firebase implementation of [AuthRepository]. Auth calls only; backend
/// exceptions are wrapped into the typed [AuthException], never swallowed
/// (see `.claude/rules/error-handling.md`).
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  @override
  String? get currentUserId => _auth.currentUser?.uid;

  @override
  Stream<String?> watchUserId() =>
      _auth.authStateChanges().map((user) => user?.uid);

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapCode(e.code));
    }
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapCode(e.code));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  static AuthError _mapCode(String code) => switch (code) {
    'email-already-in-use' => AuthError.emailInUse,
    'invalid-email' => AuthError.invalidEmail,
    'weak-password' => AuthError.weakPassword,
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => AuthError.invalidCredentials,
    'network-request-failed' => AuthError.network,
    _ => AuthError.unknown,
  };
}
