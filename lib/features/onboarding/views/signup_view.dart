import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/onboarding/controllers/signup_controller.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_note.dart';
import 'package:our_tribe/features/onboarding/views/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_text_field.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Signup step: first name / e-mail / password.
class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupController(),
      child: const _SignupBody(),
    );
  }
}

class _SignupBody extends StatelessWidget {
  const _SignupBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<SignupController>();

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(title: l10n.signupTitle, subtitle: l10n.signupSubtitle),
          AppTextField(
            label: l10n.firstNameLabel,
            placeholder: l10n.firstNamePlaceholder,
            onChanged: controller.setFirstName,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: l10n.emailLabel,
            placeholder: l10n.emailPlaceholder,
            keyboardType: TextInputType.emailAddress,
            onChanged: controller.setEmail,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: l10n.passwordLabel,
            placeholder: l10n.passwordPlaceholder,
            obscureText: true,
            onChanged: controller.setPassword,
          ),
          const SizedBox(height: AppSpacing.xl),
          OnboardingNote(text: l10n.signupNote, icon: AppIconData.heart),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.continueButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: controller.canContinue
            ? () => context.push(
                AppRoute.onboardingChoose.path,
                extra: controller.firstName.trim(),
              )
            : null,
      ),
    );
  }
}
