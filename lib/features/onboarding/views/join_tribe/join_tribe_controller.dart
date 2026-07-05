import 'package:flutter/foundation.dart';

/// State of the "join with a code" step. No backend call yet (design-only):
/// any complete code resolves to the demo tribe.
class JoinTribeController extends ChangeNotifier {
  static const int codeLength = 6;

  /// Demo invite code offered by the "paste" shortcut.
  static const String demoCode = '4KP92Q';

  final List<String> _code = List.filled(codeLength, '');
  List<String> get code => List.unmodifiable(_code);

  int get filledCount => _code.where((c) => c.isNotEmpty).length;

  bool get isComplete => filledCount == codeLength;

  /// Demo: a complete code always matches the mock tribe.
  bool get hasFoundTribe => isComplete;

  void setCharacter(int index, String value) {
    if (index < 0 || index >= codeLength) return;
    _code[index] = value.isEmpty
        ? ''
        : value.substring(value.length - 1).toUpperCase();
    notifyListeners();
  }

  void pasteDemoCode() {
    for (var i = 0; i < codeLength; i++) {
      _code[i] = demoCode[i];
    }
    notifyListeners();
  }
}
