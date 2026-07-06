import 'package:flutter/material.dart';
import 'package:our_tribe/features/onboarding/views/signin/signin_controller.dart';
import 'package:our_tribe/features/onboarding/widgets/auth_error_text.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_text_field.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Sign-in step: e-mail / password.
class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SigninController(context.read<AuthService>()),
      child: const _SigninBody(),
    );
  }
}

class _SigninBody extends StatelessWidget {
  const _SigninBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<SigninController>();

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(title: l10n.signinTitle, subtitle: l10n.signinSubtitle),
          AppTextField(
            label: l10n.emailLabel,
            placeholder: l10n.emailPlaceholder,
            keyboardType: TextInputType.emailAddress,
            onChanged: controller.setEmail,
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: l10n.passwordLabel,
            placeholder: l10n.passwordDotsPlaceholder,
            obscureText: true,
            onChanged: controller.setPassword,
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {
              // Password recovery will come with the auth feature.
            },
            child: Text(
              l10n.forgotPassword,
              style: AppTextStyles.action.copyWith(fontSize: 14),
            ),
          ),
          AuthErrorText(error: controller.error),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.signinButton,
        trailingIcon: AppIconData.arrowRight,
        // On success the router's auth guard moves into the app.
        onPressed: controller.canSignIn ? controller.submit : null,
      ),
    );
  }
}
