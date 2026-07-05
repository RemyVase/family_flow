import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/services/tribe_service.dart';

/// State of the profile edit screen. The color applies immediately
/// (as everywhere in the tribe); name/e-mail are saved on submit.
class ProfileEditController extends ChangeNotifier {
  ProfileEditController(this._tribeService)
    : _name = _tribeService.currentMember.name;

  final TribeService _tribeService;

  String _name;
  String get name => _name;

  String get initial => _name.trim().isEmpty
      ? _tribeService.currentMember.initial
      : _name.trim()[0].toUpperCase();

  Color get color => _tribeService.currentMember.color;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setColor(Color value) {
    _tribeService.setMemberColor(_tribeService.currentMember.id, value);
    notifyListeners();
  }

  void save() {
    _tribeService.renameCurrentMember(_name);
  }
}
