import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/settings/views/notifications/notifications_controller.dart';
import 'package:our_tribe/features/settings/views/notifications/widgets/remind_tasks_card.dart';
import 'package:our_tribe/features/settings/views/notifications/widgets/summaries_card.dart';
import 'package:our_tribe/features/settings/widgets/setting_row.dart';
import 'package:our_tribe/features/settings/widgets/settings_card.dart';
import 'package:our_tribe/features/settings/widgets/settings_note.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Notifications settings screen: master switch + reminder, summary,
/// tribe-life and quiet-night preferences.
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationsController(),
      child: const _NotificationsBody(),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<NotificationsController>();

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
                      title: l10n.notificationsTitle,
                      subtitle: l10n.notificationsSubtitle,
                    ),
                    SettingsCard(
                      children: [
                        SettingRow(
                          icon: AppIconData.bell,
                          iconColor: AppColors.accent,
                          iconBackground: AppColors.accentSoft,
                          label: l10n.allowNotificationsLabel,
                          detail: controller.masterEnabled
                              ? l10n.notificationsOnDetail
                              : l10n.notificationsOffDetail,
                          value: controller.masterEnabled,
                          onChanged: controller.setMasterEnabled,
                        ),
                      ],
                    ),
                    _DimWhenPaused(
                      isPaused: !controller.masterEnabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.xl),
                          SectionLabel(l10n.taskRemindersSection),
                          const SizedBox(height: AppSpacing.sm),
                          const RemindTasksCard(),
                          const SizedBox(height: AppSpacing.xl),
                          SectionLabel(l10n.summariesSection),
                          const SizedBox(height: AppSpacing.sm),
                          const SummariesCard(),
                          const SizedBox(height: AppSpacing.xl),
                          SectionLabel(l10n.tribeLifeSection),
                          const SizedBox(height: AppSpacing.sm),
                          SettingsCard(
                            children: [
                              SettingRow(
                                icon: AppIconData.gift,
                                iconColor: AppColors.memberGreen,
                                iconBackground: AppColors.soften(
                                  AppColors.memberGreen,
                                  0.2,
                                ),
                                label: l10n.pointsRewardsLabel,
                                detail: l10n.pointsRewardsDetail,
                                value: controller.tribeLifeAlerts,
                                onChanged: controller.setTribeLifeAlerts,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          SectionLabel(l10n.doNotDisturbSection),
                          const SizedBox(height: AppSpacing.sm),
                          SettingsCard(
                            children: [
                              SettingRow(
                                icon: AppIconData.moon,
                                iconColor: AppColors.dusk,
                                iconBackground: AppColors.duskSoft,
                                label: l10n.quietNightLabel,
                                detail: l10n.quietNightDetail,
                                value: controller.quietNight,
                                onChanged: controller.setQuietNight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SettingsNote(
                      icon: AppIconData.sparkle,
                      text: l10n.remindersNote,
                    ),
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

/// Greys out and disables the notification sections while the master
/// switch is off.
class _DimWhenPaused extends StatelessWidget {
  const _DimWhenPaused({required this.isPaused, required this.child});

  final bool isPaused;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isPaused,
      child: Opacity(opacity: isPaused ? 0.45 : 1, child: child),
    );
  }
}
