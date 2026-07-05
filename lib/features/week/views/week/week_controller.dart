import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/mock_tasks.dart';
import 'package:our_tribe/features/tasks/models/task.dart';

/// One cell of the 7-day strip.
@immutable
class WeekDay {
  const WeekDay({required this.date, required this.taskCount});

  final DateTime date;
  final int taskCount;
}

/// State of the week screen: day strip + timeline of the selected day.
/// Mock data for now; the day strip is built around the current date.
class WeekController extends ChangeNotifier {
  WeekController({DateTime? today, List<Task>? tasks})
    : _today = today ?? DateTime.now(),
      _tasks = List.of(tasks ?? MockTasks.week) {
    _selectedDate = _dateOnly(_today);
  }

  /// Demo task counts shown as dots under each day (Mon → Sun).
  static const List<int> _demoDayCounts = [2, 6, 3, 4, 2, 1, 0];

  /// The timeline "now" marker sits after this task (demo).
  static const String nowAfterTaskId = 'w2';

  final DateTime _today;
  final List<Task> _tasks;
  late DateTime _selectedDate;

  DateTime get today => _today;
  DateTime get selectedDate => _selectedDate;

  List<Task> get tasks => List.unmodifiable(_tasks);

  /// Monday-to-Sunday strip of the current week.
  List<WeekDay> get days {
    final monday = _dateOnly(
      _today.subtract(Duration(days: _today.weekday - 1)),
    );
    return [
      for (var i = 0; i < 7; i++)
        WeekDay(
          date: monday.add(Duration(days: i)),
          taskCount: _demoDayCounts[i],
        ),
    ];
  }

  /// ISO-like week number, good enough for display.
  int get weekNumber {
    final firstDayOfYear = DateTime(_today.year);
    return ((_today.difference(firstDayOfYear).inDays +
                firstDayOfYear.weekday) /
            7)
        .ceil();
  }

  int get doneCount => _tasks.where((t) => t.isDone).length;

  int get dayPoints => _tasks.fold(0, (sum, t) => sum + t.points);

  void selectDay(DateTime date) {
    _selectedDate = _dateOnly(date);
    notifyListeners();
  }

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
