import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_controller.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/services/task_service.dart';

void main() {
  group('TaskCreateController', () {
    test('should not allow creation while the name is empty', () {
      final controller = TaskCreateController(TaskService());

      expect(controller.canCreate, isFalse);

      controller.setName('  ');
      expect(controller.canCreate, isFalse);

      controller.setName('Sortir les poubelles');
      expect(controller.canCreate, isTrue);
    });

    test('should clamp points between min and max', () {
      final controller = TaskCreateController(TaskService());

      controller.decrementPoints();
      expect(controller.points, TaskCreateController.minPoints);
      expect(controller.canDecrementPoints, isFalse);

      for (var i = 0; i < 20; i++) {
        controller.incrementPoints();
      }
      expect(controller.points, TaskCreateController.maxPoints);
      expect(controller.canIncrementPoints, isFalse);
    });

    test('should update selections and notify listeners', () {
      final controller = TaskCreateController(TaskService());
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.selectMember('tom');
      controller.selectRecurrence(TaskRecurrence.daily);
      controller.selectMoment(TaskMoment.morning);

      expect(controller.memberId, 'tom');
      expect(controller.recurrence, TaskRecurrence.daily);
      expect(controller.moment, TaskMoment.morning);
      expect(notifications, 3);
    });
    test('should fall back to one person when rotate loses its recurrence', () {
      final controller = TaskCreateController(TaskService());

      controller.selectRecurrence(TaskRecurrence.daily);
      controller.selectAssignment(TaskAssignment.rotate);
      expect(controller.assignment, TaskAssignment.rotate);

      controller.selectRecurrence(TaskRecurrence.once);
      expect(controller.assignment, TaskAssignment.person);
    });

    test('should create an assigned task in the shared store', () {
      final service = TaskService(tasks: const []);
      final controller = TaskCreateController(service);

      controller.setName('Sortir les poubelles');
      controller.selectMember('tom');

      expect(controller.createTask(), isTrue);
      expect(service.tasks.single.memberId, 'tom');
      expect(service.tasks.single.isRotating, isFalse);
    });

    test('should create an unassigned task when up for grabs is chosen', () {
      final service = TaskService(tasks: const []);
      final controller = TaskCreateController(service);

      controller.setName('Lessive');
      controller.selectAssignment(TaskAssignment.unassigned);

      expect(controller.createTask(), isTrue);
      expect(service.tasks.single.memberId, isNull);
      expect(service.unassignedTasks.length, 1);
    });

    test('should refuse to create a task without a name', () {
      final service = TaskService(tasks: const []);
      final controller = TaskCreateController(service);

      expect(controller.createTask(), isFalse);
      expect(service.tasks, isEmpty);
    });
  });
}
