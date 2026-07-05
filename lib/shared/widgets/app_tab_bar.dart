import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Flat tab bar (`.tabs`): 1px top hairline, four tabs and a central
/// square "+" FAB.
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onCreatePressed,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        11,
        12,
        11 + (bottomInset > 0 ? bottomInset : 8),
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          _TabItem(
            icon: AppIconData.home,
            label: l10n.tabHome,
            isActive: currentIndex == 0,
            onTap: () => onTabSelected(0),
          ),
          _TabItem(
            icon: AppIconData.calendar,
            label: l10n.tabWeek,
            isActive: currentIndex == 1,
            onTap: () => onTabSelected(1),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: onCreatePressed,
                child: Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  child: const AppIcon(
                    AppIconData.plus,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          _TabItem(
            icon: AppIconData.chart,
            label: l10n.tabFamily,
            isActive: currentIndex == 2,
            onTap: () => onTabSelected(2),
          ),
          _TabItem(
            icon: AppIconData.user,
            label: l10n.tabProfile,
            isActive: currentIndex == 3,
            onTap: () => onTabSelected(3),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final AppIconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accent : AppColors.inkTertiary;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(icon, size: 22, color: color),
            const SizedBox(height: 5),
            Text(label, style: AppTextStyles.tabLabel.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
