import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/theme/app_colors.dart';

/// State of the "create a tribe" form. No backend call yet (design-only).
class CreateTribeController extends ChangeNotifier {
  String _tribeName = '';
  String get tribeName => _tribeName;

  Color _tribeColor = AppColors.memberGreen;
  Color get tribeColor => _tribeColor;

  bool get canCreate => _tribeName.trim().isNotEmpty;

  void setTribeName(String value) {
    _tribeName = value;
    notifyListeners();
  }

  void setTribeColor(Color value) {
    _tribeColor = value;
    notifyListeners();
  }
}
