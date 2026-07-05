import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/services/task_service.dart';

/// State of the "up for grabs" screen, backed by [TaskService].
class UnassignedController extends ChangeNotifier {
  UnassignedController(this._taskService) {
    _taskService.addListener(notifyListeners);
  }

  final TaskService _taskService;

  List<Task> get tasks => _taskService.unassignedTasks;

  bool get isEmpty => tasks.isEmpty;

  void assignTask(String taskId, String memberId) =>
      _taskService.assignTask(taskId, memberId);

  @override
  void dispose() {
    _taskService.removeListener(notifyListeners);
    super.dispose();
  }
}
