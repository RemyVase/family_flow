import 'package:flutter/material.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Full-width primary button: 52px tall, accent background, white label,
/// optional trailing/leading icon. Disabled = line background, tertiary ink.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color = AppColors.accent,
    this.trailingIcon,
    this.leadingIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final AppIconData? trailingIcon;
  final AppIconData? leadingIcon;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final foreground = _isEnabled ? Colors.white : AppColors.inkTertiary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: _isEnabled ? color : AppColors.line,
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              AppIcon(leadingIcon!, color: foreground),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: AppTextStyles.button.copyWith(color: foreground),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: AppSpacing.sm),
              AppIcon(trailingIcon!, color: foreground),
            ],
          ],
        ),
      ),
    );
  }
}
