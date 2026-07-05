# Routing — GoRouter

All navigation goes through **GoRouter**. No direct imperative navigation
(`Navigator.push(...)`) except in a well-justified, very local case.

## Organization

- The router configuration lives in `lib/routing/`.
- A central `GoRouter` (e.g. `app_router.dart`) declares all routes.
- Paths / route names are centralized (constants or enum) — no magic strings
  scattered around.

```dart
// lib/routing/app_router.dart
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeView(),
    ),
    // ...
  ],
);
```

## Rules

- Each screen = one `GoRoute` pointing to the feature's **View**.
- Navigate via `context.go(...)` / `context.push(...)` or by name
  (`context.goNamed(...)`).
- Parameters go through the path or `state.extra`, never through global
  variables.
- Redirection logic (auth guard, etc.) goes in the `GoRouter` `redirect`,
  relying on the auth state exposed by the appropriate layer.

> Prerequisite: add `go_router` to `pubspec.yaml` dependencies.
