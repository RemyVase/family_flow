import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/repositories/task_repository.dart';

/// Firestore implementation of [TaskRepository].
class FirestoreTaskRepository implements TaskRepository {
  FirestoreTaskRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Task> _tasks(String tribeId) => _firestore
      .collection('tribes')
      .doc(tribeId)
      .collection('tasks')
      .withConverter<Task>(
        fromFirestore: (snap, _) =>
            Task.fromJson({...snap.data()!, 'id': snap.id}),
        toFirestore: (task, _) => task.toJson()..remove('id'),
      );

  @override
  Stream<List<Task>> watchTasks(String tribeId) => _tasks(
    tribeId,
  ).snapshots().map((query) => query.docs.map((doc) => doc.data()).toList());

  @override
  Future<void> addTask(String tribeId, Task task) =>
      _tasks(tribeId).doc().set(task);

  @override
  Future<void> saveTask(String tribeId, Task task) =>
      _tasks(tribeId).doc(task.id).set(task);

  @override
  Future<void> deleteTask(String tribeId, String taskId) =>
      _tasks(tribeId).doc(taskId).delete();
}
