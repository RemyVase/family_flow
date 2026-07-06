import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/notifications/models/notification_prefs.dart';
import 'package:our_tribe/features/notifications/models/reminder_lead_time.dart';
import 'package:our_tribe/services/notification_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// State of the notifications settings screen: an editable copy of the
/// persisted [NotificationPrefs], plus the system permission handling.
class NotificationsController extends ChangeNotifier {
  NotificationsController(this._notificationService)
    : _prefs = _notificationService.prefs {
    _notificationService.addListener(_onServiceChanged);
  }

  final NotificationService _notificationService;

  NotificationPrefs _prefs;
  bool _hasEdits = false;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  /// True when the user refused notifications in the iOS settings; the
  /// screen shows a hint instead of silently doing nothing.
  bool get isSystemDenied => _notificationService.isSystemDenied;

  bool get masterEnabled => _prefs.masterEnabled;
  bool get remindTasks => _prefs.remindTasks;
  ReminderLeadTime get leadTime => _prefs.leadTime;
  bool get morningSummary => _prefs.morningSummary;
  bool get eveningReminder => _prefs.eveningReminder;
  bool get overdueAlert => _prefs.overdueAlert;
  bool get tribeLifeAlerts => _prefs.tribeLifeAlerts;
  bool get quietNight => _prefs.quietNight;

  /// Follow the persisted prefs until the user starts editing.
  void _onServiceChanged() {
    if (!_hasEdits) _prefs = _notificationService.prefs;
    notifyListeners();
  }

  void _update(NotificationPrefs prefs) {
    _prefs = prefs;
    _hasEdits = true;
    notifyListeners();
  }

  /// Turning the master switch on triggers the system permission prompt
  /// when it was never asked.
  void setMasterEnabled(bool value) {
    _update(_prefs.copyWith(masterEnabled: value));
    if (value) {
      unawaited(
        _notificationService
            .requestPermission()
            .then<void>((_) {})
            .onError(reportError),
      );
    }
  }

  void setRemindTasks(bool value) =>
      _update(_prefs.copyWith(remindTasks: value));

  void setLeadTime(ReminderLeadTime value) =>
      _update(_prefs.copyWith(leadTime: value));

  void setMorningSummary(bool value) =>
      _update(_prefs.copyWith(morningSummary: value));

  void setEveningReminder(bool value) =>
      _update(_prefs.copyWith(eveningReminder: value));

  void setOverdueAlert(bool value) =>
      _update(_prefs.copyWith(overdueAlert: value));

  void setTribeLifeAlerts(bool value) =>
      _update(_prefs.copyWith(tribeLifeAlerts: value));

  void setQuietNight(bool value) => _update(_prefs.copyWith(quietNight: value));

  /// Persists the preferences. Returns false on error.
  Future<bool> save() async {
    _isSaving = true;
    notifyListeners();
    try {
      await _notificationService.savePrefs(_prefs);
      return true;
    } catch (e, st) {
      await reportError(e, st);
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _notificationService.removeListener(_onServiceChanged);
    super.dispose();
  }
}
