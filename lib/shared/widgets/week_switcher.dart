import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Compact week switcher (`.wk`): ‹ Sem. N ›. Navigation between weeks is
/// not wired yet (design-only).
class WeekSwitcher extends StatelessWidget {
  const WeekSwitcher({super.key, required this.weekNumber});

  final int weekNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        children: [
          const _WeekSwitchButton(icon: AppIconData.chevronLeft),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              l10n.recapWeekShort(weekNumber),
              style: AppTextStyles.action.copyWith(
                fontSize: 13,
                color: AppColors.ink,
              ),
            ),
          ),
          const _WeekSwitchButton(icon: AppIconData.chevronRight, dimmed: true),
        ],
      ),
    );
  }
}

class _WeekSwitchButton extends StatelessWidget {
  const _WeekSwitchButton({required this.icon, this.dimmed = false});

  final AppIconData icon;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lineLight,
        borderRadius: BorderRadius.circular(AppRadii.sectionIcon),
      ),
      child: AppIcon(
        icon,
        size: 15,
        color: dimmed ? AppColors.inkTertiary : AppColors.inkSecondary,
      ),
    );
  }
}
