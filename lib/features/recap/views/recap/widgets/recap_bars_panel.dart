import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "This week, per person" panel: vertical bars in member colors.
class RecapBarsPanel extends StatelessWidget {
  const RecapBarsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final members = context.watch<TribeService>().members;
    final maxPoints = context.watch<RecapController>().maxMemberPoints;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.panelPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.perPersonTitle,
            style: AppTextStyles.headerKicker.copyWith(
              color: AppColors.inkSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.cardPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final member in members)
                Expanded(
                  child: _MemberBar(member: member, maxPoints: maxPoints),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberBar extends StatelessWidget {
  const _MemberBar({required this.member, required this.maxPoints});

  final Member member;
  final int maxPoints;

  @override
  Widget build(BuildContext context) {
    final height = maxPoints == 0
        ? 8.0
        : (member.weeklyPoints / maxPoints) * 82 + 8;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${member.weeklyPoints}',
          style: GoogleFonts.figtree(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: member.color,
          ),
        ),
        const SizedBox(height: 7),
        AnimatedContainer(
          duration: AppDurations.bars,
          curve: AppDurations.ease,
          width: 40,
          height: height,
          decoration: BoxDecoration(
            color: member.color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
              bottom: Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.soften(member.color, 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.soften(member.color, 0.3),
              width: 1.5,
            ),
          ),
          child: Text(
            member.initial,
            style: GoogleFonts.figtree(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: member.color,
            ),
          ),
        ),
      ],
    );
  }
}
