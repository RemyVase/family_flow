import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// One cell of the 7-day strip.
@immutable
class WeekDay {
  const WeekDay({required this.date, required this.taskCount});

  final DateTime date;
  final int taskCount;
}

/// State of the week screen: day strip + timeline of the selected day,
/// backed by [TaskService].
///
/// Tasks carry no date yet, so every day shows the tribe's current task
/// list; per-day planning will come with a scheduling model.
class WeekController extends ChangeNotifier {
  WeekController(this._taskService, {DateTime? now})
    : _now = now ?? DateTime.now() {
    _selectedDate = _dateOnly(_now);
    _taskService.addListener(notifyListeners);
  }

  final TaskService _taskService;
  final DateTime _now;
  late DateTime _selectedDate;

  DateTime get today => _dateOnly(_now);
  DateTime get selectedDate => _selectedDate;

  bool get isTodaySelected => _selectedDate == today;

  /// Timeline tasks, ordered by their time of day.
  List<Task> get tasks =>
      [..._taskService.tasks]
        ..sort((a, b) => _timeMinutes(a.time).compareTo(_timeMinutes(b.time)));

  /// Monday-to-Sunday strip of the current week.
  List<WeekDay> get days {
    final monday = _dateOnly(_now.subtract(Duration(days: _now.weekday - 1)));
    return [
      for (var i = 0; i < 7; i++)
        WeekDay(
          date: monday.add(Duration(days: i)),
          taskCount: _taskService.tasks.length,
        ),
    ];
  }

  /// ISO-like week number, good enough for display.
  int get weekNumber {
    final firstDayOfYear = DateTime(_now.year);
    return ((_now.difference(firstDayOfYear).inDays + firstDayOfYear.weekday) /
            7)
        .ceil();
  }

  int get doneCount => tasks.where((t) => t.isDone).length;

  int get dayPoints => tasks.fold(0, (sum, t) => sum + t.points);

  /// "HH:mm" label of the "now" marker row.
  String get nowTimeLabel =>
      '${_now.hour}:${_now.minute.toString().padLeft(2, '0')}';

  /// Id of the task after which the "now" marker sits, or null when the
  /// marker is hidden (day other than today, or before the first task).
  String? get nowAfterTaskId {
    if (!isTodaySelected) return null;
    final nowMinutes = _now.hour * 60 + _now.minute;
    Task? lastPast;
    for (final task in tasks) {
      if (_timeMinutes(task.time) <= nowMinutes) lastPast = task;
    }
    return lastPast?.id;
  }

  void selectDay(DateTime date) {
    _selectedDate = _dateOnly(date);
    notifyListeners();
  }

  void toggleTask(String taskId) {
    unawaited(_taskService.toggleTask(taskId).onError(reportError));
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Parses "8:00" / "19:30" to minutes since midnight; unparsable times
  /// sort first.
  static int _timeMinutes(String time) {
    final parts = time.split(':');
    if (parts.length != 2) return 0;
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    return hours * 60 + minutes;
  }

  @override
  void dispose() {
    _taskService.removeListener(notifyListeners);
    super.dispose();
  }
}
