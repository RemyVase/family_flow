# Testing

Target: **every feature ships with its own test suite.** A feature is not "done"
until its controllers are tested. Build the suite alongside the feature, not
after.

## Structure

- Tests live in `test/`, **mirroring `lib/`**:
  `lib/features/home/views/home/home_controller.dart` →
  `test/features/home/views/home/home_controller_test.dart`.

## What to test, by layer

- **Controllers — the priority.** Unit-test state transitions: loading →
  loaded, error handling, the state exposed to the view. Mock the services /
  repositories they depend on.
- **Services.** Unit-test orchestration logic with mocked repositories.
- **Repositories.** Test mapping against the fake Firebase SDKs
  (`fake_cloud_firestore`, `firebase_auth_mocks`); do not hit real Firebase.
- **Widgets.** Widget-test the important views (loading/error/empty/content
  states). Not every tiny sub-widget needs one.

## How

- Because repositories are interfaces (see
  @.claude/rules/dependency-injection.md), controllers/services are tested with
  simple fakes or `mocktail` mocks of those interfaces — no Firebase needed.
- Keep tests fast and deterministic: no network, no real timers, no
  `Date.now()`-style nondeterminism.
- One behavior per test, named as `should <expected> when <condition>`.

## Realistic baseline (from day one)

Don't block on 100% coverage. Minimum bar per feature:

1. Controller happy path + error path.
2. Any non-trivial service logic.
3. Repository mapping if it does anything beyond a straight `withConverter`.

Grow widget/integration tests as the feature stabilizes.

> Prerequisites: `mocktail`, `fake_cloud_firestore`, `firebase_auth_mocks` in
> `dev_dependencies`.
