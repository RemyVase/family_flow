import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/task_create/controllers/task_create_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// − / points pill / + stepper (`.cf-stepper`).
class TaskCreatePointsStepper extends StatelessWidget {
  const TaskCreatePointsStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();

    return Row(
      children: [
        _StepButton(
          icon: AppIconData.minus,
          isEnabled: controller.canDecrementPoints,
          onTap: controller.decrementPoints,
        ),
        const SizedBox(width: 10),
        Container(
          constraints: const BoxConstraints(minWidth: 56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: AppColors.ochreSoft,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(
                AppIconData.token,
                size: 15,
                color: AppColors.ochre,
              ),
              const SizedBox(width: 5),
              Text(
                '${controller.points}',
                style: GoogleFonts.figtree(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ochre,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _StepButton(
          icon: AppIconData.plus,
          isEnabled: controller.canIncrementPoints,
          color: AppColors.accent,
          onTap: controller.incrementPoints,
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(l10n.pointsHint, style: AppTextStyles.meta)),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.isEnabled,
    required this.onTap,
    this.color = AppColors.ink,
  });

  final AppIconData icon;
  final bool isEnabled;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.55,
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: AppIcon(
            icon,
            color: isEnabled ? color : AppColors.inkTertiary,
          ),
        ),
      ),
    );
  }
}
