import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/mock_tasks.dart';
import 'package:our_tribe/features/tasks/models/task.dart';

/// App-wide state of today's tasks.
///
/// Shared by the home screen, the "up for grabs" screen and the create
/// form so an assignment or a creation is reflected everywhere.
/// Backed by mock data while the app is design-only.
class TaskService extends ChangeNotifier {
  TaskService({List<Task>? tasks}) : _tasks = List.of(tasks ?? MockTasks.today);

  final List<Task> _tasks;

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get unassignedTasks =>
      _tasks.where((t) => t.isUnassigned && !t.isDone).toList();

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }

  /// Gives an unassigned task to a member; it then joins its moment section.
  void assignTask(String taskId, String memberId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    _tasks[index] = _tasks[index].copyWith(memberId: memberId);
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}
