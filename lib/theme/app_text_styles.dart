import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Text styles of the design direction. Single family: Figtree.
abstract final class AppTextStyles {
  static TextStyle _figtree({
    required double size,
    required FontWeight weight,
    Color color = AppColors.ink,
    double? letterSpacingEm,
    double? height,
  }) => GoogleFonts.figtree(
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: letterSpacingEm != null ? letterSpacingEm * size : null,
    height: height,
  );

  /// Screen titles (detail, settings sub-screens): 24 / 700 / -0.02em.
  static final TextStyle screenTitle = _figtree(
    size: 24,
    weight: FontWeight.w700,
    letterSpacingEm: -0.02,
    height: 1.12,
  );

  /// Home greeting: 26 / 700 / -0.02em.
  static final TextStyle greeting = _figtree(
    size: 26,
    weight: FontWeight.w700,
    letterSpacingEm: -0.02,
    height: 1.05,
  );

  /// Onboarding wordmark "Our Tribe": 30 / 800 / -0.02em.
  static final TextStyle wordmark = _figtree(
    size: 30,
    weight: FontWeight.w800,
    letterSpacingEm: -0.02,
  );

  /// Brand row "OUR TRIBE" kicker: 12 / 800 / uppercase / .14em.
  static final TextStyle brand = _figtree(
    size: 12,
    weight: FontWeight.w800,
    color: AppColors.inkTertiary,
    letterSpacingEm: 0.14,
  );

  /// Header date / kicker above titles: 13 / 600.
  static final TextStyle headerKicker = _figtree(
    size: 13,
    weight: FontWeight.w600,
    color: AppColors.inkTertiary,
  );

  /// Section titles: 15 / 700 / -0.01em.
  static final TextStyle sectionTitle = _figtree(
    size: 15,
    weight: FontWeight.w700,
    letterSpacingEm: -0.01,
  );

  /// Task names: 15 / 600 / -0.01em.
  static final TextStyle taskName = _figtree(
    size: 15,
    weight: FontWeight.w600,
    letterSpacingEm: -0.01,
    height: 1.25,
  );

  /// Meta (time, recurrence): 12 / 600 / tertiary ink.
  static final TextStyle meta = _figtree(
    size: 12,
    weight: FontWeight.w600,
    color: AppColors.inkTertiary,
  );

  /// Uppercase labels (form labels, "dt-label"): 12 / 700 / .05em.
  static final TextStyle kicker = _figtree(
    size: 12,
    weight: FontWeight.w700,
    color: AppColors.inkTertiary,
    letterSpacingEm: 0.05,
  );

  /// Points figures in pills: 14 / 700.
  static final TextStyle points = _figtree(
    size: 14,
    weight: FontWeight.w700,
    color: AppColors.ochre,
  );

  /// Points figure in the header pill: 15 / 700.
  static final TextStyle pointsLarge = _figtree(
    size: 15,
    weight: FontWeight.w700,
    color: AppColors.ochre,
  );

  /// Body copy (descriptions, subtitles): 14.5 / 500.
  static final TextStyle body = _figtree(
    size: 14.5,
    weight: FontWeight.w500,
    color: AppColors.inkSecondary,
    height: 1.45,
  );

  /// Small notes: 12.5 / 500.
  static final TextStyle note = _figtree(
    size: 12.5,
    weight: FontWeight.w500,
    color: AppColors.inkSecondary,
    height: 1.45,
  );

  /// Full-width button labels: 16 / 700 / -0.01em.
  static final TextStyle button = _figtree(
    size: 16,
    weight: FontWeight.w700,
    color: Colors.white,
    letterSpacingEm: -0.01,
  );

  /// Secondary action labels (13–13.5 / 600).
  static final TextStyle action = _figtree(
    size: 13.5,
    weight: FontWeight.w600,
    color: AppColors.inkSecondary,
  );

  /// Text input content: 15 / 500.
  static final TextStyle input = _figtree(size: 15, weight: FontWeight.w500);

  /// Big animated numbers (recap total): 40 / 600.
  static final TextStyle bigNumber = _figtree(
    size: 40,
    weight: FontWeight.w600,
    height: 1,
  );

  /// Tab bar labels: 10 / 700.
  static final TextStyle tabLabel = _figtree(
    size: 10,
    weight: FontWeight.w700,
    color: AppColors.inkTertiary,
  );

  /// Avatar initials, sized by the avatar widget.
  static final TextStyle initial = _figtree(
    size: 15,
    weight: FontWeight.w700,
    color: Colors.white,
  );
}
