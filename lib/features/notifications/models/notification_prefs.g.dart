// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_prefs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationPrefs _$NotificationPrefsFromJson(Map<String, dynamic> json) =>
    _NotificationPrefs(
      masterEnabled: json['masterEnabled'] as bool? ?? true,
      remindTasks: json['remindTasks'] as bool? ?? true,
      leadTime:
          $enumDecodeNullable(_$ReminderLeadTimeEnumMap, json['leadTime']) ??
          ReminderLeadTime.thirtyMinutes,
      morningSummary: json['morningSummary'] as bool? ?? true,
      eveningReminder: json['eveningReminder'] as bool? ?? true,
      overdueAlert: json['overdueAlert'] as bool? ?? true,
      tribeLifeAlerts: json['tribeLifeAlerts'] as bool? ?? true,
      quietNight: json['quietNight'] as bool? ?? true,
    );

Map<String, dynamic> _$NotificationPrefsToJson(_NotificationPrefs instance) =>
    <String, dynamic>{
      'masterEnabled': instance.masterEnabled,
      'remindTasks': instance.remindTasks,
      'leadTime': _$ReminderLeadTimeEnumMap[instance.leadTime]!,
      'morningSummary': instance.morningSummary,
      'eveningReminder': instance.eveningReminder,
      'overdueAlert': instance.overdueAlert,
      'tribeLifeAlerts': instance.tribeLifeAlerts,
      'quietNight': instance.quietNight,
    };

const _$ReminderLeadTimeEnumMap = {
  ReminderLeadTime.onTime: 'onTime',
  ReminderLeadTime.fifteenMinutes: 'fifteenMinutes',
  ReminderLeadTime.thirtyMinutes: 'thirtyMinutes',
  ReminderLeadTime.oneHour: 'oneHour',
};
