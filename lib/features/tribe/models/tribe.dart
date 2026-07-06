import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:our_tribe/shared/utils/color_int_converter.dart';

part 'tribe.freezed.dart';
part 'tribe.g.dart';

@freezed
abstract class Tribe with _$Tribe {
  const factory Tribe({
    required String id,
    required String name,
    required String ownerId,
    required String inviteCode,
    @ColorIntConverter() required Color color,
  }) = _Tribe;

  factory Tribe.fromJson(Map<String, dynamic> json) => _$TribeFromJson(json);
}
