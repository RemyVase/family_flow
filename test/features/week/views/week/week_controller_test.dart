import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/week/views/week/week_controller.dart';

void main() {
  const tasks = [
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

  // Fixed date so the tests are deterministic: Wednesday 2026-07-08.
  final today = DateTime(2026, 7, 8);

  group('WeekController', () {
    test('should build a Monday-to-Sunday strip around today', () {
      final controller = WeekController(today: today, tasks: tasks);

      expect(controller.days.length, 7);
      expect(controller.days.first.date.weekday, DateTime.monday);
      expect(controller.days.last.date.weekday, DateTime.sunday);
      expect(controller.selectedDate, DateTime(2026, 7, 8));
    });

    test('should compute day counters and points', () {
      final controller = WeekController(today: today, tasks: tasks);

      expect(controller.doneCount, 1);
      expect(controller.dayPoints, 5);
    });

    test('should select a day and toggle a task with notification', () {
      final controller = WeekController(today: today, tasks: tasks);
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.selectDay(DateTime(2026, 7, 10, 15));
      expect(controller.selectedDate, DateTime(2026, 7, 10));

      controller.toggleTask('b');
      expect(controller.doneCount, 2);
      expect(notifications, 2);
    });
  });
}
