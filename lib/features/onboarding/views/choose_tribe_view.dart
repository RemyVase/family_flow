import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/views/widgets/choice_card.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';

/// "Your tribe" step: create a tribe or join with a code.
class ChooseTribeView extends StatelessWidget {
  const ChooseTribeView({super.key, required this.firstName});

  /// Carried through the flow to greet the user on the done step.
  final String firstName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(title: l10n.chooseTitle, subtitle: l10n.chooseSubtitle),
          ChoiceCard(
            icon: AppIconData.users,
            title: l10n.createTribeChoice,
            detail: l10n.createTribeChoiceDetail,
            isAccented: true,
            onTap: () => context.push(
              AppRoute.onboardingCreateTribe.path,
              extra: firstName,
            ),
          ),
          ChoiceCard(
            icon: AppIconData.key,
            title: l10n.joinChoice,
            detail: l10n.joinChoiceDetail,
            onTap: () =>
                context.push(AppRoute.onboardingJoin.path, extra: firstName),
          ),
        ],
      ),
    );
  }
}
