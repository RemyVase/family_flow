import 'package:our_tribe/features/analytics/models/analytics_event.dart';

/// Contract for the analytics backend.
///
/// The app only ever talks to this interface (see
/// `.claude/rules/dependency-injection.md`); swapping Firebase Analytics
/// for another product (PostHog, …) means writing one implementation and
/// changing one line in `app.dart`.
abstract class AnalyticsRepository {
  /// Records an event with optional parameters (strings or numbers).
  Future<void> logEvent(
    AnalyticsEvent event, [
    Map<String, Object>? parameters,
  ]);

  /// Records that a screen became visible.
  Future<void> logScreenView(String screenName);

  /// Attaches (or detaches, with null) all future events to a user.
  Future<void> setUserId(String? userId);

  /// Sets a persistent property segmenting this user (null clears it).
  Future<void> setUserProperty(String name, String? value);
}
