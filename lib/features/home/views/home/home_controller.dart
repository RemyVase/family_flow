import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/mock_tasks.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';

/// Encouragement message shown on the progress card.
enum HomeProgressMessage { start, keepGoing, almost, allDone }

/// State of the home screen ("my tasks today"). Mock data for now.
class HomeController extends ChangeNotifier {
  HomeController({List<Task>? tasks})
    : _tasks = List.of(tasks ?? MockTasks.today);

  final List<Task> _tasks;

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> tasksFor(TaskMoment moment) =>
      _tasks.where((t) => t.moment == moment).toList();

  int get totalCount => _tasks.length;

  int get doneCount => _tasks.where((t) => t.isDone).length;

  int get remainingCount => totalCount - doneCount;

  int get pointsToday =>
      _tasks.where((t) => t.isDone).fold(0, (sum, t) => sum + t.points);

  double get progress => totalCount == 0 ? 0 : doneCount / totalCount;

  bool get isAllDone => totalCount > 0 && doneCount == totalCount;

  HomeProgressMessage get progressMessage {
    if (isAllDone) return HomeProgressMessage.allDone;
    if (doneCount == 0) return HomeProgressMessage.start;
    if (remainingCount <= 2) return HomeProgressMessage.almost;
    return HomeProgressMessage.keepGoing;
  }

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }
}
