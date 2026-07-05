import 'package:flutter/rendering.dart';

/// Hexagonal clip used by the "OT" monogram:
/// `polygon(25% 3%, 75% 3%, 100% 50%, 75% 97%, 25% 97%, 0 50%)`.
class HexagonClipper extends CustomClipper<Path> {
  const HexagonClipper();

  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * 0.25, size.height * 0.03)
    ..lineTo(size.width * 0.75, size.height * 0.03)
    ..lineTo(size.width, size.height * 0.50)
    ..lineTo(size.width * 0.75, size.height * 0.97)
    ..lineTo(size.width * 0.25, size.height * 0.97)
    ..lineTo(0, size.height * 0.50)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
