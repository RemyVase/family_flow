import 'package:our_tribe/features/notifications/models/notification_prefs.dart';

/// Contract for the notification preferences store
/// (`users/{uid}/settings/notifications`).
abstract class NotificationPrefsRepository {
  /// Emits the preferences document, null while it does not exist yet.
  Stream<NotificationPrefs?> watchPrefs(String userId);

  Future<void> savePrefs(String userId, NotificationPrefs prefs);
}
