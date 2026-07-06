import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:our_tribe/features/notifications/models/reminder_lead_time.dart';

part 'notification_prefs.freezed.dart';
part 'notification_prefs.g.dart';

/// The user's notification preferences, persisted at
/// `users/{uid}/settings/notifications`. Read by the (future) notification
/// sender to decide what to push, and by the settings screen.
@freezed
abstract class NotificationPrefs with _$NotificationPrefs {
  const factory NotificationPrefs({
    /// Master switch; nothing is pushed when false.
    @Default(true) bool masterEnabled,
    @Default(true) bool remindTasks,
    @Default(ReminderLeadTime.thirtyMinutes) ReminderLeadTime leadTime,
    @Default(true) bool morningSummary,
    @Default(true) bool eveningReminder,
    @Default(true) bool overdueAlert,
    @Default(true) bool tribeLifeAlerts,

    /// No pushes between 21:00 and 7:30.
    @Default(true) bool quietNight,
  }) = _NotificationPrefs;

  factory NotificationPrefs.fromJson(Map<String, dynamic> json) =>
      _$NotificationPrefsFromJson(json);
}
