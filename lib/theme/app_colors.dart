import 'package:flutter/material.dart';

/// Color palette of the "Calme + esprit tribu" design direction.
///
/// Values come from the design handoff (`design_handoff_our_tribe/README.md`).
abstract final class AppColors {
  // Neutrals & surfaces.
  static const Color background = Color(0xFFFBFAF6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFFAF8F3);
  static const Color ink = Color(0xFF22201C);
  static const Color inkSecondary = Color(0xFF7A7468);
  static const Color inkTertiary = Color(0xFFA9A395);
  static const Color line = Color(0xFFECE7DC);
  static const Color lineLight = Color(0xFFF3EFE8);

  // Accent (deep green).
  static const Color accent = Color(0xFF2F6D4E);
  static final Color accentSoft = soften(accent);

  // Points / gamification (warm ochre).
  static const Color ochre = Color(0xFF9C7C43);
  static const Color ochreSoft = Color(0xFFF5F0E6);

  // Moments of the day.
  static const Color sun = Color(0xFFB5843A);
  static const Color sunSoft = Color(0xFFF6E7C9);
  static const Color sky = Color(0xFF5B80A0);
  static const Color skySoft = Color(0xFFDDE9F1);
  static const Color dusk = Color(0xFF8270A8);
  static const Color duskSoft = Color(0xFFE9E1F2);

  // Misc.
  static const Color checkboxBorder = Color(0xFFDAD3C4);
  static const Color positiveDelta = Color(0xFF2E9E6E);
  static const Color motif = Color(0xFF7A6A4D);

  // Default member colors (each person = one color).
  static const Color memberTerracotta = Color(0xFFC25A38);
  static const Color memberBlue = Color(0xFF3E6AA6);
  static const Color memberGreen = Color(0xFF2E8461);
  static const Color memberPurple = Color(0xFF6C57A6);

  /// Palette offered when picking a member color in the profile.
  static const List<Color> memberPalette = [
    Color(0xFFF07557),
    Color(0xFF4FA3E3),
    Color(0xFF3FB088),
    Color(0xFF8E7CE0),
    Color(0xFFF0A93C),
    Color(0xFFE86FA6),
    Color(0xFF5FB0C9),
    Color(0xFF7E9B54),
  ];

  /// Palette offered when creating a tribe during onboarding.
  static const List<Color> tribePalette = [
    memberTerracotta,
    memberBlue,
    memberGreen,
    memberPurple,
    sun,
    Color(0xFFB0517E),
  ];

  /// Soft derivative of a color, equivalent to the design's
  /// `color-mix(<color> 12%, #fff)`.
  static Color soften(Color color, [double amount = 0.12]) =>
      Color.lerp(Colors.white, color, amount)!;

  /// Darkened derivative used for text on soft backgrounds, equivalent to
  /// the design's `color-mix(<color> ~75%, #000 8%)`.
  static Color deepen(Color color, [double amount = 0.25]) =>
      Color.lerp(color, const Color(0xFF1B141F), amount)!;
}
