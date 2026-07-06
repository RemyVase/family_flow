import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';
import 'package:our_tribe/shared/utils/task_moment_style.dart';

/// How the new task gets its owner.
enum TaskAssignment { person, rotate, unassigned }

/// State of the "new task" form; creation goes through [TaskService].
class TaskCreateController extends ChangeNotifier {
  TaskCreateController(this._taskService, TribeService tribeService)
    : _memberId = tribeService.currentMember.id;

  static const int minPoints = 1;
  static const int maxPoints = 9;

  final TaskService _taskService;

  String _name = '';
  String get name => _name;

  String _description = '';
  String get description => _description;

  TaskAssignment _assignment = TaskAssignment.person;

  String _memberId;
  String get memberId => _memberId;

  int _points = 2;
  int get points => _points;

  TaskRecurrence _recurrence = TaskRecurrence.once;
  TaskRecurrence get recurrence => _recurrence;

  TaskMoment _moment = TaskMoment.evening;
  TaskMoment get moment => _moment;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  bool _hasError = false;
  bool get hasError => _hasError;

  bool get isRecurring => _recurrence != TaskRecurrence.once;

  /// "Taking turns" only makes sense for a recurring task; fall back to
  /// "one person" when the recurrence is switched back to once.
  TaskAssignment get assignment =>
      (_assignment == TaskAssignment.rotate && !isRecurring)
      ? TaskAssignment.person
      : _assignment;

  bool get canCreate => !_isSubmitting && _name.trim().isNotEmpty;
  bool get canDecrementPoints => _points > minPoints;
  bool get canIncrementPoints => _points < maxPoints;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void selectAssignment(TaskAssignment value) {
    _assignment = value;
    notifyListeners();
  }

  void selectMember(String id) {
    _memberId = id;
    notifyListeners();
  }

  void incrementPoints() {
    if (!canIncrementPoints) return;
    _points++;
    notifyListeners();
  }

  void decrementPoints() {
    if (!canDecrementPoints) return;
    _points--;
    notifyListeners();
  }

  void selectRecurrence(TaskRecurrence value) {
    _recurrence = value;
    notifyListeners();
  }

  void selectMoment(TaskMoment value) {
    _moment = value;
    notifyListeners();
  }

  /// Creates the task in the shared store; returns false when invalid or
  /// on error.
  Future<bool> createTask() async {
    if (!canCreate) return false;
    _isSubmitting = true;
    _hasError = false;
    notifyListeners();
    final trimmedDescription = _description.trim();
    try {
      await _taskService.addTask(
        Task(
          // The backend assigns the real id on creation.
          id: '',
          name: _name.trim(),
          description: trimmedDescription.isEmpty ? null : trimmedDescription,
          moment: _moment,
          time: _moment.defaultTime,
          points: _points,
          recurrence: _recurrence,
          memberId: assignment == TaskAssignment.person ? _memberId : null,
          isRotating: assignment == TaskAssignment.rotate,
        ),
      );
      return true;
    } catch (e, st) {
      _hasError = true;
      await reportError(e, st);
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
