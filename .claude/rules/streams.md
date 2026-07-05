# Streams & lifecycle

Firestore is push-based, so streams are everywhere. Mishandled subscriptions
are the #1 source of leaks and "setState after dispose" crashes.

## Rules

- **Prefer streams over polling.** Expose Firestore data as `Stream<T>` from the
  repository (`snapshots()`), not repeated one-shot `get()` calls.
- Repositories return **typed streams** (`Stream<List<User>>`), never raw
  `QuerySnapshot` (see @.claude/rules/data-mapping.md).
- A controller that subscribes **must cancel** in `dispose()`:

```dart
class HomeController extends ChangeNotifier {
  HomeController(this._repo);
  final UserRepository _repo;
  StreamSubscription<List<User>>? _sub;

  List<User> _users = [];
  List<User> get users => _users;

  void start() {
    _sub = _repo.watchUsers().listen((users) {
      _users = users;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
```

- Never call `notifyListeners()` after `dispose()`. Cancelling the subscription
  in `dispose()` prevents this.
- When a controller is provided per view via `ChangeNotifierProvider`, Provider
  disposes it automatically — rely on that, and put all teardown in `dispose()`.
- Don't subscribe to the same stream in the widget tree (`StreamBuilder`) *and*
  the controller. The controller owns the subscription; the view only reads
  controller state.
- For one-shot reads (a single document that won't change on screen), a
  `Future`/`get()` is fine — don't force a stream where there's nothing to watch.
