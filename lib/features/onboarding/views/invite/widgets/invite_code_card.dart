import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/utils/invite_code_format.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Invite code card (`.ob-code-card`): tinted panel with the big code
/// and the copy / share actions.
///
/// "Copy" puts the bare code in the clipboard; "share" copies a ready-to-send
/// invitation message (a native share sheet may replace it later).
class InviteCodeCard extends StatefulWidget {
  const InviteCodeCard({super.key, required this.color});

  final Color color;

  @override
  State<InviteCodeCard> createState() => _InviteCodeCardState();
}

class _InviteCodeCardState extends State<InviteCodeCard> {
  bool _isCopied = false;

  Future<void> _copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    setState(() => _isCopied = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final inviteCode = context.watch<TribeService>().inviteCode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.soften(widget.color, 0.09),
        border: Border.all(color: AppColors.soften(widget.color, 0.24)),
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
            formatInviteCode(inviteCode),
            style: GoogleFonts.figtree(
              fontSize: 38,
              fontWeight: FontWeight.w800,
              letterSpacing: 5,
              color: AppColors.deepen(widget.color, 0.32),
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _CodeActionButton(
                  icon: _isCopied ? AppIconData.check : AppIconData.copy,
                  label: _isCopied ? l10n.copiedButton : l10n.copyButton,
                  onTap: () => _copy(inviteCode),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CodeActionButton(
                  icon: AppIconData.share,
                  label: l10n.shareButton,
                  onTap: () => _copy(l10n.inviteShareMessage(inviteCode)),
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
  const _CodeActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final AppIconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
