import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// State of the task detail screen: the live task from [TaskService]
/// (falling back to the task passed at navigation time).
class TaskDetailController extends ChangeNotifier {
  TaskDetailController(this._taskService, Task task) : _initialTask = task {
    _taskService.addListener(notifyListeners);
  }

  final TaskService _taskService;
  final Task _initialTask;

  Task get task => _taskService.taskById(_initialTask.id) ?? _initialTask;

  void toggleDone() {
    unawaited(_taskService.toggleTask(task.id).onError(reportError));
  }

  @override
  void dispose() {
    _taskService.removeListener(notifyListeners);
    super.dispose();
  }
}
