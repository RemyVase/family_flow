import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';

/// State of the profile edit screen. The color applies immediately
/// (as everywhere in the tribe); the name is saved on submit.
class ProfileEditController extends ChangeNotifier {
  ProfileEditController(this._tribeService, this._authService)
    : _name = _tribeService.currentMember.name;

  final TribeService _tribeService;
  final AuthService _authService;

  String _name;
  String get name => _name;

  String get email => _authService.email;

  String get initial => _name.trim().isEmpty
      ? _tribeService.currentMember.initial
      : _name.trim()[0].toUpperCase();

  Color get color => _tribeService.currentMember.color;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setColor(Color value) {
    unawaited(
      _tribeService
          .setMemberColor(_tribeService.currentMember.id, value)
          .onError(reportError),
    );
    notifyListeners();
  }

  /// Persists the new name. Returns false on error.
  Future<bool> save() async {
    try {
      await _tribeService.renameCurrentMember(_name);
      return true;
    } catch (e, st) {
      await reportError(e, st);
      return false;
    }
  }
}
