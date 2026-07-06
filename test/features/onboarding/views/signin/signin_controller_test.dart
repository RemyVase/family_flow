import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/onboarding/views/signin/signin_controller.dart';

import '../../../../helpers/test_stack.dart';

void main() {
  group('SigninController', () {
    test('should require both e-mail and password', () {
      final controller = SigninController(TestStack().authService);

      expect(controller.canSignIn, isFalse);

      controller.setEmail('z@t.be');
      expect(controller.canSignIn, isFalse);

      controller.setPassword('123456');
      expect(controller.canSignIn, isTrue);
    });

    test('should sign the user in', () async {
      final stack = TestStack();
      final controller = SigninController(stack.authService);
      controller.setEmail('z@t.be');
      controller.setPassword('123456');

      final submitted = await controller.submit();
      await pumpEventQueue();

      expect(submitted, isTrue);
      expect(stack.authService.isSignedIn, isTrue);
    });

    test('should expose the auth error on bad credentials', () async {
      final stack = TestStack();
      stack.authRepository.nextError = const AuthException(
        AuthError.invalidCredentials,
      );
      final controller = SigninController(stack.authService);
      controller.setEmail('z@t.be');
      controller.setPassword('nope42');

      final submitted = await controller.submit();

      expect(submitted, isFalse);
      expect(controller.error, AuthError.invalidCredentials);
      expect(stack.authService.isSignedIn, isFalse);
    });
  });
}
