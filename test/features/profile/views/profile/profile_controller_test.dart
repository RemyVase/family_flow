import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/theme/app_colors.dart';

import '../../../../helpers/test_stack.dart';

const _plainMembers = [
  Member(id: 'tom', name: 'Tom', color: AppColors.memberPurple, isChief: true),
  Member(id: 'lea', name: 'Léa', color: AppColors.memberTerracotta),
];

void main() {
  group('ProfileController', () {
    test(
      'should let the chief edit any color and remove others only',
      () async {
        final stack = await TestStack.signedInWithTribe();
        final controller = ProfileController(
          stack.tribeService,
          stack.authService,
        );

        expect(controller.isChief, isTrue);
        expect(controller.canEditColor('tom'), isTrue);
        expect(controller.canRemove('tom'), isTrue);
        expect(controller.canRemove('lea'), isFalse);
      },
    );

    test(
      'should restrict a plain member to their own color, no removal',
      () async {
        // Tom founded the tribe; the signed-in user is Tom… so sign in as
        // the plain member Léa instead.
        final stack = await TestStack.signedInWithTribe(members: _plainMembers);
        await stack.userRepository.saveUser(
          AppUser(
            id: 'lea',
            firstName: 'Léa',
            email: 'lea@t.be',
            tribeId: stack.tribeId,
          ),
        );
        stack.authRepository.setUser('lea');
        await pumpEventQueue();
        final controller = ProfileController(
          stack.tribeService,
          stack.authService,
        );

        expect(controller.isChief, isFalse);
        expect(controller.canEditColor('lea'), isTrue);
        expect(controller.canEditColor('tom'), isFalse);
        expect(controller.canRemove('tom'), isFalse);
      },
    );

    test('should toggle the palette and close it after picking', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = ProfileController(
        stack.tribeService,
        stack.authService,
      );

      controller.toggleEditing('tom');
      expect(controller.editingMemberId, 'tom');

      controller.setMemberColor('tom', AppColors.memberGreen);
      await pumpEventQueue();

      expect(controller.editingMemberId, isNull);
      expect(stack.tribeService.memberById('tom').color, AppColors.memberGreen);
    });

    test('should remove a member through the service', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = ProfileController(
        stack.tribeService,
        stack.authService,
      );

      controller.removeMember('tom');
      await pumpEventQueue();

      expect(stack.tribeService.members.single.id, 'lea');
    });

    test('should leave the tribe with a chief handover', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = ProfileController(
        stack.tribeService,
        stack.authService,
      );

      final left = await controller.leaveTribe(newChiefId: 'tom');
      await pumpEventQueue();

      expect(left, isTrue);
      expect(stack.authService.hasTribe, isFalse);
    });

    test('should sign out through the auth service', () async {
      final stack = await TestStack.signedInWithTribe();
      final controller = ProfileController(
        stack.tribeService,
        stack.authService,
      );

      controller.signOut();
      await pumpEventQueue();

      expect(stack.authService.isSignedIn, isFalse);
    });
  });
}
