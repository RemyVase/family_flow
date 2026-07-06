import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/notifications/models/notification_prefs.dart';
import 'package:our_tribe/features/notifications/models/reminder_lead_time.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';
import 'package:our_tribe/features/settings/views/notifications/notifications_controller.dart';

import '../../../../helpers/test_stack.dart';

void main() {
  group('NotificationsController', () {
    test('should start from the persisted preferences', () async {
      final stack = await TestStack.signedInWithTribe();
      await stack.notificationService.savePrefs(
        const NotificationPrefs(morningSummary: false),
      );
      await pumpEventQueue();

      final controller = NotificationsController(stack.notificationService);

      expect(controller.morningSummary, isFalse);
      expect(controller.masterEnabled, isTrue);
    });

    test('should edit every preference locally', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = NotificationsController(stack.notificationService);

      controller.setRemindTasks(false);
      controller.setLeadTime(ReminderLeadTime.oneHour);
      controller.setEveningReminder(false);
      controller.setOverdueAlert(false);
      controller.setTribeLifeAlerts(false);
      controller.setQuietNight(false);

      expect(controller.remindTasks, isFalse);
      expect(controller.leadTime, ReminderLeadTime.oneHour);
      expect(controller.eveningReminder, isFalse);
      expect(controller.overdueAlert, isFalse);
      expect(controller.tribeLifeAlerts, isFalse);
      expect(controller.quietNight, isFalse);
    });

    test('should persist the edits on save', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = NotificationsController(stack.notificationService);

      controller.setRemindTasks(false);
      expect(await controller.save(), isTrue);
      await pumpEventQueue();

      expect(stack.notificationService.prefs.remindTasks, isFalse);
    });

    test(
      'should trigger the permission prompt when enabling the master switch',
      () async {
        final stack = await TestStack.signedInWithTribe();
        final controller = NotificationsController(stack.notificationService);

        controller.setMasterEnabled(true);
        await pumpEventQueue();

        expect(
          stack.notificationService.permissionStatus,
          PushPermissionStatus.granted,
        );
        expect(stack.notificationService.registeredToken, 'device-token-1');
      },
    );

    test('should expose the system refusal', () async {
      final stack = await TestStack.signedInWithTribe();
      stack.pushRepository.promptAnswer = PushPermissionStatus.denied;
      final controller = NotificationsController(stack.notificationService);

      controller.setMasterEnabled(true);
      await pumpEventQueue();

      expect(controller.isSystemDenied, isTrue);
      expect(stack.notificationService.registeredToken, isNull);
    });
  });
}
