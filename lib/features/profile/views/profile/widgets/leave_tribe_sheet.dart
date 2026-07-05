import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_member_row.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Opens the "leave the tribe" bottom sheet (`.pf-sheet`).
Future<void> showLeaveTribeSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const LeaveTribeSheet(),
  );
}

/// Leave-tribe confirmation: a member confirms, the chief must first
/// appoint a new chief, and the last member deletes the tribe.
class LeaveTribeSheet extends StatefulWidget {
  const LeaveTribeSheet({super.key});

  @override
  State<LeaveTribeSheet> createState() => _LeaveTribeSheetState();
}

class _LeaveTribeSheetState extends State<LeaveTribeSheet> {
  String? _newChiefId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tribeService = context.watch<TribeService>();
    final currentMember = tribeService.currentMember;
    final others = tribeService.members.where((m) => !m.isCurrentUser).toList();

    final isSoloChief = currentMember.isChief && others.isEmpty;
    final needsNewChief = currentMember.isChief && others.isNotEmpty;
    final canLeave = !needsNewChief || _newChiefId != null;

    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        10,
        AppSpacing.screenHorizontal,
        bottomInset + 22,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(
                top: 2,
                bottom: AppSpacing.cardPadding,
              ),
              decoration: BoxDecoration(
                color: AppColors.line,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          if (needsNewChief) ...[
            const _ChiefWarning(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.newChiefTitle,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final member in others) ...[
              _ChiefChoiceRow(
                member: member,
                isSelected: _newChiefId == member.id,
                onTap: () => setState(() => _newChiefId = member.id),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: 10),
          ] else ...[
            Text(
              isSoloChief
                  ? l10n.deleteTribeQuestion
                  : l10n.leaveTribeQuestion(tribeService.tribeName),
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              isSoloChief ? l10n.deleteTribeDetail : l10n.leaveTribeDetail,
              style: AppTextStyles.body.copyWith(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: AppSpacing.lg + 2),
          ],
          Row(
            children: [
              Expanded(
                child: _SheetButton(
                  label: l10n.cancelButton,
                  onTap: () => context.pop(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SheetButton(
                  label: needsNewChief
                      ? l10n.nameAndLeaveButton
                      : (isSoloChief ? l10n.deleteAction : l10n.leaveAction),
                  isDestructive: true,
                  // Leaving is design-only: back to onboarding.
                  onTap: canLeave
                      ? () => context.go(AppRoute.onboardingWelcome.path)
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChiefWarning extends StatelessWidget {
  const _ChiefWarning();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF1DD),
        border: Border.all(color: const Color(0xFFEAD8AE)),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppIcon(
            AppIconData.sparkle,
            size: 18,
            color: Color(0xFFB77400),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              l10n.leaveChiefWarning,
              style: AppTextStyles.action.copyWith(
                fontSize: 13,
                color: const Color(0xFF7A5A16),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChiefChoiceRow extends StatelessWidget {
  const _ChiefChoiceRow({
    required this.member,
    required this.isSelected,
    required this.onTap,
  });

  final Member member;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.soften(member.color, 0.2)
              : AppColors.surface,
          border: Border.all(color: isSelected ? member.color : AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Row(
          children: [
            MemberAvatar(member: member, size: 30, filled: true),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                member.name,
                style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? member.color : Colors.transparent,
                border: Border.all(
                  color: isSelected ? member.color : AppColors.line,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const AppIcon(
                      AppIconData.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.cardPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDestructive ? kDangerRed : AppColors.surface,
            border: isDestructive ? null : Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            label,
            style: AppTextStyles.action.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDestructive ? Colors.white : AppColors.inkSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
