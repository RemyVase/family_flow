import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:our_tribe/features/analytics/models/analytics_event.dart';
import 'package:our_tribe/features/analytics/repositories/analytics_repository.dart';

/// Firebase Analytics (GA4) implementation of [AnalyticsRepository].
class FirebaseAnalyticsRepository implements AnalyticsRepository {
  FirebaseAnalyticsRepository(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logEvent(
    AnalyticsEvent event, [
    Map<String, Object>? parameters,
  ]) => _analytics.logEvent(name: event.wireName, parameters: parameters);

  @override
  Future<void> logScreenView(String screenName) =>
      _analytics.logScreenView(screenName: screenName);

  @override
  Future<void> setUserId(String? userId) => _analytics.setUserId(id: userId);

  @override
  Future<void> setUserProperty(String name, String? value) =>
      _analytics.setUserProperty(name: name, value: value);
}
