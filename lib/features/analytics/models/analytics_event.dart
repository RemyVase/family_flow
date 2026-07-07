/// Every analytics event the app can emit, with its wire name.
///
/// Names follow the GA4 conventions (snake_case, ≤ 40 chars) so they stay
/// portable to another backend (PostHog, …). No event name is ever written
/// as a raw string outside this file.
enum AnalyticsEvent {
  signUp('sign_up'),
  login('login'),
  logout('logout'),

  tribeCreated('tribe_created'),
  tribeJoined('tribe_joined'),
  tribeLeft('tribe_left'),

  memberRemoved('member_removed'),
  memberRenamed('member_renamed'),
  memberColorChanged('member_color_changed'),

  taskCreated('task_created'),
  taskCompleted('task_completed'),
  taskUnchecked('task_unchecked'),
  taskAssigned('task_assigned'),

  notificationPermission('notification_permission'),
  notificationPrefsSaved('notification_prefs_saved');

  const AnalyticsEvent(this.wireName);

  /// The name sent to the analytics backend.
  final String wireName;
}
