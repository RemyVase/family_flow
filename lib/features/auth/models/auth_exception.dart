/// User-facing categories of authentication failures. Views translate them
/// through the localization layer.
enum AuthError {
  emailInUse,
  invalidEmail,
  weakPassword,
  invalidCredentials,
  network,
  unknown,
}

/// Typed domain exception thrown by [AuthRepository] implementations so the
/// upper layers never depend on backend-specific exception types.
class AuthException implements Exception {
  const AuthException(this.error);

  final AuthError error;

  @override
  String toString() => 'AuthException(${error.name})';
}
