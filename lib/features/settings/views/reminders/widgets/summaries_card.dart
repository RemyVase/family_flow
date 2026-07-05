import 'package:flutter/material.dart';
import 'package:our_tribe/features/settings/views/reminders/reminders_controller.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/setting_row.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/settings_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:provider/provider.dart';

/// "Récapitulatifs" card: morning summary, evening reminder, overdue alert.
class SummariesCard extends StatelessWidget {
  const SummariesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RemindersController>();

    return SettingsCard(
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
          iconBackground: AppColors.soften(AppColors.memberTerracotta, 0.2),
          label: l10n.overdueLabel,
          detail: l10n.overdueDetail,
          value: controller.overdueAlert,
          onChanged: controller.setOverdueAlert,
        ),
      ],
    );
  }
}
