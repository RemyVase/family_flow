// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  name: json['name'] as String,
  moment: $enumDecode(_$TaskMomentEnumMap, json['moment']),
  time: json['time'] as String,
  points: (json['points'] as num).toInt(),
  memberId: json['memberId'] as String?,
  recurrence:
      $enumDecodeNullable(_$TaskRecurrenceEnumMap, json['recurrence']) ??
      TaskRecurrence.once,
  isRotating: json['isRotating'] as bool? ?? false,
  isDone: json['isDone'] as bool? ?? false,
  hasPhoto: json['hasPhoto'] as bool? ?? false,
  description: json['description'] as String?,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'moment': _$TaskMomentEnumMap[instance.moment]!,
  'time': instance.time,
  'points': instance.points,
  'memberId': instance.memberId,
  'recurrence': _$TaskRecurrenceEnumMap[instance.recurrence]!,
  'isRotating': instance.isRotating,
  'isDone': instance.isDone,
  'hasPhoto': instance.hasPhoto,
  'description': instance.description,
};

const _$TaskMomentEnumMap = {
  TaskMoment.morning: 'morning',
  TaskMoment.afternoon: 'afternoon',
  TaskMoment.evening: 'evening',
};

const _$TaskRecurrenceEnumMap = {
  TaskRecurrence.once: 'once',
  TaskRecurrence.daily: 'daily',
  TaskRecurrence.twiceDaily: 'twiceDaily',
  TaskRecurrence.thriceDaily: 'thriceDaily',
  TaskRecurrence.weekly: 'weekly',
};
