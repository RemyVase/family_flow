import 'package:flutter/foundation.dart';

/// Lead time of task reminders.
enum ReminderLeadTime { onTime, fifteenMinutes, thirtyMinutes, oneHour }

/// Day the weekly points reset.
enum WeekStartDay { monday, saturday, sunday }

/// State of the "recurrences & reminders" settings screen. Local state
/// only for now (design phase, nothing persisted).
class RemindersController extends ChangeNotifier {
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

  WeekStartDay _weekStartDay = WeekStartDay.monday;
  WeekStartDay get weekStartDay => _weekStartDay;

  bool _autoCarryOver = true;
  bool get autoCarryOver => _autoCarryOver;

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

  void setWeekStartDay(WeekStartDay value) {
    _weekStartDay = value;
    notifyListeners();
  }

  void setAutoCarryOver(bool value) {
    _autoCarryOver = value;
    notifyListeners();
  }
}
