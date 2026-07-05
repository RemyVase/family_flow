# Architecture — feature-first

We follow a simple, strict **feature-first** architecture. Every feature of the
app lives in its own folder under `lib/features/`.

## Folder structure

```
lib/
├── main.dart, main_dev.dart, main_prod.dart, bootstrap.dart, app.dart
├── config/                 # environment, flavors
├── firebase/               # Firebase bootstrap, services access
├── routing/                # GoRouter configuration (see routing.md)
├── services/               # cross-feature services
├── features/
│   └── <feature>/
│       ├── models/         # feature's Freezed models
│       ├── repositories/   # Firestore / Storage / Auth calls ONLY
│       ├── widgets/        # widgets shared by several views of the feature
│       └── views/
│           └── <view>/     # ONE FOLDER PER VIEW
│               ├── <view>_view.dart        # the view (no logic)
│               ├── <view>_controller.dart  # its controller (if the view has state)
│               └── widgets/                # sub-widgets of THIS view only
└── shared/                 # widgets / utils reused across features
```

**One folder per view.** Everything a view needs lives together under
`views/<view>/`: the view file, its controller, and a `widgets/` folder with
its sub-widgets. A widget used by several views of the same feature moves up
to the feature's `widgets/`; a widget used across features moves to
`lib/shared/widgets/`.

## Layers and their responsibilities

Dependencies always flow in a single direction:

```
View → Controller → Service → Repository → Firebase
                 ↘ Repository (when only one feature is involved)
```

### View

- **No display logic** in the view. None.
- The view listens to its controller (`context.watch`) and only renders.
- Every view is **split into widgets**, even widgets not reused elsewhere.

#### Views are a sequence of widgets (enforced)

**Split into a maximum of widgets, but don't inflate the file count.** The
two rules work together:

1. **The view is only a sequence of widgets.** The `<view>_view.dart` build
   methods never inline a visual section: no `Container`+decoration blocks,
   no `Row`/`Column` describing a card's innards, directly in the view or
   its `_Body`. Every named section of the screen (header, card, list, row,
   button block…) is a widget class.
2. **Where that widget class lives depends on its weight:**
   - **Small and dumb** (pure layout, a handful of lines, no logic, no
     controller access) → a **private class** (`_Foo`) at the bottom of the
     view file. Don't create a file for it.
   - **Big or complex** (long build, internal state, reads a controller /
     service, conditional rendering, animations) → its **own file** in the
     view's `widgets/` folder.

Rules of thumb:

- If the widget talks to a controller (`context.watch` / `context.read`),
  it goes to its own file.
- If the widget's build is longer than ~40 lines or has private sub-widgets
  of its own, it goes to its own file.
- Otherwise, keep it private in the view file — fewer files beats ceremony.
- Same logic applies inside `widgets/` files: a big sub-part gets its own
  file, a tiny private helper stays where it is used.

### Controller

- **One controller per view.** It holds all of the view's state.
- The view listens to its changes; the controller never references the view.
- A controller may call **services** or, when only one feature is involved, a
  **repository** directly.
- Details: @.claude/rules/state-management.md

### Service

- Used when we need to orchestrate / combine repositories from **multiple
  different features**.
- Holds cross-cutting business logic.
- Lives in `lib/services/`.

### Repository

- Contains **ONLY** Firestore / Cloud Storage / Auth calls.
- **No other logic** (no business logic, no complex transformation, no
  orchestration).
- One repository per data domain, inside the relevant feature.

## General rules

- Small files, one responsibility per file.
- Never mix layers (a view never talks to a repository, a repository knows
  nothing about controllers, etc.).
- Code shared across features goes into `lib/shared/` or `lib/services/`, never
  duplicated.
