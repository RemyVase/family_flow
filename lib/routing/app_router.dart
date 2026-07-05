import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/home/views/home/home_view.dart';
import 'package:our_tribe/features/onboarding/views/choose_tribe/choose_tribe_view.dart';
import 'package:our_tribe/features/onboarding/views/create_tribe/create_tribe_view.dart';
import 'package:our_tribe/features/onboarding/views/invite/invite_view.dart';
import 'package:our_tribe/features/onboarding/views/join_tribe/join_tribe_view.dart';
import 'package:our_tribe/features/onboarding/views/onboarding_done/onboarding_done_view.dart';
import 'package:our_tribe/features/onboarding/views/signin/signin_view.dart';
import 'package:our_tribe/features/onboarding/views/signup/signup_view.dart';
import 'package:our_tribe/features/onboarding/views/welcome/welcome_view.dart';
import 'package:our_tribe/features/profile/views/profile/profile_view.dart';
import 'package:our_tribe/features/profile/views/profile_edit/profile_edit_view.dart';
import 'package:our_tribe/features/recap/views/recap/recap_view.dart';
import 'package:our_tribe/features/settings/views/notifications/notifications_view.dart';
import 'package:our_tribe/features/settings/views/reminders/reminders_view.dart';
import 'package:our_tribe/features/settings/views/rewards/rewards_view.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_view.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/task_detail_view.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/views/unassigned/unassigned_view.dart';
import 'package:our_tribe/features/week/views/week/week_view.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/routing/app_shell.dart';

/// Central router. The app starts on the onboarding flow while there is no
/// auth guard yet; a `redirect` based on the auth state will replace this.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoute.onboardingWelcome.path,
  routes: [
    // Onboarding (pre-sign-in) flow.
    GoRoute(
      path: AppRoute.onboardingWelcome.path,
      name: AppRoute.onboardingWelcome.name,
      builder: (context, state) => const WelcomeView(),
      routes: [
        GoRoute(
          path: 'signup',
          name: AppRoute.onboardingSignup.name,
          builder: (context, state) => const SignupView(),
        ),
        GoRoute(
          path: 'signin',
          name: AppRoute.onboardingSignin.name,
          builder: (context, state) => const SigninView(),
        ),
        GoRoute(
          path: 'choose',
          name: AppRoute.onboardingChoose.name,
          builder: (context, state) =>
              ChooseTribeView(firstName: state.extra as String? ?? ''),
        ),
        GoRoute(
          path: 'create',
          name: AppRoute.onboardingCreateTribe.name,
          builder: (context, state) =>
              CreateTribeView(firstName: state.extra as String? ?? ''),
        ),
        GoRoute(
          path: 'invite',
          name: AppRoute.onboardingInvite.name,
          builder: (context, state) =>
              InviteView(args: state.extra as InviteViewArgs?),
        ),
        GoRoute(
          path: 'join',
          name: AppRoute.onboardingJoin.name,
          builder: (context, state) =>
              JoinTribeView(firstName: state.extra as String? ?? ''),
        ),
        GoRoute(
          path: 'done',
          name: AppRoute.onboardingDone.name,
          builder: (context, state) =>
              OnboardingDoneView(firstName: state.extra as String? ?? ''),
        ),
      ],
    ),

    // Signed-in app: four tabs behind a stateful shell.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.home.path,
              name: AppRoute.home.name,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.week.path,
              name: AppRoute.week.name,
              builder: (context, state) => const WeekView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.family.path,
              name: AppRoute.family.name,
              builder: (context, state) => const RecapView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              name: AppRoute.profile.name,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),

    // Full-screen overlays (no tab bar).
    GoRoute(
      path: AppRoute.taskCreate.path,
      name: AppRoute.taskCreate.name,
      builder: (context, state) => const TaskCreateView(),
    ),
    GoRoute(
      path: AppRoute.taskDetail.path,
      name: AppRoute.taskDetail.name,
      builder: (context, state) => TaskDetailView(task: state.extra! as Task),
    ),
    GoRoute(
      path: AppRoute.tasksUnassigned.path,
      name: AppRoute.tasksUnassigned.name,
      builder: (context, state) => const UnassignedView(),
    ),
    GoRoute(
      path: AppRoute.profileEdit.path,
      name: AppRoute.profileEdit.name,
      builder: (context, state) => const ProfileEditView(),
    ),
    GoRoute(
      path: AppRoute.settingsRewards.path,
      name: AppRoute.settingsRewards.name,
      builder: (context, state) => const RewardsView(),
    ),
    GoRoute(
      path: AppRoute.settingsReminders.path,
      name: AppRoute.settingsReminders.name,
      builder: (context, state) => const RemindersView(),
    ),
    GoRoute(
      path: AppRoute.settingsNotifications.path,
      name: AppRoute.settingsNotifications.name,
      builder: (context, state) => const NotificationsView(),
    ),
  ],
);
