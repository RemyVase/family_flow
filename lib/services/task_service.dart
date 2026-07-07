import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/repositories/task_repository.dart';
import 'package:our_tribe/services/analytics_service.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// App-wide state of the tribe's tasks, streamed from the backend.
///
/// Shared by the home screen, the "up for grabs" screen and the create form
/// so an assignment or a creation is reflected everywhere. Completing a task
/// also feeds the member's weekly counters (via [TribeService]), which is
/// why this orchestration lives in a cross-feature service.
class TaskService extends ChangeNotifier {
  TaskService(
    this._taskRepository,
    this._tribeService,
    this._authService,
    this._analytics,
  ) {
    _authService.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  final TaskRepository _taskRepository;
  final TribeService _tribeService;
  final AuthService _authService;
  final AnalyticsService _analytics;

  String? _tribeId;
  List<Task> _tasks = const [];
  StreamSubscription<List<Task>>? _tasksSub;

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get unassignedTasks =>
      _tasks.where((t) => t.isUnassigned && !t.isDone).toList();

  Task? taskById(String taskId) =>
      _tasks.where((t) => t.id == taskId).firstOrNull;

  void _onAuthChanged() {
    final tribeId = _authService.tribeId;
    if (tribeId == _tribeId) return;
    _tribeId = tribeId;
    _tasksSub?.cancel();
    _tasks = const [];
    if (tribeId != null) {
      _tasksSub = _taskRepository.watchTasks(tribeId).listen((tasks) {
        _tasks = tasks;
        notifyListeners();
      }, onError: reportError);
    }
    notifyListeners();
  }

  /// Flips a task's done state and credits/debits the assignee's weekly
  /// counters.
  Future<void> toggleTask(String taskId) async {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;
    final toggled = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    _tasks = [..._tasks];
    _tasks[index] = toggled;
    notifyListeners();
    if (toggled.isDone) {
      _analytics.logTaskCompleted(points: toggled.points);
    } else {
      _analytics.logTaskUnchecked(points: toggled.points);
    }
    await _taskRepository.saveTask(_tribeId!, toggled);
    final memberId = toggled.memberId;
    if (memberId != null) {
      await _tribeService.addPoints(
        memberId,
        points: toggled.isDone ? toggled.points : -toggled.points,
      );
    }
  }

  /// Gives an unassigned task to a member; it then joins its moment section.
  Future<void> assignTask(String taskId, String memberId) {
    final task = taskById(taskId);
    if (task == null) return Future.value();
    _analytics.logTaskAssigned();
    return _taskRepository.saveTask(
      _tribeId!,
      task.copyWith(memberId: memberId),
    );
  }

  Future<void> addTask(Task task) {
    _analytics.logTaskCreated(
      assignment: task.isRotating
          ? 'rotate'
          : (task.isUnassigned ? 'unassigned' : 'person'),
      points: task.points,
      recurrence: task.recurrence.name,
      moment: task.moment.name,
    );
    return _taskRepository.addTask(_tribeId!, task);
  }

  @override
  void dispose() {
    _authService.removeListener(_onAuthChanged);
    _tasksSub?.cancel();
    super.dispose();
  }
}
