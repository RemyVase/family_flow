import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';

/// State of the task detail screen. Works on a local copy of the task
/// while the app is design-only (no shared task store yet).
class TaskDetailController extends ChangeNotifier {
  TaskDetailController(Task task) : _task = task;

  Task _task;
  Task get task => _task;

  void toggleDone() {
    _task = _task.copyWith(isDone: !_task.isDone);
    notifyListeners();
  }
}
