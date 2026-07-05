import 'package:flutter/material.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Selectable form chip (`.cf-chip`): accent tint when selected.
class FormChip extends StatelessWidget {
  const FormChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AppIconData? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? AppColors.deepen(AppColors.accent, 0.2)
        : AppColors.inkSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.soften(AppColors.accent, 0.14)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(AppRadii.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              AppIcon(icon!, size: 13, color: foreground),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: AppTextStyles.action.copyWith(
                fontSize: 13,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
