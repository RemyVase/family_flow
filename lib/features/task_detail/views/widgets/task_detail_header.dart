import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_icon_button.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Top action row of the detail screen: back + edit.
class TaskDetailHeader extends StatelessWidget {
  const TaskDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          icon: AppIconData.chevronLeft,
          onPressed: () => context.pop(),
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Row(
            children: [
              const AppIcon(AppIconData.pencil, size: 19),
              const SizedBox(width: 5),
              Text(l10n.editButton, style: AppTextStyles.action),
            ],
          ),
        ),
      ],
    );
  }
}
