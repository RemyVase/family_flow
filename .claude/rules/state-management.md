# State management — Provider & controllers

We use **Provider** with `ChangeNotifier`. Core rule: **a view contains no
logic — every view has its own controller.**

## The controller

- A `ChangeNotifier`, one per view, in `lib/features/<feature>/controllers/`.
- It holds **all of the view's state** (data, loading state, errors…).
- It exposes that state through getters and calls `notifyListeners()` when it
  changes.
- It calls **services** (cross-cutting / multi-feature logic) or, when only one
  feature is involved, a **repository** directly.
- It never references a widget or a `BuildContext` for rendering.

```dart
class HomeController extends ChangeNotifier {
  HomeController(this._service);

  final HomeService _service;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Item> _items = [];
  List<Item> get items => _items;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _items = await _service.fetchItems();
    _isLoading = false;
    notifyListeners();
  }
}
```

## The view

- No display logic: it reads the controller's state and renders.
- Provide the controller with `ChangeNotifierProvider`, then listen with
  `context.watch<T>()`. To trigger an action without re-listening, use
  `context.read<T>()`.
- The view is **split into sub-widgets** (`views/widgets/` folder), even for
  widgets not reused elsewhere.

```dart
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(context.read<HomeService>())..load(),
      child: const _HomeScaffold(),
    );
  }
}
```

```dart
// views/widgets/home_scaffold.dart
class _HomeScaffold extends StatelessWidget {
  const _HomeScaffold();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    if (controller.isLoading) return const _HomeLoader();
    return _HomeList(items: controller.items);
  }
}
```

## Do / don't

- ✅ State in the controller, rendering in the view.
- ✅ Small, well-separated widgets.
- ❌ No logic (computations, calls, business conditions) inside a `build()`.
- ❌ No repository/service call directly from a widget.

> Prerequisite: add `provider` to `pubspec.yaml` dependencies.
