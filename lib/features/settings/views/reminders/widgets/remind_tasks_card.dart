import 'package:flutter/material.dart';
import 'package:our_tribe/features/settings/views/reminders/reminders_controller.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/setting_row.dart';
import 'package:our_tribe/features/settings/views/reminders/widgets/settings_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/segmented_control.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Rappels" card: master toggle + lead-time picker shown when enabled.
class RemindTasksCard extends StatelessWidget {
  const RemindTasksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RemindersController>();

    return SettingsCard(
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
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.leadTimeLabel,
                  style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
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
                  onChanged: (index) =>
                      controller.setLeadTime(ReminderLeadTime.values[index]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
