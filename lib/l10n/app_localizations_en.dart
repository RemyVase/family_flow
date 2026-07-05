// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Our Tribe';

  @override
  String get welcomeTagline =>
      'Household chores,\nthe whole tribe in one place.';

  @override
  String get createAccountButton => 'Create my account';

  @override
  String get alreadyHaveAccount => 'I already have an account';

  @override
  String get signupTitle => 'Create an account';

  @override
  String get signupSubtitle => 'Let\'s start with you.';

  @override
  String get firstNameLabel => 'Your first name';

  @override
  String get firstNamePlaceholder => 'E.g. Léa';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailPlaceholder => 'lea@ourtribe.be';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordPlaceholder => 'Choose a password';

  @override
  String get passwordDotsPlaceholder => '••••••••';

  @override
  String get signupNote =>
      'Your first name will appear on your tasks and in the tribe leaderboard.';

  @override
  String get continueButton => 'Continue';

  @override
  String get signinTitle => 'Welcome back';

  @override
  String get signinSubtitle => 'Sign in to your account.';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get signinButton => 'Sign in';

  @override
  String get chooseTitle => 'Your tribe';

  @override
  String get chooseSubtitle => 'Join someone\'s tribe, or create your own.';

  @override
  String get createTribeChoice => 'Create a tribe';

  @override
  String get createTribeChoiceDetail => 'I start and invite the others';

  @override
  String get joinChoice => 'Join with a code';

  @override
  String get joinChoiceDetail => 'Someone shared an invite code with me';

  @override
  String get createTribeTitle => 'New tribe';

  @override
  String get createTribeSubtitle => 'Give it a name and a color.';

  @override
  String get tribeNameLabel => 'Tribe name';

  @override
  String get tribeNamePlaceholder => 'E.g. The Dubois tribe';

  @override
  String get tribeColorLabel => 'Tribe color';

  @override
  String get createTribeButton => 'Create the tribe';

  @override
  String get tribeCreatedBadge => 'Tribe created';

  @override
  String get inviteTitle => 'Invite your tribe';

  @override
  String get inviteSubtitle =>
      'Share this code. Everyone enters it after signing up.';

  @override
  String get inviteCodeLabel => 'Invite code';

  @override
  String get copyButton => 'Copy';

  @override
  String get shareButton => 'Share';

  @override
  String get inviteNote =>
      'You can always find this code again in your profile.';

  @override
  String get joinTitle => 'Join';

  @override
  String get joinSubtitle => 'Enter the code your tribe shared with you.';

  @override
  String pasteCode(String code) {
    return 'Paste \"$code\"';
  }

  @override
  String membersCount(int count) {
    return '$count members';
  }

  @override
  String get joinTribeButton => 'Join the tribe';

  @override
  String doneTitle(String name) {
    return 'Let\'s go, $name';
  }

  @override
  String get doneTagline =>
      'Your tribe is ready.\nYour turn to play, one task at a time.';

  @override
  String get enterAppButton => 'Enter Our Tribe';

  @override
  String get greeting => 'Hey tribe';

  @override
  String tasksDoneCount(int done, int total) {
    return '$done of $total tasks done';
  }

  @override
  String get progressMessageStart => 'Let\'s get going';

  @override
  String get progressMessageKeepGoing => 'Nice momentum, keep going';

  @override
  String progressMessageAlmost(int count) {
    return 'Only $count left, you\'ve got this';
  }

  @override
  String get progressMessageAllDone => 'All done — the tribe delivers';

  @override
  String get pointsLabel => 'points';

  @override
  String plusPoints(int points) {
    return '+$points';
  }

  @override
  String get sectionMorning => 'This morning';

  @override
  String get sectionAfternoon => 'This afternoon';

  @override
  String get sectionEvening => 'Tonight';

  @override
  String sectionCount(int done, int total) {
    return '$done/$total';
  }

  @override
  String get tabHome => 'Home';

  @override
  String get tabWeek => 'Week';

  @override
  String get tabFamily => 'Family';

  @override
  String get tabProfile => 'Profile';

  @override
  String weekKicker(int week, String month) {
    return 'Week $week · $month';
  }

  @override
  String daySummary(int count, int done) {
    return '$count tasks · $done done';
  }

  @override
  String pointsSuffix(int points) {
    return '$points pts';
  }

  @override
  String get nowLabel => 'now';

  @override
  String recapWeekShort(int week) {
    return 'Wk $week';
  }

  @override
  String get segmentSummary => 'Summary';

  @override
  String get segmentTasks => 'Tasks';

  @override
  String get tribeTotal => 'Tribe total';

  @override
  String get vsLastWeek => 'vs last week';

  @override
  String get perPersonTitle => 'This week, per person';

  @override
  String get clanTitle => 'The clan this week';

  @override
  String get clanNote => 'just for fun';

  @override
  String get youSuffix => 'you';

  @override
  String get chiefSuffix => 'chief';

  @override
  String memberTasksDone(int count) {
    return '$count tasks done';
  }

  @override
  String tribeGoal(String name) {
    return 'Tribe goal · $name';
  }

  @override
  String rewardProgress(int points, int goal, int remaining) {
    return '$points / $goal pts — only $remaining to go!';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterTodo => 'To do';

  @override
  String get filterDone => 'Done';

  @override
  String get filterRecurring => 'Recurring';

  @override
  String get groupTodo => 'To do';

  @override
  String get groupDone => 'Done';

  @override
  String get emptyListMessage => 'Nothing here for now';

  @override
  String get editButton => 'Edit';

  @override
  String todayAt(String time) {
    return 'Today · $time';
  }

  @override
  String get todayLabel => 'Today';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get defaultTaskDescription =>
      'Recurring household task. Add details or a photo to help whoever takes care of it.';

  @override
  String get assignedTo => 'Assigned to';

  @override
  String get changeAction => 'change';

  @override
  String get activityLabel => 'Activity';

  @override
  String activityLastWeek(String name, int points) {
    return 'Done last week by $name · +$points';
  }

  @override
  String get markDoneButton => 'Mark as done';

  @override
  String get undoDoneButton => 'Done! Undo';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get newTaskTitle => 'New task';

  @override
  String get taskNameLabel => 'Task name';

  @override
  String get taskNamePlaceholder => 'E.g. Take out the trash';

  @override
  String get optionalSuffix => 'optional';

  @override
  String get descriptionPlaceholder => 'Add details…';

  @override
  String get forWhoLabel => 'For whom';

  @override
  String get meLabel => 'Me';

  @override
  String get pointsSectionLabel => 'Points';

  @override
  String get pointsHint => 'Points reward';

  @override
  String get recurrenceLabel => 'Recurrence';

  @override
  String get recurrenceOnce => 'Once';

  @override
  String get recurrenceDaily => 'Every day';

  @override
  String get recurrenceTwiceDaily => '2×/day';

  @override
  String get recurrenceThriceDaily => '3×/day';

  @override
  String get recurrenceWeekly => '1×/week';

  @override
  String get whenLabel => 'When';

  @override
  String get momentMorning => 'Morning';

  @override
  String get momentAfternoon => 'Afternoon';

  @override
  String get momentEvening => 'Evening';

  @override
  String momentChip(String label, String time) {
    return '$label · $time';
  }

  @override
  String get photosLabel => 'Photos';

  @override
  String get addPhotoButton => 'Add';

  @override
  String get createTaskButton => 'Create the task';

  @override
  String get myAccountKicker => 'My account';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfileButton => 'Edit';

  @override
  String membersLabel(int count) {
    return 'Members · $count';
  }

  @override
  String get manageAction => 'Manage';

  @override
  String get chiefColorHint =>
      'As tribe chief, tap a swatch to change the color';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get notificationsLabel => 'Notifications';

  @override
  String get notificationsEnabled => 'Enabled';

  @override
  String get remindersEntryLabel => 'Recurrences & reminders';

  @override
  String get rewardsEntryLabel => 'Rewards';

  @override
  String rewardsEntryDetail(int count) {
    return '$count goals';
  }

  @override
  String get helpLabel => 'Help';

  @override
  String get logoutButton => 'Sign out';

  @override
  String versionLabel(String version) {
    return 'Our Tribe · v$version';
  }

  @override
  String get rewardsTitle => 'Rewards';

  @override
  String get rewardsSubtitle =>
      'Goals to unlock with points. Zero pressure, all fun.';

  @override
  String get weeklyPotLabel => 'This week\'s pot';

  @override
  String get tribePointsLabel => 'tribe points';

  @override
  String goalsLabel(int count) {
    return 'Goals · $count';
  }

  @override
  String get tribeKind => 'Tribe';

  @override
  String get unlockedLabel => 'Unlocked!';

  @override
  String rewardCardProgress(int points, int goal, int remaining) {
    return '$points / $goal pts · only $remaining to go';
  }

  @override
  String get addRewardButton => 'Add a reward';

  @override
  String get doneButton => 'Done';

  @override
  String get remindersTitle => 'Recurrences & reminders';

  @override
  String get remindersSubtitle =>
      'When and how the app reminds the tribe about tasks.';

  @override
  String get remindersSection => 'Reminders';

  @override
  String get remindTasksLabel => 'Remind about tasks';

  @override
  String get remindTasksDetail => 'A notification before the scheduled time';

  @override
  String get leadTimeLabel => 'Notify before';

  @override
  String get leadOnTime => 'On time';

  @override
  String get leadFifteenMinutes => '15 min';

  @override
  String get leadThirtyMinutes => '30 min';

  @override
  String get leadOneHour => '1 h';

  @override
  String get summariesSection => 'Summaries';

  @override
  String get morningSummaryLabel => 'Morning summary';

  @override
  String get morningSummaryDetail => 'The day\'s tasks at 8:00';

  @override
  String get eveningReminderLabel => 'Evening reminder';

  @override
  String get eveningReminderDetail => 'What\'s left to do at 19:00';

  @override
  String get overdueLabel => 'Overdue tasks';

  @override
  String get overdueDetail => 'Warn when a task is forgotten';

  @override
  String get recurrencesSection => 'Recurrences';

  @override
  String get weekStartLabel => 'Start of week';

  @override
  String get weekStartDetail => 'Day the weekly points reset to zero';

  @override
  String get mondayLabel => 'Monday';

  @override
  String get saturdayLabel => 'Saturday';

  @override
  String get sundayLabel => 'Sunday';

  @override
  String get autoCarryLabel => 'Carry over automatically';

  @override
  String get autoCarryDetail => 'An unfinished task moves to the next day';

  @override
  String get remindersNote =>
      'Each task can also have its own reminders, set when it is created.';

  @override
  String get saveButton => 'Save';
}
