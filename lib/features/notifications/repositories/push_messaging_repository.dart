/// System permission state for push notifications.
enum PushPermissionStatus { notRequested, granted, denied }

/// Contract for the push messaging backend (permission + device token).
abstract class PushMessagingRepository {
  /// Current system permission without prompting the user.
  Future<PushPermissionStatus> getPermissionStatus();

  /// Shows the system permission prompt (no-op if already decided) and
  /// returns the resulting status.
  Future<PushPermissionStatus> requestPermission();

  /// The device push token; null when unavailable (permission denied,
  /// simulator without APNS, …).
  Future<String?> getToken();

  /// Emits every time the platform rotates the device token.
  Stream<String> watchTokenRefresh();
}
