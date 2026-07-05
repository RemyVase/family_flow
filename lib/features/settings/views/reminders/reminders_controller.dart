import 'package:flutter/foundation.dart';

/// Day the weekly points reset.
enum WeekStartDay { monday, saturday, sunday }

/// State of the "recurrences" settings screen. Local state only for now
/// (design phase, nothing persisted). Reminders live in "Notifications".
class RemindersController extends ChangeNotifier {
  WeekStartDay _weekStartDay = WeekStartDay.monday;
  WeekStartDay get weekStartDay => _weekStartDay;

  bool _autoCarryOver = true;
  bool get autoCarryOver => _autoCarryOver;

  void setWeekStartDay(WeekStartDay value) {
    _weekStartDay = value;
    notifyListeners();
  }

  void setAutoCarryOver(bool value) {
    _autoCarryOver = value;
    notifyListeners();
  }
}
