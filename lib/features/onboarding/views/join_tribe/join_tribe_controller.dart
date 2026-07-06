import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:our_tribe/features/tribe/models/tribe_invite.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// Lookup state of the entered code.
enum JoinLookupStatus { idle, searching, found, notFound }

/// State of the "join with a code" step: code entry, invite lookup and the
/// join itself, through [TribeService].
class JoinTribeController extends ChangeNotifier {
  JoinTribeController(this._tribeService, this._authService);

  static const int codeLength = 6;

  final TribeService _tribeService;
  final AuthService _authService;

  final List<String> _code = List.filled(codeLength, '');
  List<String> get code => List.unmodifiable(_code);

  JoinLookupStatus _status = JoinLookupStatus.idle;
  JoinLookupStatus get status => _status;

  TribeInvite? _invite;
  TribeInvite? get invite => _invite;

  bool _isJoining = false;
  bool get isJoining => _isJoining;

  bool _hasJoinError = false;
  bool get hasJoinError => _hasJoinError;

  int get filledCount => _code.where((c) => c.isNotEmpty).length;

  bool get isComplete => filledCount == codeLength;

  bool get hasFoundTribe => _status == JoinLookupStatus.found;

  bool get canJoin => hasFoundTribe && !_isJoining;

  void setCharacter(int index, String value) {
    if (index < 0 || index >= codeLength) return;
    _code[index] = value.isEmpty
        ? ''
        : value.substring(value.length - 1).toUpperCase();
    notifyListeners();
    _lookupIfComplete();
  }

  /// Fills the boxes from the clipboard when it holds a plausible code.
  Future<void> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final pasted = (data?.text ?? '')
        .replaceAll(RegExp('[^A-Za-z0-9]'), '')
        .toUpperCase();
    if (pasted.length != codeLength) return;
    for (var i = 0; i < codeLength; i++) {
      _code[i] = pasted[i];
    }
    notifyListeners();
    await _lookupIfComplete();
  }

  Future<void> _lookupIfComplete() async {
    if (!isComplete) {
      _status = JoinLookupStatus.idle;
      _invite = null;
      notifyListeners();
      return;
    }
    final lookedUpCode = _code.join();
    _status = JoinLookupStatus.searching;
    notifyListeners();
    try {
      final invite = await _tribeService.findInvite(lookedUpCode);
      // Ignore the result if the boxes changed while the lookup was running.
      if (_code.join() != lookedUpCode) return;
      _invite = invite;
      _status = invite == null
          ? JoinLookupStatus.notFound
          : JoinLookupStatus.found;
      notifyListeners();
    } catch (e, st) {
      _status = JoinLookupStatus.notFound;
      notifyListeners();
      await reportError(e, st);
    }
  }

  /// Joins the found tribe. Returns true on success so the view can move to
  /// the done step.
  Future<bool> join() async {
    final invite = _invite;
    if (invite == null || _isJoining) return false;
    _isJoining = true;
    _hasJoinError = false;
    notifyListeners();
    try {
      await _tribeService.joinTribe(
        invite: invite,
        memberName: _authService.firstName,
      );
      return true;
    } catch (e, st) {
      _hasJoinError = true;
      await reportError(e, st);
      return false;
    } finally {
      _isJoining = false;
      notifyListeners();
    }
  }
}
