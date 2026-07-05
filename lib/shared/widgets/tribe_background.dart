import 'package:flutter/material.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// App background: base color + the signature "links" motif, a 48×48 tile
/// of two chevrons connecting five small nodes.
class TribeBackground extends StatelessWidget {
  const TribeBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.background),
      child: CustomPaint(painter: _LinksMotifPainter(), child: child),
    );
  }
}

class _LinksMotifPainter extends CustomPainter {
  static const double _tile = 48;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.motif.withValues(alpha: 0.06);
    final fill = Paint()..color = AppColors.motif.withValues(alpha: 0.07);

    for (double x = 0; x < size.width; x += _tile) {
      for (double y = 0; y < size.height; y += _tile) {
        final chevronDown = Path()
          ..moveTo(x + 12, y + 12)
          ..lineTo(x + 24, y + 24)
          ..lineTo(x + 36, y + 12);
        final chevronUp = Path()
          ..moveTo(x + 12, y + 36)
          ..lineTo(x + 24, y + 24)
          ..lineTo(x + 36, y + 36);
        canvas.drawPath(chevronDown, stroke);
        canvas.drawPath(chevronUp, stroke);
        for (final node in const [
          Offset(12, 12),
          Offset(36, 12),
          Offset(24, 24),
          Offset(12, 36),
          Offset(36, 36),
        ]) {
          canvas.drawCircle(Offset(x, y) + node, 1.6, fill);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
