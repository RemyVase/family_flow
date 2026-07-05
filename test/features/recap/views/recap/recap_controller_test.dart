import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';

void main() {
  const members = [
    Member(
      id: 'lea',
      name: 'Léa',
      color: AppColors.memberTerracotta,
      isCurrentUser: true,
      weeklyPoints: 60,
    ),
    Member(
      id: 'tom',
      name: 'Tom',
      color: AppColors.memberPurple,
      weeklyPoints: 30,
    ),
  ];

  const tasks = [
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

  RecapController buildController() =>
      RecapController(TribeService(members: members), tasks: tasks);

  group('RecapController', () {
    test('should compute totals and reward progress from the tribe', () {
      final controller = buildController();

      expect(controller.totalPoints, 90);
      expect(controller.maxMemberPoints, 60);
      expect(controller.rewardProgress, 0.9);
      expect(controller.rewardRemaining, 10);
    });

    test('should filter tasks per selected filter', () {
      final controller = buildController();

      expect(controller.filteredTasks.length, 2);

      controller.selectFilter(TaskFilter.done);
      expect(controller.filteredTasks.single.id, 'a');

      controller.selectFilter(TaskFilter.todo);
      expect(controller.filteredTasks.single.id, 'b');

      controller.selectFilter(TaskFilter.recurring);
      expect(controller.filteredTasks.single.id, 'a');
    });

    test('should switch segments and notify listeners', () {
      final controller = buildController();
      var notified = false;
      controller.addListener(() => notified = true);

      controller.selectSegment(RecapSegment.tasks);

      expect(controller.segment, RecapSegment.tasks);
      expect(notified, isTrue);
    });
  });
}
