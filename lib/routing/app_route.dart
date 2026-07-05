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

  settingsRewards('/settings/rewards'),
  settingsReminders('/settings/reminders');

  const AppRoute(this.path);

  final String path;
}
