import 'package:flutter/animation.dart';

/// Motion tokens of the design direction.
abstract final class AppDurations {
  /// Progress bars / rings fill.
  static const Duration progress = Duration(milliseconds: 500);

  /// Recap bars height, reward bar.
  static const Duration bars = Duration(milliseconds: 600);

  /// Checkbox "pop" on completion.
  static const Duration pop = Duration(milliseconds: 320);

  /// Segmented control thumb slide.
  static const Duration segmented = Duration(milliseconds: 240);

  /// Switch knob slide.
  static const Duration toggle = Duration(milliseconds: 220);

  /// Standard ease of the design (`cubic-bezier(.4,0,.2,1)`).
  static const Curve ease = Cubic(0.4, 0, 0.2, 1);

  /// Springy overshoot ease (`cubic-bezier(.34,1.5,.5,1)`).
  static const Curve spring = Cubic(0.34, 1.5, 0.5, 1);
}
