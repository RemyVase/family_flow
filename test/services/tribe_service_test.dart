import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';

import '../helpers/test_stack.dart';

void main() {
  group('TribeService', () {
    test('should stream the tribe and its members once signed in', () async {
      final stack = await TestStack.signedInWithTribe();
      final service = stack.tribeService;

      expect(service.isReady, isTrue);
      expect(service.tribeName, 'La tribu test');
      expect(service.inviteCode, testInviteCode);
      expect(service.members.length, 2);
      expect(service.currentMember.id, 'lea');
      expect(service.currentMember.isChief, isTrue);
    });

    test('should rank members by weekly points and sum the total', () async {
      final stack = await TestStack.signedInWithTribe();

      expect(stack.tribeService.ranking.first.id, 'tom');
      expect(stack.tribeService.weeklyTotalPoints, 56);
    });

    test('should change a member color and persist it', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.tribeService.setMemberColor('tom', AppColors.memberGreen);
      await pumpEventQueue();

      expect(stack.tribeService.memberById('tom').color, AppColors.memberGreen);
    });

    test('should remove a member but never the current user', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.tribeService.removeMember('tom');
      await stack.tribeService.removeMember('lea');
      await pumpEventQueue();

      expect(stack.tribeService.members.single.id, 'lea');
    });

    test('should rename the current member and ignore blank names', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.tribeService.renameCurrentMember('  ');
      await pumpEventQueue();
      expect(stack.tribeService.currentMember.name, 'Léa');

      await stack.tribeService.renameCurrentMember('Léo');
      await pumpEventQueue();
      expect(stack.tribeService.currentMember.name, 'Léo');
    });

    test('should create a tribe with the signed-in user as chief', () async {
      final stack = TestStack(userId: 'new-user');
      await stack.userRepository.saveUser(
        const AppUser(id: 'new-user', firstName: 'Zoé', email: 'z@t.be'),
      );
      await pumpEventQueue();

      await stack.tribeService.createTribe(
        name: 'Les Dubois',
        color: AppColors.memberBlue,
        memberName: 'Zoé',
      );
      await pumpEventQueue();

      final service = stack.tribeService;
      expect(service.isReady, isTrue);
      expect(service.tribeName, 'Les Dubois');
      expect(service.inviteCode.length, TribeService.inviteCodeLength);
      expect(service.currentMember.name, 'Zoé');
      expect(service.currentMember.isChief, isTrue);
    });

    test('should join a tribe found by its invite code', () async {
      // An existing tribe created by someone else…
      final host = await TestStack.signedInWithTribe();

      // …and a fresh user on the same backend joining with the code.
      final stack = TestStack(userId: 'new-user', firestore: host.firestore);
      await stack.userRepository.saveUser(
        const AppUser(id: 'new-user', firstName: 'Zoé', email: 'z@t.be'),
      );
      await pumpEventQueue();

      final invite = await stack.tribeService.findInvite(testInviteCode);
      expect(invite, isNotNull);
      expect(invite!.tribeName, 'La tribu test');

      await stack.tribeService.joinTribe(invite: invite, memberName: 'Zoé');
      await pumpEventQueue();

      expect(stack.tribeService.currentMember.name, 'Zoé');
      expect(stack.tribeService.members.length, 3);
    });

    test('should hand over the chief role when the chief leaves', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.tribeService.leaveTribe(newChiefId: 'tom');
      await pumpEventQueue();

      // The user left: no tribe on their profile anymore.
      expect(stack.authService.hasTribe, isFalse);
      // Tom is now the chief of the remaining tribe.
      final tomDoc = await stack.firestore
          .collection('tribes')
          .doc(stack.tribeId)
          .collection('members')
          .doc('tom')
          .get();
      expect(tomDoc.data()!['isChief'], isTrue);
    });

    test('should delete the tribe when the last member leaves', () async {
      final stack = await TestStack.signedInWithTribe(
        members: [testMembers.first],
      );

      await stack.tribeService.leaveTribe();
      await pumpEventQueue();

      final tribeDoc = await stack.firestore
          .collection('tribes')
          .doc(stack.tribeId)
          .get();
      final inviteDoc = await stack.firestore
          .collection('invites')
          .doc(testInviteCode)
          .get();
      expect(tribeDoc.exists, isFalse);
      expect(inviteDoc.exists, isFalse);
    });
  });
}
