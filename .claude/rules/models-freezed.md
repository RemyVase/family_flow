# Models — Freezed

All data models are generated with the **Freezed** package.

## Absolute rule

- Write **only** the model definition (the annotated class).
- **NEVER** create the generated files by hand (`*.freezed.dart`, `*.g.dart`).
- **Always** run the generation command after writing or changing a model:

```bash
dart run build_runner build --delete-conflicting-outputs
```

During active development you can keep it running:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Location

Models live in their feature's `models/` folder:
`lib/features/<feature>/models/`.

## Model shape

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_model.freezed.dart';
part 'my_model.g.dart'; // only if JSON (de)serialization is needed

@freezed
class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    required String name,
  }) = _MyModel;

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);
}
```

- Add the `part 'x.g.dart'` and the `fromJson` only when the model is
  serialized (typically for Firestore).
- Never commit a model without regenerating and confirming `flutter analyze`
  passes.

> Prerequisite: `freezed`, `build_runner`, `json_serializable` in
> `dev_dependencies` and `freezed_annotation` in `dependencies` (to be added to
> `pubspec.yaml`).
