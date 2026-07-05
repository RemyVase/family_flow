import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Ochre "à tour de rôle" badge shown on rotating tasks (`.rot-badge`).
class RotateBadge extends StatelessWidget {
  const RotateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.ochreSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppIcon(AppIconData.repeat, size: 11, color: AppColors.ochre),
          const SizedBox(width: 3),
          Text(
            l10n.rotateBadge,
            style: AppTextStyles.meta.copyWith(color: AppColors.ochre),
          ),
        ],
      ),
    );
  }
}
