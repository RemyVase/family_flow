import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Current user card (`.pf-user`): avatar, name, e-mail, edit button.
class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentMember = context.watch<TribeService>().currentMember;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: Row(
        children: [
          MemberAvatar(member: currentMember, size: 52),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentMember.name,
                  style: GoogleFonts.figtree(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    color: AppColors.ink,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  MockMembers.currentUserEmail,
                  style: AppTextStyles.headerKicker,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.line),
              borderRadius: BorderRadius.circular(AppRadii.chip),
            ),
            child: Row(
              children: [
                const AppIcon(AppIconData.pencil, size: 16),
                const SizedBox(width: 5),
                Text(
                  l10n.editProfileButton,
                  style: AppTextStyles.action.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
