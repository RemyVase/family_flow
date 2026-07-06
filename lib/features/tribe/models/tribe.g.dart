// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tribe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tribe _$TribeFromJson(Map<String, dynamic> json) => _Tribe(
  id: json['id'] as String,
  name: json['name'] as String,
  ownerId: json['ownerId'] as String,
  inviteCode: json['inviteCode'] as String,
  color: const ColorIntConverter().fromJson((json['color'] as num).toInt()),
);

Map<String, dynamic> _$TribeToJson(_Tribe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ownerId': instance.ownerId,
  'inviteCode': instance.inviteCode,
  'color': const ColorIntConverter().toJson(instance.color),
};
