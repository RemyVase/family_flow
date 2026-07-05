import 'package:flutter/material.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Points pill: hexagonal token + figure, ochre by default
/// (`.tpts` / `.pts-pill` / `.lead-pts`).
class PointsBadge extends StatelessWidget {
  const PointsBadge({
    super.key,
    required this.text,
    this.color = AppColors.ochre,
    this.background = AppColors.ochreSoft,
    this.large = false,
  });

  /// Points figure, optionally suffixed (e.g. "3" or "12 pts").
  final String text;
  final Color color;
  final Color background;

  /// Header-sized variant (40px tall).
  final bool large;

  @override
  Widget build(BuildContext context) {
    final style = (large ? AppTextStyles.pointsLarge : AppTextStyles.points)
        .copyWith(color: color);

    return Container(
      height: large ? 40 : null,
      padding: large
          ? const EdgeInsets.only(left: 11, right: 13)
          : const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          large ? AppRadii.input : AppRadii.pointsPill,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(AppIconData.token, size: large ? 14 : 11, color: color),
          SizedBox(width: large ? 5 : 4),
          Text(text, style: style),
        ],
      ),
    );
  }
}
