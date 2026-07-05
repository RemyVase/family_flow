import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/home/controllers/home_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_icon_button.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/shared/widgets/tribe_mark.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Home header: brand row + greeting on the left, avatar / bell /
/// points pill on the right.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<HomeController>();
    final currentMember = context.watch<TribeService>().currentMember;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const TribeMark(),
                  const SizedBox(width: 7),
                  Text(l10n.appName.toUpperCase(), style: AppTextStyles.brand),
                ],
              ),
              const SizedBox(height: 3),
              Text(l10n.greeting, style: AppTextStyles.greeting),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.soften(currentMember.color, 0.2),
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Text(
            currentMember.initial,
            style: GoogleFonts.figtree(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: currentMember.color,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const AppIconButton(icon: AppIconData.bell, showDot: true),
        const SizedBox(width: AppSpacing.sm),
        PointsBadge(text: '${controller.pointsToday}', large: true),
      ],
    );
  }
}
