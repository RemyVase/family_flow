import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';

import '../helpers/test_stack.dart';

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
    points: 3,
    memberId: 'lea',
  ),
];

void main() {
  group('TaskService', () {
    test(
      'should stream the tribe tasks and expose the unassigned ones',
      () async {
        final stack = await TestStack.signedInWithTribe(tasks: _tasks);

        expect(stack.taskService.tasks.length, 2);
        expect(stack.taskService.unassignedTasks.single.id, 'a');
      },
    );

    test('should toggle a task and credit the assignee counters', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);

      await stack.taskService.toggleTask('b');
      await pumpEventQueue();

      expect(stack.taskService.taskById('b')!.isDone, isTrue);
      final lea = stack.tribeService.memberById('lea');
      expect(lea.weeklyPoints, 26 + 3);
      expect(lea.weeklyTasksDone, 11 + 1);
    });

    test('should debit the counters when a task is unchecked', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);

      await stack.taskService.toggleTask('b');
      await pumpEventQueue();
      await stack.taskService.toggleTask('b');
      await pumpEventQueue();

      expect(stack.taskService.taskById('b')!.isDone, isFalse);
      final lea = stack.tribeService.memberById('lea');
      expect(lea.weeklyPoints, 26);
      expect(lea.weeklyTasksDone, 11);
    });

    test('should assign an up-for-grabs task to a member', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);

      await stack.taskService.assignTask('a', 'tom');
      await pumpEventQueue();

      expect(stack.taskService.taskById('a')!.memberId, 'tom');
      expect(stack.taskService.unassignedTasks, isEmpty);
    });

    test('should create a task with a backend-assigned id', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.taskService.addTask(_tasks.first.copyWith(id: ''));
      await pumpEventQueue();

      final created = stack.taskService.tasks.single;
      expect(created.id, isNotEmpty);
      expect(created.name, 'Unassigned task');
    });

    test('should clear the tasks after signing out', () async {
      final stack = await TestStack.signedInWithTribe(tasks: _tasks);

      stack.authRepository.setUser(null);
      await pumpEventQueue();

      expect(stack.taskService.tasks, isEmpty);
    });
  });
}
