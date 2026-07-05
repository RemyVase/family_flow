import 'package:flutter/material.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_member_row.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Members card (`.pf-card`): member list with per-role interactions and
/// the role-specific hint.
class ProfileMembersCard extends StatelessWidget {
  const ProfileMembersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<ProfileController>();
    final members = context.watch<TribeService>().members;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.membersLabel(members.length),
                  style: AppTextStyles.sectionTitle,
                ),
              ),
              if (controller.isChief)
                Text(
                  l10n.manageAction,
                  style: AppTextStyles.action.copyWith(
                    fontSize: 13,
                    color: AppColors.accent,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          for (final (index, member) in members.indexed) ...[
            if (index > 0) const Divider(height: 1, color: AppColors.lineLight),
            ProfileMemberRow(member: member),
          ],
          const SizedBox(height: 11),
          const Divider(height: 1, color: AppColors.lineLight),
          const SizedBox(height: 11),
          Row(
            children: [
              const AppIcon(
                AppIconData.sparkle,
                size: 13,
                color: AppColors.inkTertiary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  controller.isChief
                      ? l10n.chiefMembersHint
                      : l10n.memberColorHint,
                  style: AppTextStyles.meta,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
