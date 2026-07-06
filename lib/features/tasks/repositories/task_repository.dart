import 'package:our_tribe/features/tasks/models/task.dart';

/// Contract for the task store (`tribes/{tribeId}/tasks`).
abstract class TaskRepository {
  Stream<List<Task>> watchTasks(String tribeId);

  /// Creates the task; the backend assigns the id ([task.id] is ignored).
  Future<void> addTask(String tribeId, Task task);

  /// Overwrites an existing task.
  Future<void> saveTask(String tribeId, Task task);

  Future<void> deleteTask(String tribeId, String taskId);
}
