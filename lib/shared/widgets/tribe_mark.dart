import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/shared/widgets/hexagon_clipper.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// The hexagonal "OT" monogram token.
///
/// Renders the monogram text by default, or [child] when provided
/// (e.g. a check icon on the onboarding done screen).
class TribeMark extends StatelessWidget {
  const TribeMark({
    super.key,
    this.size = 22,
    this.color = AppColors.accent,
    this.child,
  });

  final double size;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const HexagonClipper(),
      child: Container(
        width: size,
        height: size,
        color: color,
        alignment: Alignment.center,
        child:
            child ??
            Text(
              'OT',
              style: GoogleFonts.figtree(
                // Monogram scales with the token (10px at 22px, 26px at 78px).
                fontSize: size * 10 / 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.02 * size * 10 / 22,
                color: Colors.white,
                height: 1,
              ),
            ),
      ),
    );
  }
}
