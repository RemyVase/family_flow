import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_stack.dart';

void main() {
  group('AuthService', () {
    test('should be ready and signed out with no user', () async {
      final stack = TestStack();
      await pumpEventQueue();

      expect(stack.authService.isReady, isTrue);
      expect(stack.authService.isSignedIn, isFalse);
      expect(stack.authService.hasTribe, isFalse);
    });

    test('should create the profile document on sign-up', () async {
      final stack = TestStack();

      await stack.authService.signUp(
        firstName: '  Zoé ',
        email: ' zoe@ourtribe.be ',
        password: 'secret6',
      );
      await pumpEventQueue();

      expect(stack.authService.isSignedIn, isTrue);
      expect(stack.authService.firstName, 'Zoé');
      expect(stack.authService.email, 'zoe@ourtribe.be');
      expect(stack.authService.hasTribe, isFalse);
    });

    test('should expose the tribe id from the profile document', () async {
      final stack = await TestStack.signedInWithTribe();

      expect(stack.authService.hasTribe, isTrue);
      expect(stack.authService.tribeId, stack.tribeId);
    });

    test('should clear the user state on sign-out', () async {
      final stack = await TestStack.signedInWithTribe();

      await stack.authService.signOut();
      await pumpEventQueue();

      expect(stack.authService.isSignedIn, isFalse);
      expect(stack.authService.user, isNull);
      expect(stack.authService.hasTribe, isFalse);
    });
  });
}
