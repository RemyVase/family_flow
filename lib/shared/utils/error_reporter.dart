import 'package:sentry_flutter/sentry_flutter.dart';

/// Reports a caught error to Sentry with its stack trace.
///
/// Single funnel used by controllers and stream `onError` handlers so no
/// error is silently swallowed (see `.claude/rules/error-handling.md`).
Future<void> reportError(Object error, StackTrace stackTrace) =>
    Sentry.captureException(error, stackTrace: stackTrace);
