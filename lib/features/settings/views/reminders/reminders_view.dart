import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/settings/views/reminders/reminders_controller.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/recurrences_card.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/remind_tasks_card.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/summaries_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Recurrences & reminders" settings screen.
class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RemindersController(),
      child: const _RemindersBody(),
    );
  }
}

class _RemindersBody extends StatelessWidget {
  const _RemindersBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: TribeBackground(
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.stickyActionClearance,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      title: l10n.remindersTitle,
                      subtitle: l10n.remindersSubtitle,
                    ),
                    SectionLabel(l10n.remindersSection),
                    const SizedBox(height: AppSpacing.sm),
                    const RemindTasksCard(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.summariesSection),
                    const SizedBox(height: AppSpacing.sm),
                    const SummariesCard(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.recurrencesSection),
                    const SizedBox(height: AppSpacing.sm),
                    const RecurrencesCard(),
                    const SizedBox(height: AppSpacing.lg),
                    const _RemindersNote(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyActionBar(
                child: PrimaryButton(
                  label: l10n.saveButton,
                  leadingIcon: AppIconData.check,
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemindersNote extends StatelessWidget {
  const _RemindersNote();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppIcon(AppIconData.sparkle, size: 14, color: AppColors.accent),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(l10n.remindersNote, style: AppTextStyles.note)),
        ],
      ),
    );
  }
}
