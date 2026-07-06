import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/features/tasks/repositories/firestore_task_repository.dart';

const _task = Task(
  id: '',
  name: 'Sortir les poubelles',
  moment: TaskMoment.afternoon,
  time: '17:00',
  points: 3,
  memberId: 'lea',
  recurrence: TaskRecurrence.weekly,
  isRotating: true,
  description: 'Ne pas oublier le verre',
);

void main() {
  group('FirestoreTaskRepository', () {
    test('should round-trip a task through Firestore untouched', () async {
      final repository = FirestoreTaskRepository(FakeFirebaseFirestore());

      await repository.addTask('tribe-1', _task);

      final stored = (await repository.watchTasks('tribe-1').first).single;
      expect(stored.id, isNotEmpty);
      expect(stored.copyWith(id: ''), _task);
    });

    test('should overwrite a task in place with saveTask', () async {
      final repository = FirestoreTaskRepository(FakeFirebaseFirestore());
      await repository.addTask('tribe-1', _task);
      final stored = (await repository.watchTasks('tribe-1').first).single;

      await repository.saveTask('tribe-1', stored.copyWith(isDone: true));

      final updated = (await repository.watchTasks('tribe-1').first).single;
      expect(updated.id, stored.id);
      expect(updated.isDone, isTrue);
    });

    test('should delete a task', () async {
      final repository = FirestoreTaskRepository(FakeFirebaseFirestore());
      await repository.addTask('tribe-1', _task);
      final stored = (await repository.watchTasks('tribe-1').first).single;

      await repository.deleteTask('tribe-1', stored.id);

      expect(await repository.watchTasks('tribe-1').first, isEmpty);
    });
  });
}
