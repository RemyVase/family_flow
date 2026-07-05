import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_tribe/features/week/controllers/week_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_icon_button.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Week header: week kicker + selected day title, calendar button.
class WeekHeader extends StatelessWidget {
  const WeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<WeekController>();
    final locale = Localizations.localeOf(context).toString();

    final month = DateFormat.MMMM(locale).format(controller.selectedDate);
    final dayTitle = DateFormat(
      'EEEE d',
      locale,
    ).format(controller.selectedDate);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.weekKicker(controller.weekNumber, month),
                style: AppTextStyles.headerKicker,
              ),
              const SizedBox(height: 3),
              Text(
                toBeginningOfSentenceCase(dayTitle),
                style: AppTextStyles.greeting,
              ),
            ],
          ),
        ),
        const AppIconButton(icon: AppIconData.calendar),
      ],
    );
  }
}
