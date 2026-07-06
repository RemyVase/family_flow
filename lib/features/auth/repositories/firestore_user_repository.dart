import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_tribe/features/auth/models/app_user.dart';
import 'package:our_tribe/features/auth/repositories/user_repository.dart';

/// Firestore implementation of [UserRepository].
class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<AppUser> get _users => _firestore
      .collection('users')
      .withConverter<AppUser>(
        fromFirestore: (snap, _) =>
            AppUser.fromJson({...snap.data()!, 'id': snap.id}),
        toFirestore: (user, _) => user.toJson()..remove('id'),
      );

  @override
  Stream<AppUser?> watchUser(String userId) =>
      _users.doc(userId).snapshots().map((snap) => snap.data());

  @override
  Future<void> saveUser(AppUser user) => _users.doc(user.id).set(user);

  @override
  Future<void> setTribeId(String userId, String? tribeId) =>
      // Through the typed reference on purpose: snapshot listeners are
      // keyed by converter type in the fake backend used in tests.
      _users.doc(userId).update({'tribeId': tribeId});
}
