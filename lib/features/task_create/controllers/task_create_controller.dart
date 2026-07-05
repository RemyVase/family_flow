import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

/// State of the "new task" form. No persistence yet (design-only phase).
class TaskCreateController extends ChangeNotifier {
  static const int minPoints = 1;
  static const int maxPoints = 9;

  String _name = '';
  String get name => _name;

  String _description = '';
  String get description => _description;

  String _memberId = 'lea';
  String get memberId => _memberId;

  int _points = 2;
  int get points => _points;

  TaskRecurrence _recurrence = TaskRecurrence.once;
  TaskRecurrence get recurrence => _recurrence;

  TaskMoment _moment = TaskMoment.evening;
  TaskMoment get moment => _moment;

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
}
