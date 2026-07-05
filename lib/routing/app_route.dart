/// Central list of route names and paths — no magic strings in views.
enum AppRoute {
  onboardingWelcome('/onboarding'),
  onboardingSignup('/onboarding/signup'),
  onboardingSignin('/onboarding/signin'),
  onboardingChoose('/onboarding/choose'),
  onboardingCreateTribe('/onboarding/create'),
  onboardingInvite('/onboarding/invite'),
  onboardingJoin('/onboarding/join'),
  onboardingDone('/onboarding/done'),

  home('/home'),
  week('/week'),
  family('/family'),
  profile('/profile'),

  taskCreate('/tasks/create'),
  taskDetail('/tasks/detail'),
  tasksUnassigned('/tasks/unassigned'),

  profileEdit('/profile/edit'),

  settingsRewards('/settings/rewards'),
  settingsReminders('/settings/reminders'),
  settingsNotifications('/settings/notifications');

  const AppRoute(this.path);

  final String path;
}
