import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/tribe.dart';
import 'package:our_tribe/features/tribe/models/tribe_invite.dart';

/// Contract for the tribe store (`tribes/{tribeId}` and its members).
abstract class TribeRepository {
  Stream<Tribe?> watchTribe(String tribeId);

  Stream<List<Member>> watchMembers(String tribeId);

  /// Creates the tribe, its invite lookup document and the founder's
  /// membership atomically. Returns the new tribe id ([tribe.id] is ignored).
  Future<String> createTribe({required Tribe tribe, required Member founder});

  /// Resolves an invite code; null when the code does not exist.
  Future<TribeInvite?> fetchInvite(String code);

  /// Adds [member] to the tribe behind [invite]. The invite code is written
  /// alongside the membership as the proof checked by the security rules.
  Future<void> joinTribe({required TribeInvite invite, required Member member});

  /// Creates or fully overwrites a membership document.
  Future<void> saveMember(String tribeId, Member member);

  Future<void> removeMember(String tribeId, String memberId);

  /// Refreshes the denormalized member count on the invite document.
  Future<void> updateInviteMemberCount(String code, int memberCount);

  /// Deletes the tribe, its invite and the last membership atomically
  /// (used when the last member leaves).
  Future<void> deleteTribe({required Tribe tribe, required String memberId});
}
