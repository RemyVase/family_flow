import 'package:freezed_annotation/freezed_annotation.dart';

part 'tribe_invite.freezed.dart';
part 'tribe_invite.g.dart';

/// Public lookup document for an invite code (`invites/{code}`).
///
/// Lets a signed-in user resolve a code to a tribe before being a member of
/// it (tribe documents themselves are member-only). [id] is the code itself.
@freezed
abstract class TribeInvite with _$TribeInvite {
  const factory TribeInvite({
    required String id,
    required String tribeId,
    required String tribeName,

    /// Denormalized member count, shown on the join screen and used to pick
    /// the next member color. Refreshed best-effort on join/leave.
    @Default(1) int memberCount,
  }) = _TribeInvite;

  factory TribeInvite.fromJson(Map<String, dynamic> json) =>
      _$TribeInviteFromJson(json);
}
