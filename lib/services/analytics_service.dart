import 'dart:async';

import 'package:our_tribe/features/analytics/models/analytics_event.dart';
import 'package:our_tribe/features/analytics/repositories/analytics_repository.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// Typed façade over the analytics backend.
///
/// Every trackable action in the app has a dedicated method here, so event
/// and parameter names live in exactly one place and callers can never
/// misspell them. All calls are fire-and-forget: analytics must never slow
/// down or break a user flow.
class AnalyticsService {
  AnalyticsService(this._repository);

  static const String _propRole = 'role';
  static const String _propTribeSize = 'tribe_size';

  static const String _paramAssignment = 'assignment';
  static const String _paramPoints = 'points';
  static const String _paramRecurrence = 'recurrence';
  static const String _paramMoment = 'moment';
  static const String _paramTribeDeleted = 'tribe_deleted';
  static const String _paramGranted = 'granted';
  static const String _paramEnabled = 'enabled';

  final AnalyticsRepository _repository;

  /// Attaches events to the signed-in user (null on sign-out).
  void setUser(String? userId) {
    _fire(() => _repository.setUserId(userId));
    if (userId == null) {
      _fire(() => _repository.setUserProperty(_propRole, null));
      _fire(() => _repository.setUserProperty(_propTribeSize, null));
    }
  }

  /// Segmentation properties refreshed whenever the tribe changes.
  void setTribeContext({required bool isChief, required int memberCount}) {
    _fire(
      () =>
          _repository.setUserProperty(_propRole, isChief ? 'chief' : 'member'),
    );
    _fire(() => _repository.setUserProperty(_propTribeSize, '$memberCount'));
  }

  void logScreenView(String screenName) {
    _fire(() => _repository.logScreenView(screenName));
  }

  // --- Auth -----------------------------------------------------------

  void logSignUp() => _log(AnalyticsEvent.signUp);

  void logLogin() => _log(AnalyticsEvent.login);

  void logLogout() => _log(AnalyticsEvent.logout);

  // --- Tribe ----------------------------------------------------------

  void logTribeCreated() => _log(AnalyticsEvent.tribeCreated);

  void logTribeJoined() => _log(AnalyticsEvent.tribeJoined);

  void logTribeLeft({required bool tribeDeleted}) =>
      _log(AnalyticsEvent.tribeLeft, {_paramTribeDeleted: '$tribeDeleted'});

  void logMemberRemoved() => _log(AnalyticsEvent.memberRemoved);

  void logMemberRenamed() => _log(AnalyticsEvent.memberRenamed);

  void logMemberColorChanged() => _log(AnalyticsEvent.memberColorChanged);

  // --- Tasks ----------------------------------------------------------

  void logTaskCreated({
    required String assignment,
    required int points,
    required String recurrence,
    required String moment,
  }) => _log(AnalyticsEvent.taskCreated, {
    _paramAssignment: assignment,
    _paramPoints: points,
    _paramRecurrence: recurrence,
    _paramMoment: moment,
  });

  void logTaskCompleted({required int points}) =>
      _log(AnalyticsEvent.taskCompleted, {_paramPoints: points});

  void logTaskUnchecked({required int points}) =>
      _log(AnalyticsEvent.taskUnchecked, {_paramPoints: points});

  void logTaskAssigned() => _log(AnalyticsEvent.taskAssigned);

  // --- Notifications --------------------------------------------------

  void logNotificationPermission({required bool granted}) =>
      _log(AnalyticsEvent.notificationPermission, {_paramGranted: '$granted'});

  void logNotificationPrefsSaved({required bool enabled}) =>
      _log(AnalyticsEvent.notificationPrefsSaved, {_paramEnabled: '$enabled'});

  void _log(AnalyticsEvent event, [Map<String, Object>? parameters]) {
    _fire(() => _repository.logEvent(event, parameters));
  }

  void _fire(Future<void> Function() call) {
    unawaited(call().onError(reportError));
  }
}
