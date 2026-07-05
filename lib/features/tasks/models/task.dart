import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

part 'task.freezed.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String name,
    required TaskMoment moment,
    required String time,
    required int points,
    required String memberId,
    @Default(TaskRecurrence.once) TaskRecurrence recurrence,
    @Default(false) bool isDone,
    @Default(false) bool hasPhoto,
    String? description,
  }) = _Task;
}
