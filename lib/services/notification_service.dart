import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/auth/repositories/user_repository.dart';
import 'package:our_tribe/features/notifications/models/notification_prefs.dart';
import 'package:our_tribe/features/notifications/repositories/notification_prefs_repository.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';
import 'package:our_tribe/services/analytics_service.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// App-wide push notification state: system permission, the device FCM
/// token registered on the signed-in user, and the notification
/// preferences persisted on their profile.
///
/// Orchestrates the auth, user and messaging backends, which is why it
/// lives in a cross-feature service.
class NotificationService extends ChangeNotifier {
  NotificationService(
    this._messagingRepository,
    this._prefsRepository,
    this._userRepository,
    this._authService,
    this._analytics,
  ) {
    _authService.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  final PushMessagingRepository _messagingRepository;
  final NotificationPrefsRepository _prefsRepository;
  final UserRepository _userRepository;
  final AuthService _authService;
  final AnalyticsService _analytics;

  String? _userId;
  String? _token;
  StreamSubscription<NotificationPrefs?>? _prefsSub;
  StreamSubscription<String>? _tokenRefreshSub;

  PushPermissionStatus _permissionStatus = PushPermissionStatus.notRequested;
  PushPermissionStatus get permissionStatus => _permissionStatus;

  /// The system-level switch: false when the user refused the iOS prompt.
  bool get isSystemDenied => _permissionStatus == PushPermissionStatus.denied;

  NotificationPrefs _prefs = const NotificationPrefs();
  NotificationPrefs get prefs => _prefs;

  /// The device token currently registered on the user, if any.
  String? get registeredToken => _token;

  void _onAuthChanged() {
    final userId = _authService.userId;
    if (userId == _userId) return;
    _userId = userId;
    _prefsSub?.cancel();
    _prefsSub = null;
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
    _token = null;
    _prefs = const NotificationPrefs();
    if (userId != null) {
      _prefsSub = _prefsRepository.watchPrefs(userId).listen((prefs) {
        _prefs = prefs ?? const NotificationPrefs();
        notifyListeners();
      }, onError: reportError);
      unawaited(_syncPermissionAndToken(userId).onError(reportError));
    }
    notifyListeners();
  }

  /// Reads the system permission and registers the device token when
  /// allowed. Called at sign-in and after a permission request.
  Future<void> _syncPermissionAndToken(String userId) async {
    _permissionStatus = await _messagingRepository.getPermissionStatus();
    notifyListeners();
    if (_permissionStatus != PushPermissionStatus.granted) return;
    await _registerToken(userId);
  }

  Future<void> _registerToken(String userId) async {
    final token = await _messagingRepository.getToken();
    if (token == null || _userId != userId) return;
    _token = token;
    await _userRepository.addFcmToken(userId, token);
    _tokenRefreshSub ??= _messagingRepository.watchTokenRefresh().listen(
      (refreshed) =>
          unawaited(_onTokenRefreshed(userId, refreshed).onError(reportError)),
      onError: reportError,
    );
    notifyListeners();
  }

  Future<void> _onTokenRefreshed(String userId, String refreshed) async {
    final previous = _token;
    if (refreshed == previous || _userId != userId) return;
    _token = refreshed;
    if (previous != null) {
      await _userRepository.removeFcmToken(userId, previous);
    }
    await _userRepository.addFcmToken(userId, refreshed);
  }

  /// Shows the system prompt when needed and registers the device token.
  /// Returns true when notifications are allowed system-side.
  Future<bool> requestPermission() async {
    final userId = _userId;
    if (userId == null) return false;
    _permissionStatus = await _messagingRepository.requestPermission();
    notifyListeners();
    _analytics.logNotificationPermission(
      granted: _permissionStatus == PushPermissionStatus.granted,
    );
    if (_permissionStatus != PushPermissionStatus.granted) return false;
    await _registerToken(userId);
    return true;
  }

  /// Persists the notification preferences on the user's profile.
  Future<void> savePrefs(NotificationPrefs prefs) {
    final userId = _userId;
    if (userId == null) return Future.value();
    _prefs = prefs;
    notifyListeners();
    _analytics.logNotificationPrefsSaved(enabled: prefs.masterEnabled);
    return _prefsRepository.savePrefs(userId, prefs);
  }

  /// Detaches this device from the user (called before signing out, while
  /// the user still has write access to their profile).
  Future<void> unregisterToken() async {
    final userId = _userId;
    final token = _token;
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
    _token = null;
    if (userId == null || token == null) return;
    await _userRepository.removeFcmToken(userId, token);
  }

  @override
  void dispose() {
    _authService.removeListener(_onAuthChanged);
    _prefsSub?.cancel();
    _tokenRefreshSub?.cancel();
    super.dispose();
  }
}
