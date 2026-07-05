import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';

@freezed
abstract class Member with _$Member {
  const Member._();

  const factory Member({
    required String id,
    required String name,
    required Color color,
    @Default(false) bool isChief,
    @Default(false) bool isCurrentUser,
    @Default(0) int weeklyPoints,
    @Default(0) int weeklyTasksDone,
  }) = _Member;

  /// First letter shown in avatars.
  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}
