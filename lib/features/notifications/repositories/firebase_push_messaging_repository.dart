import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';

/// FCM implementation of [PushMessagingRepository].
class FirebasePushMessagingRepository implements PushMessagingRepository {
  FirebasePushMessagingRepository(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<PushPermissionStatus> getPermissionStatus() async {
    final settings = await _messaging.getNotificationSettings();
    return _map(settings.authorizationStatus);
  }

  @override
  Future<PushPermissionStatus> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return _map(settings.authorizationStatus);
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } on Exception {
      // No APNS token available (e.g. simulator without push support):
      // the app simply runs without a registered device.
      return null;
    }
  }

  @override
  Stream<String> watchTokenRefresh() => _messaging.onTokenRefresh;

  static PushPermissionStatus _map(AuthorizationStatus status) =>
      switch (status) {
        AuthorizationStatus.authorized ||
        AuthorizationStatus.provisional => PushPermissionStatus.granted,
        AuthorizationStatus.denied => PushPermissionStatus.denied,
        AuthorizationStatus.notDetermined => PushPermissionStatus.notRequested,
      };
}
