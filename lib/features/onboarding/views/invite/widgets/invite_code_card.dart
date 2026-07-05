import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Invite code card (`.ob-code-card`): tinted panel with the big code
/// and the copy / share actions.
class InviteCodeCard extends StatelessWidget {
  const InviteCodeCard({super.key, required this.color});

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
