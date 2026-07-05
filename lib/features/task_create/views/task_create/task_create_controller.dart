import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/utils/task_moment_style.dart';

/// How the new task gets its owner.
enum TaskAssignment { person, rotate, unassigned }

/// State of the "new task" form. Creation feeds [TaskService] (mock store).
class TaskCreateController extends ChangeNotifier {
  TaskCreateController(this._taskService);

  static const int minPoints = 1;
  static const int maxPoints = 9;

  final TaskService _taskService;

  String _name = '';
  String get name => _name;

  String _description = '';
  String get description => _description;

  TaskAssignment _assignment = TaskAssignment.person;

  String _memberId = 'lea';
  String get memberId => _memberId;

  int _points = 2;
  int get points => _points;

  TaskRecurrence _recurrence = TaskRecurrence.once;
  TaskRecurrence get recurrence => _recurrence;

  TaskMoment _moment = TaskMoment.evening;
  TaskMoment get moment => _moment;

  bool get isRecurring => _recurrence != TaskRecurrence.once;

  /// "Taking turns" only makes sense for a recurring task; fall back to
  /// "one person" when the recurrence is switched back to once.
  TaskAssignment get assignment =>
      (_assignment == TaskAssignment.rotate && !isRecurring)
      ? TaskAssignment.person
      : _assignment;

  bool get canCreate => _name.trim().isNotEmpty;
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

  /// Adds the task to the shared store; returns false when invalid.
  bool createTask() {
    if (!canCreate) return false;
    final trimmedDescription = _description.trim();
    _taskService.addTask(
      Task(
        id: 'n${DateTime.now().microsecondsSinceEpoch}',
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
  }
}
