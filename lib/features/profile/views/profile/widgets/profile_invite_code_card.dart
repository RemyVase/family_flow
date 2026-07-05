import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Invite code card of the profile (`.pf-code`).
class ProfileInviteCodeCard extends StatelessWidget {
  const ProfileInviteCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final inviteCode = context.watch<TribeService>().inviteCode;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(const Color(0xFFFFFDFA), AppColors.accent, 0.12)!,
            Color.lerp(const Color(0xFFFFF6EE), AppColors.accent, 0.26)!,
          ],
        ),
        border: Border.all(color: AppColors.soften(AppColors.accent, 0.22)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.inviteCodeLabel.toUpperCase(),
                  style: AppTextStyles.kicker.copyWith(
                    fontSize: 11,
                    letterSpacing: 0.4,
                    color: AppColors.deepen(AppColors.accent, 0.2),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  inviteCode,
                  style: GoogleFonts.figtree(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                    height: 1.1,
                    color: AppColors.deepen(AppColors.accent, 0.38),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                AppIcon(
                  AppIconData.share,
                  size: 16,
                  color: AppColors.deepen(AppColors.accent, 0.2),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  l10n.shareButton,
                  style: AppTextStyles.action.copyWith(
                    color: AppColors.deepen(AppColors.accent, 0.2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
