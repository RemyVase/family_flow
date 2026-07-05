import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/services/task_service.dart';

/// Encouragement message shown on the progress card.
enum HomeProgressMessage { start, keepGoing, almost, allDone }

/// State of the home screen ("my tasks today"), backed by [TaskService].
class HomeController extends ChangeNotifier {
  HomeController(this._taskService) {
    _taskService.addListener(notifyListeners);
  }

  final TaskService _taskService;

  List<Task> get tasks => _taskService.tasks;

  /// Tasks shown in a moment section: assigned ones, plus finished ones.
  List<Task> tasksFor(TaskMoment moment) => tasks
      .where((t) => t.moment == moment && (!t.isUnassigned || t.isDone))
      .toList();

  int get unassignedCount => _taskService.unassignedTasks.length;

  int get totalCount => tasks.length;

  int get doneCount => tasks.where((t) => t.isDone).length;

  int get remainingCount => totalCount - doneCount;

  int get pointsToday =>
      tasks.where((t) => t.isDone).fold(0, (sum, t) => sum + t.points);

  double get progress => totalCount == 0 ? 0 : doneCount / totalCount;

  bool get isAllDone => totalCount > 0 && doneCount == totalCount;

  HomeProgressMessage get progressMessage {
    if (isAllDone) return HomeProgressMessage.allDone;
    if (doneCount == 0) return HomeProgressMessage.start;
    if (remainingCount <= 2) return HomeProgressMessage.almost;
    return HomeProgressMessage.keepGoing;
  }

  void toggleTask(String taskId) => _taskService.toggleTask(taskId);

  @override
  void dispose() {
    _taskService.removeListener(notifyListeners);
    super.dispose();
  }
}
