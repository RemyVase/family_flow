import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/task_card.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Photo row of the create form: dashed "add" button + placeholder.
class TaskCreatePhotosRow extends StatelessWidget {
  const TaskCreatePhotosRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(
              color: AppColors.soften(AppColors.accent, 0.4),
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(
                AppIconData.camera,
                size: 20,
                color: AppColors.accent,
              ),
              const SizedBox(height: 3),
              Text(
                l10n.addPhotoButton,
                style: AppTextStyles.meta.copyWith(
                  fontSize: 11,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.input),
            child: const CustomPaint(
              painter: StripedPlaceholderPainter(stripeWidth: 8),
            ),
          ),
        ),
        const Spacer(),
        const SizedBox(width: AppSpacing.sm),
      ],
    );
  }
}
