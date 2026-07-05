import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/settings/models/mock_rewards.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Settings list of the profile (`.pf-list`).
class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final rows = <_SettingsRowData>[
      _SettingsRowData(
        icon: AppIconData.bell,
        label: l10n.notificationsLabel,
        detail: l10n.notificationsEnabled,
      ),
      _SettingsRowData(
        icon: AppIconData.repeat,
        label: l10n.remindersEntryLabel,
        onTap: () => context.push(AppRoute.settingsReminders.path),
      ),
      _SettingsRowData(
        icon: AppIconData.gift,
        label: l10n.rewardsEntryLabel,
        detail: l10n.rewardsEntryDetail(MockRewards.rewards.length),
        onTap: () => context.push(AppRoute.settingsRewards.path),
      ),
      _SettingsRowData(icon: AppIconData.help, label: l10n.helpLabel),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        children: [
          for (final (index, row) in rows.indexed) ...[
            if (index > 0)
              const Divider(
                height: 1,
                color: AppColors.lineLight,
                indent: AppSpacing.cardPadding,
                endIndent: AppSpacing.cardPadding,
              ),
            _SettingsRow(data: row),
          ],
        ],
      ),
    );
  }
}

class _SettingsRowData {
  const _SettingsRowData({
    required this.icon,
    required this.label,
    this.detail,
    this.onTap,
  });

  final AppIconData icon;
  final String label;
  final String? detail;
  final VoidCallback? onTap;
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.data});

  final _SettingsRowData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: data.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding,
          vertical: 13,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lineLight,
                borderRadius: BorderRadius.circular(AppRadii.chip),
              ),
              child: AppIcon(data.icon, size: 18),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                data.label,
                style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
              ),
            ),
            if (data.detail != null) ...[
              Text(
                data.detail!,
                style: AppTextStyles.action.copyWith(
                  fontSize: 13,
                  color: AppColors.inkTertiary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            const AppIcon(
              AppIconData.chevronRight,
              size: 16,
              color: AppColors.inkTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
