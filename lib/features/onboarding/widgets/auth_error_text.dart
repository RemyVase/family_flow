import 'package:flutter/material.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Localized inline error message under an auth form; renders nothing when
/// there is no error.
class AuthErrorText extends StatelessWidget {
  const AuthErrorText({super.key, required this.error});

  final AuthError? error;

  @override
  Widget build(BuildContext context) {
    final error = this.error;
    if (error == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context)!;

    final message = switch (error) {
      AuthError.emailInUse => l10n.authErrorEmailInUse,
      AuthError.invalidEmail => l10n.authErrorInvalidEmail,
      AuthError.weakPassword => l10n.authErrorWeakPassword,
      AuthError.invalidCredentials => l10n.authErrorInvalidCredentials,
      AuthError.network => l10n.authErrorNetwork,
      AuthError.unknown => l10n.authErrorUnknown,
    };

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Text(
        message,
        style: AppTextStyles.body.copyWith(
          fontSize: 13.5,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
