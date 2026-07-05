import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/tribe_mark.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Final onboarding step: the tribe is ready.
class OnboardingDoneView extends StatelessWidget {
  const OnboardingDoneView({super.key, required this.firstName});

  final String firstName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OnboardingScaffold(
      centered: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TribeMark(
            size: 78,
            child: AppIcon(AppIconData.check, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 22),
          Text(
            l10n.doneTitle(firstName),
            textAlign: TextAlign.center,
            style: AppTextStyles.wordmark.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.doneTagline,
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(fontSize: 15, height: 1.5),
          ),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.enterAppButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: () => context.go(AppRoute.home.path),
      ),
    );
  }
}
