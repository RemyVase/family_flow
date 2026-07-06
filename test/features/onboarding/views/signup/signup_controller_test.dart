import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/onboarding/views/signup/signup_controller.dart';

import '../../../../helpers/test_stack.dart';

void main() {
  group('SignupController', () {
    test('should require name, e-mail and a long-enough password', () {
      final controller = SignupController(TestStack().authService);

      expect(controller.canContinue, isFalse);

      controller.setFirstName('Zoé');
      controller.setEmail('z@t.be');
      controller.setPassword('12345');
      expect(controller.canContinue, isFalse);

      controller.setPassword('123456');
      expect(controller.canContinue, isTrue);
    });

    test('should sign the user up and leave no error', () async {
      final stack = TestStack();
      final controller = SignupController(stack.authService);
      controller.setFirstName('Zoé');
      controller.setEmail('z@t.be');
      controller.setPassword('123456');

      final submitted = await controller.submit();
      await pumpEventQueue();

      expect(submitted, isTrue);
      expect(controller.error, isNull);
      expect(stack.authService.isSignedIn, isTrue);
      expect(stack.authService.firstName, 'Zoé');
    });

    test('should expose the auth error when the backend refuses', () async {
      final stack = TestStack();
      stack.authRepository.nextError = const AuthException(
        AuthError.emailInUse,
      );
      final controller = SignupController(stack.authService);
      controller.setFirstName('Zoé');
      controller.setEmail('z@t.be');
      controller.setPassword('123456');

      final submitted = await controller.submit();

      expect(submitted, isFalse);
      expect(controller.error, AuthError.emailInUse);
      expect(controller.isSubmitting, isFalse);
    });
  });
}
