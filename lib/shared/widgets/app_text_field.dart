import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Labelled form field of the design (`.cf-label` + `.cf-input`).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.placeholder,
    this.isOptional = false,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final bool isOptional;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label, suffix: isOptional ? l10n.optionalSuffix : null),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          autofocus: autofocus,
          style: AppTextStyles.input,
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: AppTextStyles.input.copyWith(
              color: AppColors.inkTertiary,
            ),
            filled: true,
            fillColor: AppColors.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.cardPadding,
              vertical: AppSpacing.md,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.input),
              borderSide: const BorderSide(color: AppColors.line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadii.input),
              borderSide: const BorderSide(color: AppColors.accent),
            ),
          ),
        ),
      ],
    );
  }
}
