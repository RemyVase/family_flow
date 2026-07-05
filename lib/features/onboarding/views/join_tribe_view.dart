import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/onboarding/controllers/join_tribe_controller.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
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
          const _CodeBoxesRow(),
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
            const _TribeFoundCard(),
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

class _CodeBoxesRow extends StatelessWidget {
  const _CodeBoxesRow();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JoinTribeController>();

    return Row(
      children: [
        for (var i = 0; i < JoinTribeController.codeLength; i++) ...[
          if (i > 0) const SizedBox(width: 9),
          Expanded(
            child: _CodeBox(index: i, value: controller.code[i]),
          ),
        ],
      ],
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.index, required this.value});

  final int index;
  final String value;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<JoinTribeController>();
    final isFilled = value.isNotEmpty;

    return SizedBox(
      height: 56,
      child: TextField(
        onChanged: (text) {
          controller.setCharacter(index, text);
          if (text.isNotEmpty) FocusScope.of(context).nextFocus();
        },
        textAlign: TextAlign.center,
        maxLines: 1,
        style: GoogleFonts.figtree(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isFilled ? Colors.white : AppColors.surface,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.segmented),
            borderSide: BorderSide(
              color: isFilled ? AppColors.accent : AppColors.line,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.segmented),
            borderSide: const BorderSide(color: AppColors.accent),
          ),
        ),
      ),
    );
  }
}

class _TribeFoundCard extends StatelessWidget {
  const _TribeFoundCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.soften(AppColors.accent, 0.08),
        border: Border.all(color: AppColors.soften(AppColors.accent, 0.3)),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Text(
              MockMembers.tribeName.split(' ').last[0],
              style: GoogleFonts.figtree(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MockMembers.tribeName,
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                ),
                Text(
                  l10n.membersCount(MockMembers.members.length),
                  style: AppTextStyles.note.copyWith(
                    color: AppColors.inkTertiary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: const AppIcon(
              AppIconData.check,
              size: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
