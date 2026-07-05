import 'package:flutter/material.dart';

/// Wraps the app with a thin green strip at the top of the screen when
/// [enabled] is true (development environment).
///
/// Hooked into `MaterialApp.builder` so the strip stays visible above
/// every screen of the app.
class DevBanner extends StatelessWidget {
  const DevBanner({super.key, required this.enabled, required this.child});

  final bool enabled;
  final Widget child;

  /// Strip thickness: very thin but visible.
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
            child: Container(height: _height, color: const Color(0xFF00C853)),
          ),
        ),
      ],
    );
  }
}
