import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/utils/error_reporter.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// State of the "create a tribe" form; creation goes through [TribeService].
class CreateTribeController extends ChangeNotifier {
  CreateTribeController(this._tribeService, this._authService);

  final TribeService _tribeService;
  final AuthService _authService;

  String _tribeName = '';
  String get tribeName => _tribeName;

  Color _tribeColor = AppColors.memberGreen;
  Color get tribeColor => _tribeColor;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  bool _hasError = false;
  bool get hasError => _hasError;

  bool get canCreate => !_isSubmitting && _tribeName.trim().isNotEmpty;

  void setTribeName(String value) {
    _tribeName = value;
    notifyListeners();
  }

  void setTribeColor(Color value) {
    _tribeColor = value;
    notifyListeners();
  }

  /// Creates the tribe with the signed-in user as chief. Returns true on
  /// success so the view can move to the invite step.
  Future<bool> submit() async {
    if (!canCreate) return false;
    _isSubmitting = true;
    _hasError = false;
    notifyListeners();
    try {
      await _tribeService.createTribe(
        name: _tribeName,
        color: _tribeColor,
        memberName: _authService.firstName,
      );
      return true;
    } catch (e, st) {
      _hasError = true;
      await reportError(e, st);
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
