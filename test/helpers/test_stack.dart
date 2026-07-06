import 'dart:async';
import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/auth/repositories/auth_repository.dart';
import 'package:our_tribe/features/auth/repositories/firestore_user_repository.dart';
import 'package:our_tribe/features/notifications/repositories/firestore_notification_prefs_repository.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/repositories/firestore_task_repository.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/tribe.dart';
import 'package:our_tribe/features/tribe/repositories/firestore_tribe_repository.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/notification_service.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// In-memory [AuthRepository] driving the auth state in tests.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({String? userId}) : _userId = userId;

  final StreamController<String?> _controller =
      StreamController<String?>.broadcast();

  String? _userId;

  /// When set, the next signUp/signIn throws it (then resets).
  AuthException? nextError;

  @override
  String? get currentUserId => _userId;

  @override
  Stream<String?> watchUserId() async* {
    yield _userId;
    yield* _controller.stream;
  }

  void setUser(String? userId) {
    _userId = userId;
    _controller.add(userId);
  }

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    _throwIfRequested();
    setUser('new-user');
    return 'new-user';
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    _throwIfRequested();
    setUser('signed-in-user');
    return 'signed-in-user';
  }

  @override
  Future<void> signOut() async => setUser(null);

  void _throwIfRequested() {
    final error = nextError;
    if (error == null) return;
    nextError = null;
    throw error;
  }
}

/// In-memory [PushMessagingRepository] with scriptable permission/token.
class FakePushMessagingRepository implements PushMessagingRepository {
  PushPermissionStatus status = PushPermissionStatus.notRequested;

  /// What the system prompt will answer.
  PushPermissionStatus promptAnswer = PushPermissionStatus.granted;

  String? token = 'device-token-1';

  final StreamController<String> _refreshController =
      StreamController<String>.broadcast();

  @override
  Future<PushPermissionStatus> getPermissionStatus() async => status;

  @override
  Future<PushPermissionStatus> requestPermission() async {
    if (status == PushPermissionStatus.notRequested) status = promptAnswer;
    return status;
  }

  @override
  Future<String?> getToken() async => token;

  @override
  Stream<String> watchTokenRefresh() => _refreshController.stream;

  void rotateToken(String newToken) {
    token = newToken;
    _refreshController.add(newToken);
  }
}

/// Demo members shared by the suites (first one is the signed-in chief).
const testMembers = [
  Member(
    id: 'lea',
    name: 'Léa',
    color: AppColors.memberTerracotta,
    isChief: true,
    weeklyPoints: 26,
    weeklyTasksDone: 11,
  ),
  Member(
    id: 'tom',
    name: 'Tom',
    color: AppColors.memberPurple,
    weeklyPoints: 30,
    weeklyTasksDone: 9,
  ),
];

const testInviteCode = 'ABC234';

/// The full service stack over in-memory backends, wired exactly like
/// `app.dart`. Keeps controller/service tests free of Firebase.
class TestStack {
  TestStack({String? userId, FakeFirebaseFirestore? firestore})
    : firestore = firestore ?? FakeFirebaseFirestore(),
      authRepository = FakeAuthRepository(userId: userId) {
    userRepository = FirestoreUserRepository(this.firestore);
    tribeRepository = FirestoreTribeRepository(this.firestore);
    taskRepository = FirestoreTaskRepository(this.firestore);
    prefsRepository = FirestoreNotificationPrefsRepository(this.firestore);
    authService = AuthService(authRepository, userRepository);
    tribeService = TribeService(
      tribeRepository,
      authService,
      random: Random(7),
    );
    taskService = TaskService(taskRepository, tribeService, authService);
    notificationService = NotificationService(
      pushRepository,
      prefsRepository,
      userRepository,
      authService,
    );
  }

  final FakeFirebaseFirestore firestore;
  final FakeAuthRepository authRepository;
  final FakePushMessagingRepository pushRepository =
      FakePushMessagingRepository();
  late final FirestoreUserRepository userRepository;
  late final FirestoreTribeRepository tribeRepository;
  late final FirestoreTaskRepository taskRepository;
  late final FirestoreNotificationPrefsRepository prefsRepository;
  late final AuthService authService;
  late final TribeService tribeService;
  late final TaskService taskService;
  late final NotificationService notificationService;

  String? tribeId;

  /// Builds a stack where [members].first is signed in and the tribe exists
  /// with the given [tasks] (seeded with their own ids, so they stay
  /// addressable from the tests).
  static Future<TestStack> signedInWithTribe({
    List<Member> members = testMembers,
    List<Task> tasks = const [],
  }) async {
    final chief = members.first;
    final stack = TestStack(userId: chief.id);
    await stack.userRepository.saveUser(
      AppUser(id: chief.id, firstName: chief.name, email: 'lea@ourtribe.be'),
    );
    final tribeId = await stack.tribeRepository.createTribe(
      tribe: Tribe(
        id: '',
        name: 'La tribu test',
        ownerId: chief.id,
        inviteCode: testInviteCode,
        color: AppColors.memberGreen,
      ),
      founder: chief,
    );
    for (final member in members.skip(1)) {
      await stack.tribeRepository.saveMember(tribeId, member);
    }
    for (final task in tasks) {
      await stack.taskRepository.saveTask(tribeId, task);
    }
    await stack.userRepository.setTribeId(chief.id, tribeId);
    stack.tribeId = tribeId;
    await pumpEventQueue();
    return stack;
  }
}
