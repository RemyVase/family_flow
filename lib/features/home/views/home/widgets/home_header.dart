import 'package:flutter/material.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/shared/widgets/tribe_mark.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Home header: brand row + greeting on the left, points pill on the right.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<HomeController>();

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
        PointsBadge(text: '${controller.pointsToday}', large: true),
      ],
    );
  }
}
