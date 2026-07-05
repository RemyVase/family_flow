import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/l10n/app_localizations.dart';

/// Localized display label for a recurrence.
extension RecurrenceLabel on TaskRecurrence {
  /// Null for one-off tasks (no recurrence meta is shown).
  String? label(AppLocalizations l10n) => switch (this) {
    TaskRecurrence.once => null,
    TaskRecurrence.daily => l10n.recurrenceDaily,
    TaskRecurrence.twiceDaily => l10n.recurrenceTwiceDaily,
    TaskRecurrence.thriceDaily => l10n.recurrenceThriceDaily,
    TaskRecurrence.weekly => l10n.recurrenceWeekly,
  };
}
