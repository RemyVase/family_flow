import 'package:flutter/material.dart';

/// Enveloppe l'application d'un mince bandeau vert en haut de l'écran
/// lorsque [enabled] est vrai (environnement de développement).
///
/// À brancher sur `MaterialApp.builder` pour que le bandeau reste visible
/// au-dessus de tous les écrans de l'application.
class DevBanner extends StatelessWidget {
  const DevBanner({
    super.key,
    required this.enabled,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  /// Épaisseur du bandeau : très fine mais visible.
  static const double _height = 4.0;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Container(
              height: _height,
              color: const Color(0xFF00C853), // vert vif
            ),
          ),
        ),
      ],
    );
  }
}
