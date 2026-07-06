import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/join_tribe_controller.dart';

import '../../../../helpers/test_stack.dart';

void main() {
  /// A joining user on the same backend as an existing tribe.
  Future<(JoinTribeController, TestStack)> buildController() async {
    final host = await TestStack.signedInWithTribe();
    final stack = TestStack(userId: 'new-user', firestore: host.firestore);
    await stack.userRepository.saveUser(
      const AppUser(id: 'new-user', firstName: 'Zoé', email: 'z@t.be'),
    );
    await pumpEventQueue();
    return (JoinTribeController(stack.tribeService, stack.authService), stack);
  }

  void enterCode(JoinTribeController controller, String code) {
    for (var i = 0; i < code.length; i++) {
      controller.setCharacter(i, code[i]);
    }
  }

  group('JoinTribeController', () {
    test(
      'should report completion only when all six characters are set',
      () async {
        final (controller, _) = await buildController();

        expect(controller.isComplete, isFalse);

        enterCode(controller, testInviteCode);

        expect(controller.isComplete, isTrue);
      },
    );

    test('should uppercase and keep only the last typed character', () async {
      final (controller, _) = await buildController();

      controller.setCharacter(0, 'kp');

      expect(controller.code[0], 'P');
    });

    test('should ignore out-of-range indexes', () async {
      final (controller, _) = await buildController();

      controller.setCharacter(-1, 'a');
      controller.setCharacter(6, 'a');

      expect(controller.filledCount, 0);
    });

    test('should find the tribe behind a valid code', () async {
      final (controller, _) = await buildController();

      enterCode(controller, testInviteCode);
      await pumpEventQueue();

      expect(controller.status, JoinLookupStatus.found);
      expect(controller.invite!.tribeName, 'La tribu test');
    });

    test('should report an unknown code as not found', () async {
      final (controller, _) = await buildController();

      enterCode(controller, 'ZZZZZZ');
      await pumpEventQueue();

      expect(controller.status, JoinLookupStatus.notFound);
      expect(controller.canJoin, isFalse);
    });

    test('should join the found tribe as a regular member', () async {
      final (controller, stack) = await buildController();

      enterCode(controller, testInviteCode);
      await pumpEventQueue();
      final joined = await controller.join();
      await pumpEventQueue();

      expect(joined, isTrue);
      expect(stack.authService.hasTribe, isTrue);
      expect(stack.tribeService.members.length, 3);
      expect(stack.tribeService.currentMember.isChief, isFalse);
    });
  });
}
