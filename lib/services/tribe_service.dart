import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/tribe.dart';
import 'package:our_tribe/features/tribe/models/tribe_invite.dart';
import 'package:our_tribe/features/tribe/repositories/tribe_repository.dart';
import 'package:our_tribe/services/analytics_service.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// App-wide tribe state (the tribe document and its members), streamed from
/// the backend for the tribe the signed-in user belongs to.
///
/// Member colors are the visual signature of the tribe and are read by
/// almost every screen, which is why this lives in a cross-feature service.
class TribeService extends ChangeNotifier {
  TribeService(
    this._tribeRepository,
    this._authService,
    this._analytics, {
    Random? random,
  }) : _random = random ?? Random() {
    _authService.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  static const int inviteCodeLength = 6;

  /// Unambiguous alphabet for invite codes (no 0/O, 1/I/L).
  static const String _codeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

  final TribeRepository _tribeRepository;
  final AuthService _authService;
  final AnalyticsService _analytics;
  final Random _random;

  String? _tribeId;
  String? _userId;
  Tribe? _tribe;
  List<Member> _members = const [];
  StreamSubscription<Tribe?>? _tribeSub;
  StreamSubscription<List<Member>>? _membersSub;

  /// True once the tribe and its members have arrived from the backend.
  bool get isReady => _tribe != null && _members.isNotEmpty;

  List<Member> get members => List.unmodifiable(_members);

  String get tribeName => _tribe?.name ?? '';
  String get inviteCode => _tribe?.inviteCode ?? '';
  Color get tribeColor => _tribe?.color ?? AppColors.accent;

  Member get currentMember => _members.firstWhere((m) => m.isCurrentUser);

  Member memberById(String id) => _members.firstWhere((m) => m.id == id);

  /// Members ranked by weekly points, best first.
  List<Member> get ranking =>
      [..._members]..sort((a, b) => b.weeklyPoints.compareTo(a.weeklyPoints));

  int get weeklyTotalPoints =>
      _members.fold(0, (sum, m) => sum + m.weeklyPoints);

  void _onAuthChanged() {
    final tribeId = _authService.tribeId;
    final userId = _authService.userId;
    // The user id matters too: isCurrentUser is derived from it, so an
    // account switch within the same tribe must remap the members.
    if (tribeId == _tribeId && userId == _userId) return;
    _tribeId = tribeId;
    _userId = userId;
    _tribeSub?.cancel();
    _membersSub?.cancel();
    _tribe = null;
    _members = const [];
    if (tribeId != null) {
      _tribeSub = _tribeRepository.watchTribe(tribeId).listen((tribe) {
        _tribe = tribe;
        notifyListeners();
      }, onError: reportError);
      _membersSub = _tribeRepository.watchMembers(tribeId).listen((members) {
        _members = [
          for (final member in members)
            member.copyWith(isCurrentUser: member.id == _authService.userId),
        ];
        final me = _members.where((m) => m.isCurrentUser).firstOrNull;
        if (me != null) {
          _analytics.setTribeContext(
            isChief: me.isChief,
            memberCount: _members.length,
          );
        }
        notifyListeners();
      }, onError: reportError);
    }
    notifyListeners();
  }

  /// Creates a tribe with the signed-in user as its chief, then records it
  /// on their profile (which starts the streams above).
  Future<void> createTribe({
    required String name,
    required Color color,
    required String memberName,
  }) async {
    final userId = _authService.userId!;
    final tribeId = await _tribeRepository.createTribe(
      tribe: Tribe(
        id: '',
        name: name.trim(),
        ownerId: userId,
        inviteCode: _generateInviteCode(),
        color: color,
      ),
      founder: Member(
        id: userId,
        name: memberName.trim(),
        color: AppColors.memberPalette.first,
        isChief: true,
      ),
    );
    await _authService.setTribeId(tribeId);
    _analytics.logTribeCreated();
  }

  /// Resolves an invite code; null when it does not exist.
  Future<TribeInvite?> findInvite(String code) =>
      _tribeRepository.fetchInvite(code.trim().toUpperCase());

  /// Joins the tribe behind [invite] as a regular member.
  Future<void> joinTribe({
    required TribeInvite invite,
    required String memberName,
  }) async {
    const palette = AppColors.memberPalette;
    await _tribeRepository.joinTribe(
      invite: invite,
      member: Member(
        id: _authService.userId!,
        name: memberName.trim(),
        color: palette[invite.memberCount % palette.length],
      ),
    );
    await _authService.setTribeId(invite.tribeId);
    _analytics.logTribeJoined();
    // Best-effort denormalization; the join itself already succeeded.
    await _tribeRepository.updateInviteMemberCount(
      invite.id,
      invite.memberCount + 1,
    );
  }

  /// Leaves the tribe; the chief hands over to [newChiefId] first, and the
  /// last member deletes the tribe entirely.
  Future<void> leaveTribe({String? newChiefId}) async {
    final tribe = _tribe;
    final me = currentMember;
    if (tribe == null) return;
    final isLastMember = _members.length == 1;
    if (isLastMember) {
      await _tribeRepository.deleteTribe(tribe: tribe, memberId: me.id);
    } else {
      if (me.isChief && newChiefId != null) {
        await _tribeRepository.saveMember(
          tribe.id,
          memberById(newChiefId).copyWith(isChief: true),
        );
      }
      await _tribeRepository.removeMember(tribe.id, me.id);
      await _tribeRepository.updateInviteMemberCount(
        tribe.inviteCode,
        _members.length - 1,
      );
    }
    await _authService.setTribeId(null);
    _analytics.logTribeLeft(tribeDeleted: isLastMember);
  }

  /// Changes a member's signature color (chief-only action in the UI).
  Future<void> setMemberColor(String memberId, Color color) {
    final index = _members.indexWhere((m) => m.id == memberId);
    if (index == -1) return Future.value();
    _members = [..._members];
    _members[index] = _members[index].copyWith(color: color);
    notifyListeners();
    _analytics.logMemberColorChanged();
    return _tribeRepository.saveMember(_tribeId!, _members[index]);
  }

  /// Removes a member from the tribe (chief-only; never the current user).
  Future<void> removeMember(String memberId) {
    final member = _members.where((m) => m.id == memberId).firstOrNull;
    if (member == null || member.isCurrentUser) return Future.value();
    _analytics.logMemberRemoved();
    return _tribeRepository.removeMember(_tribeId!, memberId);
  }

  /// Renames the signed-in member (profile edit).
  Future<void> renameCurrentMember(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return Future.value();
    _analytics.logMemberRenamed();
    return _tribeRepository.saveMember(
      _tribeId!,
      currentMember.copyWith(name: trimmed),
    );
  }

  /// Adjusts a member's weekly counters when a task is (un)done.
  Future<void> addPoints(String memberId, {required int points}) {
    final member = _members.where((m) => m.id == memberId).firstOrNull;
    if (member == null) return Future.value();
    return _tribeRepository.saveMember(
      _tribeId!,
      member.copyWith(
        weeklyPoints: member.weeklyPoints + points,
        weeklyTasksDone: member.weeklyTasksDone + (points >= 0 ? 1 : -1),
      ),
    );
  }

  String _generateInviteCode() => String.fromCharCodes(
    List.generate(
      inviteCodeLength,
      (_) => _codeAlphabet.codeUnitAt(_random.nextInt(_codeAlphabet.length)),
    ),
  );

  @override
  void dispose() {
    _authService.removeListener(_onAuthChanged);
    _tribeSub?.cancel();
    _membersSub?.cancel();
    super.dispose();
  }
}
