// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Member _$MemberFromJson(Map<String, dynamic> json) => _Member(
  id: json['id'] as String,
  name: json['name'] as String,
  color: const ColorIntConverter().fromJson((json['color'] as num).toInt()),
  isChief: json['isChief'] as bool? ?? false,
  weeklyPoints: (json['weeklyPoints'] as num?)?.toInt() ?? 0,
  weeklyTasksDone: (json['weeklyTasksDone'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MemberToJson(_Member instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': const ColorIntConverter().toJson(instance.color),
  'isChief': instance.isChief,
  'weeklyPoints': instance.weeklyPoints,
  'weeklyTasksDone': instance.weeklyTasksDone,
};
