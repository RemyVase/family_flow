import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_note.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
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
          _TribeCreatedBadge(label: l10n.tribeCreatedBadge, color: color),
          const SizedBox(height: AppSpacing.cardPadding),
          Text(
            l10n.inviteTitle,
            style: AppTextStyles.screenTitle.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 7),
          Text(l10n.inviteSubtitle, style: AppTextStyles.body),
          const SizedBox(height: 22),
          _InviteCodeCard(color: color),
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

class _TribeCreatedBadge extends StatelessWidget {
  const _TribeCreatedBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
        label,
        style: AppTextStyles.kicker.copyWith(
          color: AppColors.deepen(color, 0.2),
          letterSpacing: 0.24,
        ),
      ),
    );
  }
}

class _InviteCodeCard extends StatelessWidget {
  const _InviteCodeCard({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.soften(color, 0.09),
        border: Border.all(color: AppColors.soften(color, 0.24)),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: Column(
        children: [
          Text(
            l10n.inviteCodeLabel.toUpperCase(),
            style: AppTextStyles.kicker.copyWith(fontSize: 11),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            MockMembers.inviteCode,
            style: GoogleFonts.figtree(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              letterSpacing: 5,
              color: AppColors.deepen(color, 0.32),
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _CodeActionButton(
                  icon: AppIconData.copy,
                  label: l10n.copyButton,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CodeActionButton(
                  icon: AppIconData.share,
                  label: l10n.shareButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeActionButton extends StatelessWidget {
  const _CodeActionButton({required this.icon, required this.label});

  final AppIconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(icon, size: 16, color: AppColors.ink),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.action.copyWith(
              fontSize: 14,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
