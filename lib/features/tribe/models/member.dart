import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:our_tribe/shared/utils/color_int_converter.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
abstract class Member with _$Member {
  const Member._();

  const factory Member({
    required String id,
    required String name,
    @ColorIntConverter() required Color color,
    @Default(false) bool isChief,

    /// Whether this member is the signed-in user. Derived from the auth uid
    /// when mapping snapshots — never stored in Firestore.
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isCurrentUser,
    @Default(0) int weeklyPoints,
    @Default(0) int weeklyTasksDone,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  /// First letter shown in avatars.
  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}
