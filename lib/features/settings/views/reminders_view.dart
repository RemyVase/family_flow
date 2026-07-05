import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/settings/controllers/reminders_controller.dart';
import 'package:our_tribe/features/settings/views/widgets/setting_row.dart';
import 'package:our_tribe/features/settings/views/widgets/settings_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/segmented_control.dart';
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
    final controller = context.watch<RemindersController>();

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
                    SettingsCard(
                      children: [
                        SettingRow(
                          icon: AppIconData.bell,
                          iconColor: AppColors.sun,
                          iconBackground: AppColors.sunSoft,
                          label: l10n.remindTasksLabel,
                          detail: l10n.remindTasksDetail,
                          value: controller.remindTasks,
                          onChanged: controller.setRemindTasks,
                        ),
                        if (controller.remindTasks)
                          Padding(
                            padding: const EdgeInsets.all(
                              AppSpacing.cardPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.leadTimeLabel,
                                  style: AppTextStyles.taskName.copyWith(
                                    fontSize: 14.5,
                                  ),
                                ),
                                const SizedBox(height: 9),
                                SegmentedControl(
                                  options: [
                                    l10n.leadOnTime,
                                    l10n.leadFifteenMinutes,
                                    l10n.leadThirtyMinutes,
                                    l10n.leadOneHour,
                                  ],
                                  selectedIndex: controller.leadTime.index,
                                  onChanged: (index) => controller.setLeadTime(
                                    ReminderLeadTime.values[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.summariesSection),
                    const SizedBox(height: AppSpacing.sm),
                    SettingsCard(
                      children: [
                        SettingRow(
                          icon: AppIconData.sun,
                          iconColor: AppColors.sun,
                          iconBackground: AppColors.sunSoft,
                          label: l10n.morningSummaryLabel,
                          detail: l10n.morningSummaryDetail,
                          value: controller.morningSummary,
                          onChanged: controller.setMorningSummary,
                        ),
                        SettingRow(
                          icon: AppIconData.moon,
                          iconColor: AppColors.dusk,
                          iconBackground: AppColors.duskSoft,
                          label: l10n.eveningReminderLabel,
                          detail: l10n.eveningReminderDetail,
                          value: controller.eveningReminder,
                          onChanged: controller.setEveningReminder,
                        ),
                        SettingRow(
                          icon: AppIconData.clock,
                          iconColor: AppColors.memberTerracotta,
                          iconBackground: AppColors.soften(
                            AppColors.memberTerracotta,
                            0.2,
                          ),
                          label: l10n.overdueLabel,
                          detail: l10n.overdueDetail,
                          value: controller.overdueAlert,
                          onChanged: controller.setOverdueAlert,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.recurrencesSection),
                    const SizedBox(height: AppSpacing.sm),
                    SettingsCard(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.weekStartLabel,
                                style: AppTextStyles.taskName.copyWith(
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                l10n.weekStartDetail,
                                style: AppTextStyles.note.copyWith(
                                  fontSize: 12,
                                  color: AppColors.inkTertiary,
                                ),
                              ),
                              const SizedBox(height: 9),
                              SegmentedControl(
                                options: [
                                  l10n.mondayLabel,
                                  l10n.saturdayLabel,
                                  l10n.sundayLabel,
                                ],
                                selectedIndex: controller.weekStartDay.index,
                                onChanged: (index) =>
                                    controller.setWeekStartDay(
                                      WeekStartDay.values[index],
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SettingRow(
                          icon: AppIconData.repeat,
                          iconColor: AppColors.memberGreen,
                          iconBackground: AppColors.soften(
                            AppColors.memberGreen,
                            0.2,
                          ),
                          label: l10n.autoCarryLabel,
                          detail: l10n.autoCarryDetail,
                          value: controller.autoCarryOver,
                          onChanged: controller.setAutoCarryOver,
                        ),
                      ],
                    ),
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
