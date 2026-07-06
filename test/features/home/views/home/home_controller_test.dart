import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';

import '../../../../helpers/test_stack.dart';

const _tasks = [
  Task(
    id: 'a',
    name: 'Task A',
    moment: TaskMoment.morning,
    time: '8:00',
    points: 2,
    memberId: 'lea',
  ),
  Task(
    id: 'b',
    name: 'Task B',
    moment: TaskMoment.evening,
    time: '19:00',
    points: 3,
    memberId: 'lea',
    isDone: true,
  ),
];

void main() {
  Future<HomeController> buildController() async {
    final stack = await TestStack.signedInWithTribe(tasks: _tasks);
    return HomeController(stack.taskService);
  }

  group('HomeController', () {
    test('should expose counts and points computed from tasks', () async {
      final controller = await buildController();

      expect(controller.totalCount, 2);
      expect(controller.doneCount, 1);
      expect(controller.remainingCount, 1);
      expect(controller.pointsToday, 3);
      expect(controller.progress, 0.5);
      expect(controller.isAllDone, isFalse);
    });

    test('should toggle a task and notify listeners', () async {
      final controller = await buildController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.toggleTask('a');
      await pumpEventQueue();

      expect(controller.doneCount, 2);
      expect(controller.isAllDone, isTrue);
      expect(controller.pointsToday, 5);
      expect(notified, isTrue);
    });

    test('should keep state unchanged when toggling an unknown task', () async {
      final controller = await buildController();

      controller.toggleTask('unknown');
      await pumpEventQueue();

      expect(controller.doneCount, 1);
    });

    test('should expose the right progress message per state', () async {
      final controller = await buildController();
      expect(controller.progressMessage, HomeProgressMessage.almost);

      controller.toggleTask('a');
      await pumpEventQueue();
      expect(controller.progressMessage, HomeProgressMessage.allDone);

      controller.toggleTask('a');
      await pumpEventQueue();
      controller.toggleTask('b');
      await pumpEventQueue();
      expect(controller.progressMessage, HomeProgressMessage.start);
    });

    test('should group tasks by moment when tasksFor is called', () async {
      final controller = await buildController();

      expect(controller.tasksFor(TaskMoment.morning).single.id, 'a');
      expect(controller.tasksFor(TaskMoment.afternoon), isEmpty);
    });
  });
}
