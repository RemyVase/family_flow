import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/notification_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// State of the profile screen: member list interactions (color palette,
/// removal), the current user's role, sign-out and leaving the tribe.
class ProfileController extends ChangeNotifier {
  ProfileController(
    this._tribeService,
    this._authService,
    this._notificationService,
  );

  final TribeService _tribeService;
  final AuthService _authService;
  final NotificationService _notificationService;

  String? _editingMemberId;
  String? get editingMemberId => _editingMemberId;

  bool get isChief => _tribeService.currentMember.isChief;

  /// The chief edits anyone's color; a member only their own.
  bool canEditColor(String memberId) =>
      isChief || _tribeService.currentMember.id == memberId;

  /// The chief can remove anyone but themselves.
  bool canRemove(String memberId) =>
      isChief && _tribeService.currentMember.id != memberId;

  void toggleEditing(String memberId) {
    _editingMemberId = _editingMemberId == memberId ? null : memberId;
    notifyListeners();
  }

  void setMemberColor(String memberId, Color color) {
    _editingMemberId = null;
    notifyListeners();
    unawaited(
      _tribeService.setMemberColor(memberId, color).onError(reportError),
    );
  }

  void removeMember(String memberId) {
    notifyListeners();
    unawaited(_tribeService.removeMember(memberId).onError(reportError));
  }

  /// Leaves the tribe (the chief hands over to [newChiefId] first). The
  /// router's auth guard then returns to onboarding. Returns false on error.
  Future<bool> leaveTribe({String? newChiefId}) async {
    try {
      await _tribeService.leaveTribe(newChiefId: newChiefId);
      return true;
    } catch (e, st) {
      await reportError(e, st);
      return false;
    }
  }

  /// Signs out; the router's auth guard returns to onboarding. The device
  /// push token is detached first, while the user can still write to
  /// their profile.
  void signOut() {
    unawaited(
      _notificationService
          .unregisterToken()
          .then((_) => _authService.signOut())
          .onError(reportError),
    );
  }
}
