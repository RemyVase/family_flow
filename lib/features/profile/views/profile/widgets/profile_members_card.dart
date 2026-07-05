import 'package:flutter/material.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/color_swatch_button.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Members card (`.pf-card`): member list, per-member color palette
/// (chief only) and the chief hint.
class ProfileMembersCard extends StatelessWidget {
  const ProfileMembersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            _MemberRow(member: member),
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
                child: Text(l10n.chiefColorHint, style: AppTextStyles.meta),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<ProfileController>();
    final isEditing = controller.editingMemberId == member.id;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.toggleEditing(member.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                MemberAvatar(member: member, size: 30, filled: true),
                const SizedBox(width: 10),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: member.name,
                      style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
                      children: [
                        if (member.isChief)
                          TextSpan(
                            text: ' · ${l10n.chiefSuffix}',
                            style: AppTextStyles.meta,
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: member.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: member.color.withValues(alpha: 0.12),
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const AppIcon(
                  AppIconData.pencil,
                  size: 14,
                  color: AppColors.inkTertiary,
                ),
              ],
            ),
          ),
        ),
        if (isEditing)
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              top: 4,
              bottom: AppSpacing.md,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 9,
                runSpacing: 9,
                children: [
                  for (final color in AppColors.memberPalette)
                    ColorSwatchButton(
                      color: color,
                      isSelected: member.color == color,
                      onTap: () => controller.setMemberColor(member.id, color),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
