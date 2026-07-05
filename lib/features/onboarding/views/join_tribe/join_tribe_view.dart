import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/join_tribe_controller.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/widgets/join_code_boxes.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/widgets/tribe_found_card.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Join" step: 6-character invite code entry.
class JoinTribeView extends StatelessWidget {
  const JoinTribeView({super.key, required this.firstName});

  final String firstName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JoinTribeController(),
      child: _JoinTribeBody(firstName: firstName),
    );
  }
}

class _JoinTribeBody extends StatelessWidget {
  const _JoinTribeBody({required this.firstName});

  final String firstName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<JoinTribeController>();

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(title: l10n.joinTitle, subtitle: l10n.joinSubtitle),
          const JoinCodeBoxes(),
          const SizedBox(height: AppSpacing.xxs),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(AppSpacing.sm),
            ),
            onPressed: controller.pasteDemoCode,
            child: Text(
              l10n.pasteCode(MockMembers.inviteCode),
              style: AppTextStyles.action.copyWith(fontSize: 14),
            ),
          ),
          if (controller.hasFoundTribe) ...[
            const SizedBox(height: AppSpacing.md),
            const TribeFoundCard(),
          ],
        ],
      ),
      footer: PrimaryButton(
        label: l10n.joinTribeButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: controller.isComplete
            ? () => context.push(AppRoute.onboardingDone.path, extra: firstName)
            : null,
      ),
    );
  }
}
