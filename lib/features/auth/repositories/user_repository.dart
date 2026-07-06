import 'package:our_tribe/features/auth/models/app_user.dart';

/// Contract for the user profile store (`users/{uid}`).
abstract class UserRepository {
  /// Emits the profile document, null while it does not exist yet.
  Stream<AppUser?> watchUser(String userId);

  Future<void> saveUser(AppUser user);

  /// Points the user at their current tribe (null when leaving it).
  Future<void> setTribeId(String userId, String? tribeId);
}
