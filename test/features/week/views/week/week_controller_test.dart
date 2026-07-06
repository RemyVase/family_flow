import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/week/views/week/week_controller.dart';

import '../../../../helpers/test_stack.dart';

const _tasks = [
  Task(
    id: 'a',
    name: 'Task A',
    moment: TaskMoment.morning,
    time: '8:00',
    points: 2,
    memberId: 'lea',
    isDone: true,
  ),
  Task(
    id: 'b',
    name: 'Task B',
    moment: TaskMoment.evening,
    time: '19:00',
    points: 3,
    memberId: 'tom',
  ),
];

void main() {
  // Fixed clock so the tests are deterministic: Wednesday 2026-07-08, 14:02.
  final now = DateTime(2026, 7, 8, 14, 2);

  Future<WeekController> buildController() async {
    final stack = await TestStack.signedInWithTribe(tasks: _tasks);
    return WeekController(stack.taskService, now: now);
  }

  group('WeekController', () {
    test('should build a Monday-to-Sunday strip around today', () async {
      final controller = await buildController();

      expect(controller.days.length, 7);
      expect(controller.days.first.date.weekday, DateTime.monday);
      expect(controller.days.last.date.weekday, DateTime.sunday);
      expect(controller.selectedDate, DateTime(2026, 7, 8));
    });

    test('should compute day counters and points', () async {
      final controller = await buildController();

      expect(controller.doneCount, 1);
      expect(controller.dayPoints, 5);
    });

    test('should sort the timeline and place the now marker', () async {
      final controller = await buildController();

      expect(controller.tasks.first.id, 'a');
      expect(controller.tasks.last.id, 'b');
      // 14:02 sits after the 8:00 task and before the 19:00 one.
      expect(controller.nowAfterTaskId, 'a');
      expect(controller.nowTimeLabel, '14:02');
    });

    test('should hide the now marker on another day', () async {
      final controller = await buildController();

      controller.selectDay(DateTime(2026, 7, 10, 15));

      expect(controller.selectedDate, DateTime(2026, 7, 10));
      expect(controller.nowAfterTaskId, isNull);
    });

    test('should toggle a task with notification', () async {
      final controller = await buildController();
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.toggleTask('b');
      await pumpEventQueue();

      expect(controller.doneCount, 2);
      expect(notifications, greaterThanOrEqualTo(1));
    });
  });
}
