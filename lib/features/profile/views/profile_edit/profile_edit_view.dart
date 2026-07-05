import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/profile/views/profile_edit/profile_edit_controller.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_text_field.dart';
import 'package:our_tribe/shared/widgets/color_swatch_button.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Profile edit screen: avatar preview, first name, e-mail, my color,
/// security.
class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileEditController(context.read<TribeService>()),
      child: const _ProfileEditBody(),
    );
  }
}

class _ProfileEditBody extends StatefulWidget {
  const _ProfileEditBody();

  @override
  State<_ProfileEditBody> createState() => _ProfileEditBodyState();
}

class _ProfileEditBodyState extends State<_ProfileEditBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<ProfileEditController>().name,
    );
    _emailController = TextEditingController(
      text: MockMembers.currentUserEmail,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<ProfileEditController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TribeBackground(
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.stickyActionClearance,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      title: l10n.editProfileTitle,
                      subtitle: l10n.editProfileSubtitle,
                    ),
                    const _AvatarPreview(),
                    const SizedBox(height: 22),
                    AppTextField(
                      label: l10n.firstNameSimpleLabel,
                      controller: _nameController,
                      onChanged: controller.setName,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      label: l10n.emailLabel,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.myColorLabel),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: 11,
                      runSpacing: 11,
                      children: [
                        for (final color in AppColors.tribePalette)
                          ColorSwatchButton(
                            color: color,
                            isSelected: controller.color == color,
                            onTap: () => controller.setColor(color),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.securityLabel),
                    const SizedBox(height: AppSpacing.sm),
                    const _ChangePasswordRow(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyActionBar(
                child: PrimaryButton(
                  label: l10n.saveButton,
                  trailingIcon: AppIconData.check,
                  onPressed: () {
                    controller.save();
                    context.pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Live avatar preview + "change photo" button (`.pe-avatar`).
class _AvatarPreview extends StatelessWidget {
  const _AvatarPreview();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<ProfileEditController>();

    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.color,
            shape: BoxShape.circle,
          ),
          child: Text(
            controller.initial,
            style: GoogleFonts.figtree(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.cardPadding),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            children: [
              const AppIcon(AppIconData.camera, size: 15, color: AppColors.ink),
              const SizedBox(width: AppSpacing.xs),
              Text(
                l10n.changePhotoButton,
                style: AppTextStyles.action.copyWith(
                  fontSize: 13.5,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Change password" row of the security section.
class _ChangePasswordRow extends StatelessWidget {
  const _ChangePasswordRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lineLight,
              borderRadius: BorderRadius.circular(AppRadii.chip),
            ),
            child: const AppIcon(AppIconData.key, size: 18),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.changePasswordLabel,
              style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
            ),
          ),
          const AppIcon(
            AppIconData.chevronRight,
            size: 16,
            color: AppColors.inkTertiary,
          ),
        ],
      ),
    );
  }
}
