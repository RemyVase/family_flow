import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/tribe.dart';
import 'package:our_tribe/features/tribe/models/tribe_invite.dart';
import 'package:our_tribe/features/tribe/repositories/firestore_tribe_repository.dart';
import 'package:our_tribe/theme/app_colors.dart';

const _founder = Member(
  id: 'lea',
  name: 'Léa',
  color: AppColors.memberTerracotta,
  isChief: true,
);

const _tribe = Tribe(
  id: '',
  name: 'La tribu test',
  ownerId: 'lea',
  inviteCode: 'ABC234',
  color: AppColors.memberGreen,
);

void main() {
  group('FirestoreTribeRepository', () {
    test(
      'should create the tribe, its invite and the founder atomically',
      () async {
        final firestore = FakeFirebaseFirestore();
        final repository = FirestoreTribeRepository(firestore);

        final tribeId = await repository.createTribe(
          tribe: _tribe,
          founder: _founder,
        );

        final tribe = await repository.watchTribe(tribeId).first;
        expect(tribe!.name, 'La tribu test');
        expect(tribe.id, tribeId);
        expect(tribe.color, AppColors.memberGreen);

        final invite = await repository.fetchInvite('ABC234');
        expect(
          invite,
          const TribeInvite(
            id: 'ABC234',
            tribeId: '',
            tribeName: 'La tribu test',
          ).copyWith(tribeId: tribeId),
        );

        final members = await repository.watchMembers(tribeId).first;
        expect(members.single.id, 'lea');
        expect(members.single.isChief, isTrue);
      },
    );

    test('should write the join proof alongside the member document', () async {
      final firestore = FakeFirebaseFirestore();
      final repository = FirestoreTribeRepository(firestore);
      final tribeId = await repository.createTribe(
        tribe: _tribe,
        founder: _founder,
      );
      final invite = (await repository.fetchInvite('ABC234'))!;

      await repository.joinTribe(
        invite: invite,
        member: const Member(
          id: 'tom',
          name: 'Tom',
          color: AppColors.memberPurple,
        ),
      );

      final raw = await firestore
          .collection('tribes')
          .doc(tribeId)
          .collection('members')
          .doc('tom')
          .get();
      expect(raw.data()!['joinCode'], 'ABC234');

      // The extra proof field must not leak into the typed model.
      final members = await repository.watchMembers(tribeId).first;
      expect(members.length, 2);
    });

    test('should return null for an unknown invite code', () async {
      final repository = FirestoreTribeRepository(FakeFirebaseFirestore());

      expect(await repository.fetchInvite('NOPE99'), isNull);
    });

    test('should delete the tribe, invite and membership together', () async {
      final firestore = FakeFirebaseFirestore();
      final repository = FirestoreTribeRepository(firestore);
      final tribeId = await repository.createTribe(
        tribe: _tribe,
        founder: _founder,
      );
      final tribe = (await repository.watchTribe(tribeId).first)!;

      await repository.deleteTribe(tribe: tribe, memberId: 'lea');

      expect(await repository.watchTribe(tribeId).first, isNull);
      expect(await repository.fetchInvite('ABC234'), isNull);
      expect(await repository.watchMembers(tribeId).first, isEmpty);
    });
  });
}
