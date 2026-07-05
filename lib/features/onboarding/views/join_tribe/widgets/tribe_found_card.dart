import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Card confirming the tribe matched by the entered code (`.ob-found`).
class TribeFoundCard extends StatelessWidget {
  const TribeFoundCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.soften(AppColors.accent, 0.08),
        border: Border.all(color: AppColors.soften(AppColors.accent, 0.3)),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Text(
              MockMembers.tribeName.split(' ').last[0],
              style: GoogleFonts.figtree(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MockMembers.tribeName,
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                ),
                Text(
                  l10n.membersCount(MockMembers.members.length),
                  style: AppTextStyles.note.copyWith(
                    color: AppColors.inkTertiary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: const AppIcon(
              AppIconData.check,
              size: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
