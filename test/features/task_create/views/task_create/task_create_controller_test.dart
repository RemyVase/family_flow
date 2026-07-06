import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_controller.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

import '../../../../helpers/test_stack.dart';

void main() {
  Future<(TaskCreateController, TestStack)> buildController() async {
    final stack = await TestStack.signedInWithTribe();
    return (TaskCreateController(stack.taskService, stack.tribeService), stack);
  }

  group('TaskCreateController', () {
    test('should default the assignee to the signed-in member', () async {
      final (controller, _) = await buildController();

      expect(controller.memberId, 'lea');
    });

    test('should not allow creation while the name is empty', () async {
      final (controller, _) = await buildController();

      expect(controller.canCreate, isFalse);

      controller.setName('  ');
      expect(controller.canCreate, isFalse);

      controller.setName('Sortir les poubelles');
      expect(controller.canCreate, isTrue);
    });

    test('should clamp points between min and max', () async {
      final (controller, _) = await buildController();

      controller.decrementPoints();
      expect(controller.points, TaskCreateController.minPoints);
      expect(controller.canDecrementPoints, isFalse);

      for (var i = 0; i < 20; i++) {
        controller.incrementPoints();
      }
      expect(controller.points, TaskCreateController.maxPoints);
      expect(controller.canIncrementPoints, isFalse);
    });

    test('should update selections and notify listeners', () async {
      final (controller, _) = await buildController();
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

    test(
      'should fall back to one person when rotate loses its recurrence',
      () async {
        final (controller, _) = await buildController();

        controller.selectRecurrence(TaskRecurrence.daily);
        controller.selectAssignment(TaskAssignment.rotate);
        expect(controller.assignment, TaskAssignment.rotate);

        controller.selectRecurrence(TaskRecurrence.once);
        expect(controller.assignment, TaskAssignment.person);
      },
    );

    test('should create an assigned task in the shared store', () async {
      final (controller, stack) = await buildController();

      controller.setName('Sortir les poubelles');
      controller.selectMember('tom');

      expect(await controller.createTask(), isTrue);
      await pumpEventQueue();

      expect(stack.taskService.tasks.single.memberId, 'tom');
      expect(stack.taskService.tasks.single.isRotating, isFalse);
    });

    test(
      'should create an unassigned task when up for grabs is chosen',
      () async {
        final (controller, stack) = await buildController();

        controller.setName('Lessive');
        controller.selectAssignment(TaskAssignment.unassigned);

        expect(await controller.createTask(), isTrue);
        await pumpEventQueue();

        expect(stack.taskService.tasks.single.memberId, isNull);
        expect(stack.taskService.unassignedTasks.length, 1);
      },
    );

    test('should refuse to create a task without a name', () async {
      final (controller, stack) = await buildController();

      expect(await controller.createTask(), isFalse);
      await pumpEventQueue();

      expect(stack.taskService.tasks, isEmpty);
    });
  });
}
