import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/onboarding/views/create_tribe/create_tribe_controller.dart';
import 'package:our_tribe/features/onboarding/widgets/auth_error_text.dart';
import 'package:our_tribe/features/onboarding/widgets/onboarding_scaffold.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_text_field.dart';
import 'package:our_tribe/shared/widgets/color_swatch_button.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// "New tribe" step: name + signature color.
class CreateTribeView extends StatelessWidget {
  const CreateTribeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateTribeController(
        context.read<TribeService>(),
        context.read<AuthService>(),
      ),
      child: const _CreateTribeBody(),
    );
  }
}

class _CreateTribeBody extends StatelessWidget {
  const _CreateTribeBody();

  Future<void> _submit(BuildContext context) async {
    final created = await context.read<CreateTribeController>().submit();
    if (created && context.mounted) {
      context.push(AppRoute.onboardingInvite.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<CreateTribeController>();

    return OnboardingScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: l10n.createTribeTitle,
            subtitle: l10n.createTribeSubtitle,
          ),
          AppTextField(
            label: l10n.tribeNameLabel,
            placeholder: l10n.tribeNamePlaceholder,
            onChanged: controller.setTribeName,
          ),
          const SizedBox(height: AppSpacing.xl),
          SectionLabel(l10n.tribeColorLabel),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 11,
            runSpacing: 11,
            children: [
              for (final color in AppColors.tribePalette)
                ColorSwatchButton(
                  color: color,
                  isSelected: controller.tribeColor == color,
                  onTap: () => controller.setTribeColor(color),
                ),
            ],
          ),
          AuthErrorText(error: controller.hasError ? AuthError.unknown : null),
        ],
      ),
      footer: PrimaryButton(
        label: l10n.createTribeButton,
        trailingIcon: AppIconData.arrowRight,
        onPressed: controller.canCreate ? () => _submit(context) : null,
      ),
    );
  }
}
