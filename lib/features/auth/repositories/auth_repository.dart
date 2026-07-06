/// Contract for the authentication backend.
///
/// Implementations only make auth calls (see
/// `.claude/rules/dependency-injection.md`); the app depends on this
/// interface, never on a concrete backend.
abstract class AuthRepository {
  /// The signed-in user's id, or null when signed out.
  String? get currentUserId;

  /// Emits the user id on every sign-in/sign-out, starting with the
  /// current state.
  Stream<String?> watchUserId();

  /// Creates an account and returns the new user id.
  Future<String> signUp({required String email, required String password});

  /// Signs in and returns the user id.
  Future<String> signIn({required String email, required String password});

  Future<void> signOut();
}
