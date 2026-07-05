/// Spacing / sizing scale. No raw paddings in widgets.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 6;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;

  /// Horizontal padding of every screen.
  static const double screenHorizontal = 20;

  /// Gap between a section header and its cards.
  static const double sectionGap = 24;

  /// Inner padding of cards (task cards, panels…).
  static const double cardPadding = 14;

  /// Inner padding of large panels (progress card, recap panels).
  static const double panelPadding = 16;

  /// Bottom padding so scroll content clears the sticky action bar.
  static const double stickyActionClearance = 108;
}
