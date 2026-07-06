import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/views/unassigned/unassigned_controller.dart';

import '../../../../helpers/test_stack.dart';

const _tasks = [
  Task(
    id: 'a',
    name: 'Unassigned task',
    moment: TaskMoment.morning,
    time: '8:00',
    points: 2,
  ),
  Task(
    id: 'b',
    name: 'Assigned task',
    moment: TaskMoment.evening,
    time: '19:00',
    points: 1,
    memberId: 'lea',
  ),
];

void main() {
  group('UnassignedController', () {
    test('should expose only unassigned pending tasks', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);
      final controller = UnassignedController(stack.taskService);

      expect(controller.tasks.single.id, 'a');
      expect(controller.isEmpty, isFalse);
    });

    test('should become empty and notify when the task is assigned', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);
      final controller = UnassignedController(stack.taskService);
      var notified = false;
      controller.addListener(() => notified = true);

      controller.assignTask('a', 'tom');
      await pumpEventQueue();

      expect(controller.isEmpty, isTrue);
      expect(notified, isTrue);
    });
  });
}
