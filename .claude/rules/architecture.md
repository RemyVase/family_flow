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
│       ├── controllers/    # one controller per view (see state-management.md)
│       └── views/
│           ├── <feature>_view.dart   # the view (no logic)
│           └── widgets/              # sub-widgets split out from the view
└── shared/                 # widgets / utils reused across features
```

## Layers and their responsibilities

Dependencies always flow in a single direction:

```
View → Controller → Service → Repository → Firebase
                 ↘ Repository (when only one feature is involved)
```

### View

- **No display logic** in the view. None.
- The view listens to its controller (`context.watch`) and only renders.
- Every view is **split into widgets**, even widgets not reused elsewhere. We
  want small, well-separated, clean files under `views/widgets/`.

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
