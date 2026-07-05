import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/services/tribe_service.dart';

/// State of the profile screen: which member's color palette is open.
class ProfileController extends ChangeNotifier {
  ProfileController(this._tribeService);

  final TribeService _tribeService;

  String? _editingMemberId;
  String? get editingMemberId => _editingMemberId;

  void toggleEditing(String memberId) {
    _editingMemberId = _editingMemberId == memberId ? null : memberId;
    notifyListeners();
  }

  void setMemberColor(String memberId, Color color) {
    _tribeService.setMemberColor(memberId, color);
    _editingMemberId = null;
    notifyListeners();
  }
}
