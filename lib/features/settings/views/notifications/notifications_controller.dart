import 'package:flutter/foundation.dart';

/// Lead time of task reminders.
enum ReminderLeadTime { onTime, fifteenMinutes, thirtyMinutes, oneHour }

/// State of the notifications settings screen. Local state only for now
/// (design phase, nothing persisted).
class NotificationsController extends ChangeNotifier {
  bool _masterEnabled = true;
  bool get masterEnabled => _masterEnabled;

  bool _remindTasks = true;
  bool get remindTasks => _remindTasks;

  ReminderLeadTime _leadTime = ReminderLeadTime.thirtyMinutes;
  ReminderLeadTime get leadTime => _leadTime;

  bool _morningSummary = true;
  bool get morningSummary => _morningSummary;

  bool _eveningReminder = true;
  bool get eveningReminder => _eveningReminder;

  bool _overdueAlert = true;
  bool get overdueAlert => _overdueAlert;

  bool _tribeLifeAlerts = true;
  bool get tribeLifeAlerts => _tribeLifeAlerts;

  bool _quietNight = true;
  bool get quietNight => _quietNight;

  void setMasterEnabled(bool value) {
    _masterEnabled = value;
    notifyListeners();
  }

  void setRemindTasks(bool value) {
    _remindTasks = value;
    notifyListeners();
  }

  void setLeadTime(ReminderLeadTime value) {
    _leadTime = value;
    notifyListeners();
  }

  void setMorningSummary(bool value) {
    _morningSummary = value;
    notifyListeners();
  }

  void setEveningReminder(bool value) {
    _eveningReminder = value;
    notifyListeners();
  }

  void setOverdueAlert(bool value) {
    _overdueAlert = value;
    notifyListeners();
  }

  void setTribeLifeAlerts(bool value) {
    _tribeLifeAlerts = value;
    notifyListeners();
  }

  void setQuietNight(bool value) {
    _quietNight = value;
    notifyListeners();
  }
}
