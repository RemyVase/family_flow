import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/analytics/models/analytics_event.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';

import '../helpers/test_stack.dart';

const _task = Task(
  id: 't1',
  name: 'Sortir les poubelles',
  moment: TaskMoment.evening,
  time: '19:00',
  points: 3,
  memberId: 'lea',
);

void main() {
  group('Analytics instrumentation', () {
    test('should tag events with the signed-in user', () async {
      final stack = TestStack();
      await stack.authService.signUp(
        firstName: 'Zoé',
        email: 'z@t.be',
        password: 'secret6',
      );
      await pumpEventQueue();

      expect(stack.analyticsRepository.userId, 'new-user');
      expect(
        stack.analyticsRepository.eventNames,
        contains(AnalyticsEvent.signUp),
      );
    });

    test('should clear the user and their properties on sign-out', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.authService.signOut();
      await pumpEventQueue();

      expect(stack.analyticsRepository.userId, isNull);
      expect(stack.analyticsRepository.userProperties['role'], isNull);
      expect(stack.analyticsRepository.userProperties['tribe_size'], isNull);
      expect(
        stack.analyticsRepository.eventNames,
        contains(AnalyticsEvent.logout),
      );
    });

    test('should log login on sign-in', () async {
      final stack = TestStack();
      await stack.authService.signIn(email: 'z@t.be', password: 'secret6');
      await pumpEventQueue();

      expect(
        stack.analyticsRepository.eventNames,
        contains(AnalyticsEvent.login),
      );
    });

    test('should set role and tribe size as user properties', () async {
      final stack = await TestStack.signedInWithTribe();

      expect(stack.analyticsRepository.userProperties['role'], 'chief');
      expect(stack.analyticsRepository.userProperties['tribe_size'], '2');
    });

    test('should log tribe creation', () async {
      final stack = TestStack(userId: 'new-user');
      await stack.userRepository.saveUser(
        const AppUser(id: 'new-user', firstName: 'Zoé', email: 'z@t.be'),
      );
      await pumpEventQueue();

      await stack.tribeService.createTribe(
        name: 'Les Dubois',
        color: testMembers.first.color,
        memberName: 'Zoé',
      );
      await pumpEventQueue();

      expect(
        stack.analyticsRepository.eventNames,
        contains(AnalyticsEvent.tribeCreated),
      );
    });

    test('should log task creation with its parameters', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.taskService.addTask(_task.copyWith(id: ''));
      await pumpEventQueue();

      final recorded = stack.analyticsRepository.events.singleWhere(
        (e) => e.event == AnalyticsEvent.taskCreated,
      );
      expect(recorded.params, {
        'assignment': 'person',
        'points': 3,
        'recurrence': 'once',
        'moment': 'evening',
      });
    });

    test('should log completion and uncheck of a task', () async {
      final stack = await TestStack.signedInWithTribe(tasks: [_task]);

      await stack.taskService.toggleTask('t1');
      await pumpEventQueue();
      await stack.taskService.toggleTask('t1');
      await pumpEventQueue();

      expect(
        stack.analyticsRepository.eventNames,
        containsAllInOrder([
          AnalyticsEvent.taskCompleted,
          AnalyticsEvent.taskUnchecked,
        ]),
      );
    });

    test('should log tribe left with the deletion flag', () async {
      final stack = await TestStack.signedInWithTribe(
        members: [testMembers.first],
      );

      await stack.tribeService.leaveTribe();
      await pumpEventQueue();

      final recorded = stack.analyticsRepository.events.singleWhere(
        (e) => e.event == AnalyticsEvent.tribeLeft,
      );
      expect(recorded.params, {'tribe_deleted': 'true'});
    });

    test('should log the notification permission outcome', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.notificationService.requestPermission();
      await pumpEventQueue();

      final recorded = stack.analyticsRepository.events.singleWhere(
        (e) => e.event == AnalyticsEvent.notificationPermission,
      );
      expect(recorded.params, {'granted': 'true'});
    });
  });
}
