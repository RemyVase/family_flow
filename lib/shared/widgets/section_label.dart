import 'package:flutter/material.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Uppercase kicker label above form fields and detail sections
/// (`.cf-label` / `.dt-label`).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.suffix});

  final String text;

  /// Small non-uppercase suffix, e.g. "optionnel".
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text.toUpperCase(),
        style: AppTextStyles.kicker,
        children: [
          if (suffix != null)
            TextSpan(
              text: ' ${suffix!}',
              style: AppTextStyles.kicker.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
                color: AppColors.inkTertiary,
              ),
            ),
        ],
      ),
    );
  }
}
