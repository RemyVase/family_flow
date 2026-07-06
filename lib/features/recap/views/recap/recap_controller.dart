import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/settings/models/mock_rewards.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// Sub-tabs of the recap screen.
enum RecapSegment { summary, tasks }

/// Filters of the family task list sub-tab.
enum TaskFilter { all, todo, done, recurring }

/// State of the family recap screen, backed by the tribe and task services.
class RecapController extends ChangeNotifier {
  RecapController(this._tribeService, this._taskService) {
    _tribeService.addListener(notifyListeners);
    _taskService.addListener(notifyListeners);
  }

  final TribeService _tribeService;
  final TaskService _taskService;

  /// Weekly tribe goal (demo values until rewards get a backend).
  static const int rewardGoal = MockRewards.tribeGoalPoints;
  static const String rewardName = MockRewards.tribeGoalName;
  static const int deltaVsLastWeek = 12;

  RecapSegment _segment = RecapSegment.summary;
  RecapSegment get segment => _segment;

  TaskFilter _filter = TaskFilter.all;
  TaskFilter get filter => _filter;

  List<Task> get tasks => _taskService.tasks;

  int get totalPoints => _tribeService.weeklyTotalPoints;

  int get maxMemberPoints => _tribeService.members
      .map((m) => m.weeklyPoints)
      .fold(0, (a, b) => a > b ? a : b);

  double get rewardProgress =>
      (totalPoints / rewardGoal).clamp(0, 1).toDouble();

  int get rewardRemaining => (rewardGoal - totalPoints).clamp(0, rewardGoal);

  List<Task> get filteredTasks => switch (_filter) {
    TaskFilter.all => tasks,
    TaskFilter.todo => tasks.where((t) => !t.isDone).toList(),
    TaskFilter.done => tasks.where((t) => t.isDone).toList(),
    TaskFilter.recurring =>
      tasks.where((t) => t.recurrence != TaskRecurrence.once).toList(),
  };

  int countFor(TaskFilter filter) => switch (filter) {
    TaskFilter.all => tasks.length,
    TaskFilter.todo => tasks.where((t) => !t.isDone).length,
    TaskFilter.done => tasks.where((t) => t.isDone).length,
    TaskFilter.recurring =>
      tasks.where((t) => t.recurrence != TaskRecurrence.once).length,
  };

  void selectSegment(RecapSegment value) {
    _segment = value;
    notifyListeners();
  }

  void selectFilter(TaskFilter value) {
    _filter = value;
    notifyListeners();
  }

  void toggleTask(String taskId) {
    unawaited(_taskService.toggleTask(taskId).onError(reportError));
  }

  @override
  void dispose() {
    _tribeService.removeListener(notifyListeners);
    _taskService.removeListener(notifyListeners);
    super.dispose();
  }
}
