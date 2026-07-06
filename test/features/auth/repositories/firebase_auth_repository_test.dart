import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:our_tribe/features/auth/models/auth_exception.dart';
import 'package:our_tribe/features/auth/repositories/firebase_auth_repository.dart';

void main() {
  group('FirebaseAuthRepository', () {
    test('should return the new user id on sign-up', () async {
      final repository = FirebaseAuthRepository(MockFirebaseAuth());

      final userId = await repository.signUp(
        email: 'z@t.be',
        password: '123456',
      );

      expect(userId, isNotEmpty);
      expect(repository.currentUserId, userId);
    });

    test('should sign in and out, updating the user stream', () async {
      final auth = MockFirebaseAuth();
      final repository = FirebaseAuthRepository(auth);

      final userId = await repository.signIn(
        email: 'z@t.be',
        password: '123456',
      );
      expect(repository.currentUserId, userId);

      await repository.signOut();
      expect(repository.currentUserId, isNull);
    });

    test('should map backend failures to the typed AuthException', () async {
      final auth = MockFirebaseAuth();
      whenCalling(
        Invocation.method(#signInWithEmailAndPassword, null),
      ).on(auth).thenThrow(FirebaseAuthException(code: 'wrong-password'));
      final repository = FirebaseAuthRepository(auth);

      await expectLater(
        repository.signIn(email: 'z@t.be', password: 'bad'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.error,
            'error',
            AuthError.invalidCredentials,
          ),
        ),
      );
    });
  });
}
