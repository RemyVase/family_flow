import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Sign-out button (`.pf-logout`). Returns to onboarding for now.
class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => context.go(AppRoute.onboardingWelcome.path),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(
              AppIconData.logout,
              size: 18,
              color: AppColors.memberTerracotta,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              l10n.logoutButton,
              style: AppTextStyles.action.copyWith(
                fontSize: 15,
                color: AppColors.memberTerracotta,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
