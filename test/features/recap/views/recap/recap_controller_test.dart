import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';

import '../../../../helpers/test_stack.dart';

const _tasks = [
  Task(
    id: 'a',
    name: 'Recurring done task',
    moment: TaskMoment.morning,
    time: '8:00',
    points: 2,
    memberId: 'lea',
    recurrence: TaskRecurrence.daily,
    isDone: true,
  ),
  Task(
    id: 'b',
    name: 'Pending task',
    moment: TaskMoment.evening,
    time: '19:00',
    points: 1,
    memberId: 'tom',
  ),
];

void main() {
  Future<RecapController> buildController() async {
    final stack = await TestStack.signedInWithTribe(tasks: _tasks);
    return RecapController(stack.tribeService, stack.taskService);
  }

  group('RecapController', () {
    test('should compute totals and reward progress from the tribe', () async {
      final controller = await buildController();

      expect(controller.totalPoints, 56);
      expect(controller.maxMemberPoints, 30);
      expect(controller.rewardProgress, 0.56);
      expect(controller.rewardRemaining, 44);
    });

    test('should filter tasks per selected filter', () async {
      final controller = await buildController();

      expect(controller.filteredTasks.length, 2);

      controller.selectFilter(TaskFilter.done);
      expect(controller.filteredTasks.single.id, 'a');

      controller.selectFilter(TaskFilter.todo);
      expect(controller.filteredTasks.single.id, 'b');

      controller.selectFilter(TaskFilter.recurring);
      expect(controller.filteredTasks.single.id, 'a');
    });

    test('should switch segments and notify listeners', () async {
      final controller = await buildController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.selectSegment(RecapSegment.tasks);

      expect(controller.segment, RecapSegment.tasks);
      expect(notified, isTrue);
    });

    test('should toggle a task through the shared store', () async {
      final controller = await buildController();

      controller.toggleTask('b');
      await pumpEventQueue();

      expect(controller.countFor(TaskFilter.done), 2);
    });
  });
}
