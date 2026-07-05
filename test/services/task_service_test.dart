import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/services/task_service.dart';

void main() {
  const tasks = [
    Task(
      id: 'a',
      name: 'Assigned task',
      moment: TaskMoment.morning,
      time: '8:00',
      points: 2,
      memberId: 'lea',
    ),
    Task(
      id: 'b',
      name: 'Unassigned task',
      moment: TaskMoment.evening,
      time: '19:00',
      points: 1,
    ),
  ];

  group('TaskService', () {
    test('should list only pending unassigned tasks', () {
      final service = TaskService(tasks: tasks);

      expect(service.unassignedTasks.single.id, 'b');
    });

    test('should toggle a task and notify listeners', () {
      final service = TaskService(tasks: tasks);
      var notified = false;
      service.addListener(() => notified = true);

      service.toggleTask('a');

      expect(service.tasks.first.isDone, isTrue);
      expect(notified, isTrue);
    });

    test('should move an assigned task out of the unassigned list', () {
      final service = TaskService(tasks: tasks);

      service.assignTask('b', 'tom');

      expect(service.unassignedTasks, isEmpty);
      expect(service.tasks.last.memberId, 'tom');
    });

    test('should ignore toggling or assigning an unknown task', () {
      final service = TaskService(tasks: tasks);

      service.toggleTask('unknown');
      service.assignTask('unknown', 'tom');

      expect(service.tasks.length, 2);
      expect(service.unassignedTasks.length, 1);
    });

    test('should append a created task', () {
      final service = TaskService(tasks: tasks);

      service.addTask(
        const Task(
          id: 'c',
          name: 'New task',
          moment: TaskMoment.afternoon,
          time: '17:00',
          points: 3,
        ),
      );

      expect(service.tasks.length, 3);
      expect(service.unassignedTasks.length, 2);
    });
  });
}
