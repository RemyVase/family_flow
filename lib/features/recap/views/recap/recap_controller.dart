import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/settings/models/mock_rewards.dart';
import 'package:our_tribe/features/tasks/models/mock_tasks.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/services/tribe_service.dart';

/// Sub-tabs of the recap screen.
enum RecapSegment { summary, tasks }

/// Filters of the family task list sub-tab.
enum TaskFilter { all, todo, done, recurring }

/// State of the family recap screen. Mock data for now.
class RecapController extends ChangeNotifier {
  RecapController(this._tribeService, {List<Task>? tasks})
    : _tasks = List.of(tasks ?? MockTasks.week);

  final TribeService _tribeService;
  final List<Task> _tasks;

  /// Weekly tribe goal (demo values).
  static const int rewardGoal = MockRewards.tribeGoalPoints;
  static const String rewardName = MockRewards.tribeGoalName;
  static const int deltaVsLastWeek = 12;

  RecapSegment _segment = RecapSegment.summary;
  RecapSegment get segment => _segment;

  TaskFilter _filter = TaskFilter.all;
  TaskFilter get filter => _filter;

  List<Task> get tasks => List.unmodifiable(_tasks);

  int get totalPoints => _tribeService.weeklyTotalPoints;

  int get maxMemberPoints => _tribeService.members
      .map((m) => m.weeklyPoints)
      .fold(0, (a, b) => a > b ? a : b);

  double get rewardProgress =>
      (totalPoints / rewardGoal).clamp(0, 1).toDouble();

  int get rewardRemaining => (rewardGoal - totalPoints).clamp(0, rewardGoal);

  List<Task> get filteredTasks => switch (_filter) {
    TaskFilter.all => tasks,
    TaskFilter.todo => _tasks.where((t) => !t.isDone).toList(),
    TaskFilter.done => _tasks.where((t) => t.isDone).toList(),
    TaskFilter.recurring =>
      _tasks.where((t) => t.recurrence != TaskRecurrence.once).toList(),
  };

  int countFor(TaskFilter filter) => switch (filter) {
    TaskFilter.all => _tasks.length,
    TaskFilter.todo => _tasks.where((t) => !t.isDone).length,
    TaskFilter.done => _tasks.where((t) => t.isDone).length,
    TaskFilter.recurring =>
      _tasks.where((t) => t.recurrence != TaskRecurrence.once).length,
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
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }
}
