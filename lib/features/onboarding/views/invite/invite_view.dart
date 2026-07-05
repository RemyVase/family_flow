import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/views/invite/widgets/invite_code_card.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_note.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_icon_button.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Arguments of [InviteView], carried through the router.
class InviteViewArgs {
  const InviteViewArgs({required this.firstName, required this.tribeColor});

  final String firstName;
  final Color tribeColor;
}

/// "Invite your tribe" step: shareable invite code.
class InviteView extends StatelessWidget {
  const InviteView({super.key, this.args});

  final InviteViewArgs? args;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = args?.tribeColor ?? AppColors.accent;

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconButton(
            icon: AppIconData.chevronLeft,
            onPressed: () => context.pop(),
          ),
          const SizedBox(height: AppSpacing.cardPadding),
          _TribeCreatedBadge(color: color),
          const SizedBox(height: AppSpacing.cardPadding),
          Text(
            l10n.inviteTitle,
            style: AppTextStyles.screenTitle.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 7),
          Text(l10n.inviteSubtitle, style: AppTextStyles.body),
          const SizedBox(height: 22),
          InviteCodeCard(color: color),
          const SizedBox(height: AppSpacing.cardPadding),
          OnboardingNote(text: l10n.inviteNote),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.continueButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: () => context.push(
          AppRoute.onboardingDone.path,
          extra: args?.firstName ?? '',
        ),
      ),
    );
  }
}

/// "Tribu créée" badge above the title (`.ob-badge`), tinted with the
/// tribe color.
class _TribeCreatedBadge extends StatelessWidget {
  const _TribeCreatedBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.soften(color, 0.16),
        borderRadius: BorderRadius.circular(AppRadii.pointsPill),
      ),
      child: Text(
        l10n.tribeCreatedBadge,
        style: AppTextStyles.kicker.copyWith(
          color: AppColors.deepen(color, 0.2),
          letterSpacing: 0.24,
        ),
      ),
    );
  }
}
