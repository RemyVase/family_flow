import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Demo tribe used while the app is design-only (no backend wired yet).
abstract final class MockMembers {
  static const String tribeName = 'La tribu Dubois';
  static const String inviteCode = '4KP-92Q';
  static const String currentUserEmail = 'lea@ourtribe.be';

  static const List<Member> members = [
    Member(
      id: 'lea',
      name: 'Léa',
      color: AppColors.memberTerracotta,
      isChief: true,
      isCurrentUser: true,
      weeklyPoints: 26,
      weeklyTasksDone: 11,
    ),
    Member(
      id: 'maman',
      name: 'Maman',
      color: AppColors.memberGreen,
      weeklyPoints: 22,
      weeklyTasksDone: 9,
    ),
    Member(
      id: 'papa',
      name: 'Papa',
      color: AppColors.memberBlue,
      weeklyPoints: 18,
      weeklyTasksDone: 8,
    ),
    Member(
      id: 'tom',
      name: 'Tom',
      color: AppColors.memberPurple,
      weeklyPoints: 18,
      weeklyTasksDone: 8,
    ),
  ];
}
