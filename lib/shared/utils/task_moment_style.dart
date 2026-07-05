import 'dart:ui';

import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// Display mapping of a task moment: tint, icon and localized titles.
extension TaskMomentStyle on TaskMoment {
  Color get color => switch (this) {
    TaskMoment.morning => AppColors.sun,
    TaskMoment.afternoon => AppColors.sky,
    TaskMoment.evening => AppColors.dusk,
  };

  Color get softColor => switch (this) {
    TaskMoment.morning => AppColors.sunSoft,
    TaskMoment.afternoon => AppColors.skySoft,
    TaskMoment.evening => AppColors.duskSoft,
  };

  AppIconData get icon => switch (this) {
    TaskMoment.morning => AppIconData.sun,
    TaskMoment.afternoon => AppIconData.cloud,
    TaskMoment.evening => AppIconData.moon,
  };

  /// Home section title ("Ce matin", …).
  String sectionTitle(AppLocalizations l10n) => switch (this) {
    TaskMoment.morning => l10n.sectionMorning,
    TaskMoment.afternoon => l10n.sectionAfternoon,
    TaskMoment.evening => l10n.sectionEvening,
  };

  /// Short label used by the create form chips ("Matin", …).
  String shortLabel(AppLocalizations l10n) => switch (this) {
    TaskMoment.morning => l10n.momentMorning,
    TaskMoment.afternoon => l10n.momentAfternoon,
    TaskMoment.evening => l10n.momentEvening,
  };

  /// Default time suggested by the create form.
  String get defaultTime => switch (this) {
    TaskMoment.morning => '8:00',
    TaskMoment.afternoon => '17:00',
    TaskMoment.evening => '19:00',
  };
}
