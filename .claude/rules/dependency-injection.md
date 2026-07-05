# Dependency injection — swappable backend

Goal: **be able to change backend (Firestore → anything) by editing one line.**
We get this by depending on **abstractions**, never on concrete
implementations, and wiring everything through Provider.

## The pattern: repositories are interfaces

Every repository is an **abstract class** (the contract). The Firestore code is
just one implementation of it.

```dart
// features/user/repositories/user_repository.dart  — the interface
abstract class UserRepository {
  Future<User?> fetchUser(String id);
  Stream<List<User>> watchUsers();
  Future<void> saveUser(User user);
}
```

```dart
// features/user/repositories/firestore_user_repository.dart — one implementation
class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<User?> fetchUser(String id) async { /* Firestore calls only */ }
  // ...
}
```

Services and controllers depend on `UserRepository` (the interface) — they never
know `FirestoreUserRepository` exists.

## Wiring (the single point of change)

Providers are declared at the root of the app, in dependency order:
**repositories → services → (controllers are created per view)**. This is the
**only** place a concrete implementation is named.

```dart
// app.dart (or a dedicated lib/providers.dart)
MultiProvider(
  providers: [
    // Repositories — bound to their interface type.
    Provider<UserRepository>(
      create: (_) => FirestoreUserRepository(FirebaseFirestore.instance),
    ),
    // Services — read the interfaces they need.
    Provider<ProfileService>(
      create: (c) => ProfileService(c.read<UserRepository>()),
    ),
  ],
  child: const MyApp(),
);
```

Swapping backend = change **`FirestoreUserRepository` → `RestUserRepository`**
on that one line. Nothing else in the app changes.

## Rules

- Depend on the **interface type** everywhere (`context.read<UserRepository>()`),
  never on the concrete class.
- **Never** instantiate a repository or service by hand inside a controller,
  service or widget (`FirestoreUserRepository()` in a controller is forbidden) —
  always inject it.
- Controllers are provided per view with `ChangeNotifierProvider` and receive
  their dependencies via `context.read<T>()`
  (see @.claude/rules/state-management.md).
- Services depend on repository interfaces, and on other services if needed —
  never the reverse (no repository depends on a service).
- Keep the provider tree ordered: a provider may only `read` providers declared
  above it.
