import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';

void main() {
  const chiefMembers = [
    Member(
      id: 'lea',
      name: 'Léa',
      color: AppColors.memberTerracotta,
      isChief: true,
      isCurrentUser: true,
    ),
    Member(id: 'tom', name: 'Tom', color: AppColors.memberPurple),
  ];

  const plainMembers = [
    Member(
      id: 'lea',
      name: 'Léa',
      color: AppColors.memberTerracotta,
      isChief: true,
    ),
    Member(
      id: 'tom',
      name: 'Tom',
      color: AppColors.memberPurple,
      isCurrentUser: true,
    ),
  ];

  group('ProfileController', () {
    test('should let the chief edit any color and remove others only', () {
      final controller = ProfileController(TribeService(members: chiefMembers));

      expect(controller.isChief, isTrue);
      expect(controller.canEditColor('tom'), isTrue);
      expect(controller.canRemove('tom'), isTrue);
      expect(controller.canRemove('lea'), isFalse);
    });

    test('should restrict a plain member to their own color, no removal', () {
      final controller = ProfileController(TribeService(members: plainMembers));

      expect(controller.isChief, isFalse);
      expect(controller.canEditColor('tom'), isTrue);
      expect(controller.canEditColor('lea'), isFalse);
      expect(controller.canRemove('lea'), isFalse);
    });

    test('should toggle the palette and close it after picking a color', () {
      final service = TribeService(members: chiefMembers);
      final controller = ProfileController(service);

      controller.toggleEditing('tom');
      expect(controller.editingMemberId, 'tom');

      controller.setMemberColor('tom', AppColors.memberGreen);
      expect(controller.editingMemberId, isNull);
      expect(service.memberById('tom').color, AppColors.memberGreen);
    });

    test('should remove a member through the service', () {
      final service = TribeService(members: chiefMembers);
      final controller = ProfileController(service);

      controller.removeMember('tom');

      expect(service.members.single.id, 'lea');
    });
  });
}
