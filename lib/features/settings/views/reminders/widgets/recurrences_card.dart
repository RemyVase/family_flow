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

/// "Récurrences" card: week start day + automatic carry-over.
class RecurrencesCard extends StatelessWidget {
  const RecurrencesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RemindersController>();

    return SettingsCard(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.weekStartLabel,
                style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
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
                    controller.setWeekStartDay(WeekStartDay.values[index]),
              ),
            ],
          ),
        ),
        SettingRow(
          icon: AppIconData.repeat,
          iconColor: AppColors.memberGreen,
          iconBackground: AppColors.soften(AppColors.memberGreen, 0.2),
          label: l10n.autoCarryLabel,
          detail: l10n.autoCarryDetail,
          value: controller.autoCarryOver,
          onChanged: controller.setAutoCarryOver,
        ),
      ],
    );
  }
}
