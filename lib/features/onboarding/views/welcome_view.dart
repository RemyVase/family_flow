import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/views/widgets/avatar_cluster.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/tribe_mark.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// First onboarding step: logo, wordmark, tagline and entry actions.
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OnboardingScaffold(
      centered: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TribeMark(size: 78),
          const SizedBox(height: 22),
          Text(l10n.appName, style: AppTextStyles.wordmark),
          const SizedBox(height: 10),
          Text(
            l10n.welcomeTagline,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 30),
          const AvatarCluster(),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: l10n.createAccountButton,
            trailingIcon: AppIconData.arrowRight,
            onPressed: () => context.push(AppRoute.onboardingSignup.path),
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: () => context.push(AppRoute.onboardingSignin.path),
            child: Text(
              l10n.alreadyHaveAccount,
              style: AppTextStyles.action.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
