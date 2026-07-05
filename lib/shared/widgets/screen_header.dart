import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_icon_button.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Back button + title (+ optional subtitle) used by onboarding steps and
/// settings sub-screens (`.ob-back` / `.ob-title` / `.ob-sub`).
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppIconButton(
          icon: AppIconData.chevronLeft,
          onPressed: () => context.pop(),
        ),
        const SizedBox(height: AppSpacing.cardPadding),
        Text(title, style: AppTextStyles.screenTitle.copyWith(fontSize: 25)),
        if (subtitle != null) ...[
          const SizedBox(height: 7),
          Text(subtitle!, style: AppTextStyles.body),
        ],
        const SizedBox(height: 22),
      ],
    );
  }
}
