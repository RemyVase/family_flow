import 'package:go_router/go_router.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/analytics_service.dart';

/// Logs a screen view every time the router's location changes.
///
/// Listening to the router delegate (rather than a [NavigatorObserver])
/// also captures tab switches inside the stateful shell, which never push
/// a route.
class AnalyticsScreenTracker {
  AnalyticsScreenTracker(this._router, this._analytics) {
    _router.routerDelegate.addListener(_onLocationChanged);
    _onLocationChanged();
  }

  final GoRouter _router;
  final AnalyticsService _analytics;

  String? _lastScreen;

  void _onLocationChanged() {
    final location = _router.routerDelegate.currentConfiguration.uri.path;
    final screen =
        AppRoute.values.where((r) => r.path == location).firstOrNull?.name ??
        location;
    if (screen == _lastScreen) return;
    _lastScreen = screen;
    _analytics.logScreenView(screen);
  }

  void dispose() {
    _router.routerDelegate.removeListener(_onLocationChanged);
  }
}
