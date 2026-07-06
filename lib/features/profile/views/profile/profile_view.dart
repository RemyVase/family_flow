import 'package:flutter/material.dart';
import 'package:our_tribe/features/profile/views/profile/profile_controller.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/leave_tribe_sheet.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_invite_code_card.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_logout_button.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_member_row.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_members_card.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_settings_list.dart';
import 'package:our_tribe/features/profile/views/profile/widgets/profile_user_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/notification_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Profile tab: user card, tribe members, invite code, settings, logout.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileController(
        context.read<TribeService>(),
        context.read<AuthService>(),
        context.read<NotificationService>(),
      ),
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tribeName = context.watch<TribeService>().tribeName;

    return Scaffold(
      body: TribeBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.lg,
              AppSpacing.screenHorizontal,
              AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.myAccountKicker, style: AppTextStyles.headerKicker),
                const SizedBox(height: 3),
                Text(l10n.profileTitle, style: AppTextStyles.greeting),
                const SizedBox(height: 22),
                const ProfileUserCard(),
                const SizedBox(height: AppSpacing.xl),
                SectionLabel(tribeName),
                const SizedBox(height: AppSpacing.sm),
                const ProfileMembersCard(),
                const SizedBox(height: AppSpacing.lg),
                const ProfileInviteCodeCard(),
                const SizedBox(height: AppSpacing.xl),
                SectionLabel(l10n.settingsLabel),
                const SizedBox(height: AppSpacing.sm),
                const ProfileSettingsList(),
                const SizedBox(height: AppSpacing.lg + 2),
                const _LeaveTribeButton(),
                const SizedBox(height: 9),
                const ProfileLogoutButton(),
                const SizedBox(height: AppSpacing.cardPadding),
                Center(
                  child: Text(
                    l10n.versionLabel('1.0'),
                    style: AppTextStyles.note.copyWith(
                      fontSize: 12,
                      color: AppTextStyles.meta.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Quitter la tribu" button (`.pf-leave`), opens the leave sheet.
class _LeaveTribeButton extends StatelessWidget {
  const _LeaveTribeButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => showLeaveTribeSheet(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.soften(kDangerRed, 0.26)),
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(AppIconData.logout, size: 18, color: kDangerRed),
            const SizedBox(width: AppSpacing.sm),
            Text(
              l10n.leaveTribeButton,
              style: AppTextStyles.action.copyWith(
                fontSize: 15,
                color: kDangerRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
