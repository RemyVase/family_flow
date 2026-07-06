import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String name,
    required TaskMoment moment,
    required String time,
    required int points,

    /// Assignee; null while the task is still up for grabs ("à répartir").
    String? memberId,
    @Default(TaskRecurrence.once) TaskRecurrence recurrence,

    /// Recurring task handed to a different member each time.
    @Default(false) bool isRotating,
    @Default(false) bool isDone,
    @Default(false) bool hasPhoto,
    String? description,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  bool get isUnassigned => memberId == null;
}
