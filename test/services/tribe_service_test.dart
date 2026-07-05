import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';

void main() {
  const members = [
    Member(
      id: 'lea',
      name: 'Léa',
      color: AppColors.memberTerracotta,
      isChief: true,
      isCurrentUser: true,
      weeklyPoints: 26,
    ),
    Member(
      id: 'tom',
      name: 'Tom',
      color: AppColors.memberPurple,
      weeklyPoints: 30,
    ),
  ];

  group('TribeService', () {
    test('should rank members by weekly points and sum the total', () {
      final service = TribeService(members: members);

      expect(service.ranking.first.id, 'tom');
      expect(service.weeklyTotalPoints, 56);
    });

    test('should change a member color and notify listeners', () {
      final service = TribeService(members: members);
      var notified = false;
      service.addListener(() => notified = true);

      service.setMemberColor('tom', AppColors.memberGreen);

      expect(service.memberById('tom').color, AppColors.memberGreen);
      expect(notified, isTrue);
    });

    test('should remove a member but never the current user', () {
      final service = TribeService(members: members);

      service.removeMember('tom');
      service.removeMember('lea');

      expect(service.members.single.id, 'lea');
    });

    test('should rename the current member and ignore blank names', () {
      final service = TribeService(members: members);

      service.renameCurrentMember('  ');
      expect(service.currentMember.name, 'Léa');

      service.renameCurrentMember('Léo');
      expect(service.currentMember.name, 'Léo');
    });
  });
}
