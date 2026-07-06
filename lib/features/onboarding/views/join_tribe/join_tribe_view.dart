import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/join_tribe_controller.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/widgets/join_code_boxes.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/widgets/tribe_found_card.dart';
import 'package:our_tribe/features/onboarding/widgets/auth_error_text.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Join" step: 6-character invite code entry.
class JoinTribeView extends StatelessWidget {
  const JoinTribeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JoinTribeController(
        context.read<TribeService>(),
        context.read<AuthService>(),
      ),
      child: const _JoinTribeBody(),
    );
  }
}

class _JoinTribeBody extends StatelessWidget {
  const _JoinTribeBody();

  Future<void> _join(BuildContext context) async {
    final joined = await context.read<JoinTribeController>().join();
    if (joined && context.mounted) {
      context.push(AppRoute.onboardingDone.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<JoinTribeController>();
    final invite = controller.invite;

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
            onPressed: controller.pasteFromClipboard,
            child: Text(
              l10n.pasteFromClipboard,
              style: AppTextStyles.action.copyWith(fontSize: 14),
            ),
          ),
          if (controller.hasFoundTribe && invite != null) ...[
            const SizedBox(height: AppSpacing.md),
            TribeFoundCard(invite: invite),
          ] else if (controller.status == JoinLookupStatus.notFound) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.joinCodeNotFound,
              style: AppTextStyles.body.copyWith(
                fontSize: 13.5,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
          AuthErrorText(
            error: controller.hasJoinError ? AuthError.unknown : null,
          ),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.joinTribeButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: controller.canJoin ? () => _join(context) : null,
      ),
    );
  }
}
