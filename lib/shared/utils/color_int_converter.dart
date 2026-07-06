import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

/// Stores a [Color] as its ARGB int value in Firestore documents.
class ColorIntConverter implements JsonConverter<Color, int> {
  const ColorIntConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color object) => object.toARGB32();
}
