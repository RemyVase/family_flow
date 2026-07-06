import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/notifications/models/notification_prefs.dart';
import 'package:our_tribe/features/notifications/models/reminder_lead_time.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';

import '../helpers/test_stack.dart';

void main() {
  Future<List<String>> storedTokens(TestStack stack) async {
    final doc = await stack.firestore.collection('users').doc('lea').get();
    return List<String>.from(
      (doc.data()!['fcmTokens'] ?? const <String>[]) as List,
    );
  }

  group('NotificationService', () {
    test(
      'should register the device token when permission is granted',
      () async {
        final stack = TestStack(userId: 'lea');
        stack.pushRepository.status = PushPermissionStatus.granted;
        await stack.userRepository.saveUser(
          const AppUser(id: 'lea', firstName: 'Léa', email: 'lea@ourtribe.be'),
        );
        await pumpEventQueue();

        expect(
          stack.notificationService.permissionStatus,
          PushPermissionStatus.granted,
        );
        expect(stack.notificationService.registeredToken, 'device-token-1');
        expect(await storedTokens(stack), ['device-token-1']);
      },
    );

    test(
      'should not touch the token while permission was never asked',
      () async {
        final stack = await TestStack.signedInWithTribe();

        expect(stack.notificationService.registeredToken, isNull);
        final doc = await stack.firestore.collection('users').doc('lea').get();
        expect(doc.data()!.containsKey('fcmTokens'), isFalse);
      },
    );

    test('should register the token after the permission prompt', () async {
      final stack = await TestStack.signedInWithTribe();

      final granted = await stack.notificationService.requestPermission();
      await pumpEventQueue();

      expect(granted, isTrue);
      expect(await storedTokens(stack), ['device-token-1']);
    });

    test('should report a refused prompt and register nothing', () async {
      final stack = await TestStack.signedInWithTribe();
      stack.pushRepository.promptAnswer = PushPermissionStatus.denied;

      final granted = await stack.notificationService.requestPermission();

      expect(granted, isFalse);
      expect(stack.notificationService.isSystemDenied, isTrue);
      expect(stack.notificationService.registeredToken, isNull);
    });

    test('should swap the stored token when the platform rotates it', () async {
      final stack = await TestStack.signedInWithTribe();
      await stack.notificationService.requestPermission();
      await pumpEventQueue();

      stack.pushRepository.rotateToken('device-token-2');
      await pumpEventQueue();

      expect(await storedTokens(stack), ['device-token-2']);
    });

    test('should persist and stream the notification prefs', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.notificationService.savePrefs(
        const NotificationPrefs(
          remindTasks: false,
          leadTime: ReminderLeadTime.oneHour,
        ),
      );
      await pumpEventQueue();

      expect(stack.notificationService.prefs.remindTasks, isFalse);
      expect(
        stack.notificationService.prefs.leadTime,
        ReminderLeadTime.oneHour,
      );
      final doc = await stack.firestore
          .collection('users')
          .doc('lea')
          .collection('settings')
          .doc('notifications')
          .get();
      expect(doc.data()!['remindTasks'], isFalse);
      expect(doc.data()!['leadTime'], 'oneHour');
    });

    test('should detach the device token on unregister', () async {
      final stack = await TestStack.signedInWithTribe();
      await stack.notificationService.requestPermission();
      await pumpEventQueue();

      await stack.notificationService.unregisterToken();

      expect(stack.notificationService.registeredToken, isNull);
      expect(await storedTokens(stack), isEmpty);
    });
  });
}
