import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/onboarding/controllers/join_tribe_controller.dart';

void main() {
  group('JoinTribeController', () {
    test('should report completion only when all six characters are set', () {
      final controller = JoinTribeController();

      expect(controller.isComplete, isFalse);
      expect(controller.hasFoundTribe, isFalse);

      for (var i = 0; i < JoinTribeController.codeLength; i++) {
        controller.setCharacter(i, 'a');
      }

      expect(controller.isComplete, isTrue);
      expect(controller.hasFoundTribe, isTrue);
    });

    test('should uppercase and keep only the last typed character', () {
      final controller = JoinTribeController();

      controller.setCharacter(0, 'kp');

      expect(controller.code[0], 'P');
    });

    test('should ignore out-of-range indexes', () {
      final controller = JoinTribeController();

      controller.setCharacter(-1, 'a');
      controller.setCharacter(6, 'a');

      expect(controller.filledCount, 0);
    });

    test('should fill the whole code when pasting the demo code', () {
      final controller = JoinTribeController();

      controller.pasteDemoCode();

      expect(controller.code.join(), JoinTribeController.demoCode);
      expect(controller.isComplete, isTrue);
    });
  });
}
