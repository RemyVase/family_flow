# Error handling — Sentry

All errors are reported to **Sentry** with clean stack traces and breadcrumbs.
There is a single **global catcher** for the whole app.

## Global capture

Wrap app startup so every uncaught error (Flutter framework + Dart zone) is
reported automatically:

```dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = AppEnvironment.sentryDsn;   // per-flavor DSN
      options.environment = AppEnvironment.name; // 'dev' / 'prod'
      options.tracesSampleRate = 1.0;            // tune per env
      options.attachStacktrace = true;
    },
    appRunner: () => runApp(const MyApp()),
  );
}
```

- `FlutterError.onError` and the current-zone error handler are routed to Sentry
  by `SentryFlutter.init` — do not swallow errors elsewhere so they can reach it.
- Use a distinct DSN / environment per flavor (`dev` vs `prod`) so noise stays
  separated.

## Breadcrumbs & context

Keep the trail readable so an issue is diagnosable without a repro:

- Add breadcrumbs at meaningful steps (navigation, key user actions, repository
  calls) via `Sentry.addBreadcrumb(...)`.
- Attach context (user id, feature, current route) with `Sentry.configureScope`,
  but **never log PII or secrets**.
- Prefer specific breadcrumb categories/messages over generic ones — a
  breadcrumb should say what happened, not just "error".

## In the layers

- **Repositories** let Firebase exceptions propagate (they contain no logic);
  they may wrap them in a typed domain exception, but must not silently catch.
- **Controllers** catch errors coming from services/repositories, expose an
  error state to the view, and report to Sentry with
  `Sentry.captureException(e, stackTrace: st)` — always pass the stack trace.
- **Never** use empty `catch {}` blocks or bare `print` for errors.

> Prerequisite: add `sentry_flutter` to `pubspec.yaml` dependencies and set the
> DSN in `lib/config/app_environment.dart` per flavor.
