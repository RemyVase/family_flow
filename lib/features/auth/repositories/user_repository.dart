import 'package:our_tribe/features/auth/models/app_user.dart';

/// Contract for the user profile store (`users/{uid}`).
abstract class UserRepository {
  /// Emits the profile document, null while it does not exist yet.
  Stream<AppUser?> watchUser(String userId);

  Future<void> saveUser(AppUser user);

  /// Points the user at their current tribe (null when leaving it).
  Future<void> setTribeId(String userId, String? tribeId);

  /// Registers a device push token on the user (`fcmTokens` array).
  Future<void> addFcmToken(String userId, String token);

  /// Removes a device push token (sign-out, token rotation).
  Future<void> removeFcmToken(String userId, String token);
}
