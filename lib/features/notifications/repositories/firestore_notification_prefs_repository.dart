import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_tribe/features/notifications/models/notification_prefs.dart';
import 'package:our_tribe/features/notifications/repositories/notification_prefs_repository.dart';

/// Firestore implementation of [NotificationPrefsRepository].
class FirestoreNotificationPrefsRepository
    implements NotificationPrefsRepository {
  FirestoreNotificationPrefsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<NotificationPrefs> _doc(String userId) => _firestore
      .collection('users')
      .doc(userId)
      .collection('settings')
      .doc('notifications')
      .withConverter<NotificationPrefs>(
        fromFirestore: (snap, _) => NotificationPrefs.fromJson(snap.data()!),
        toFirestore: (prefs, _) => prefs.toJson(),
      );

  @override
  Stream<NotificationPrefs?> watchPrefs(String userId) =>
      _doc(userId).snapshots().map((snap) => snap.data());

  @override
  Future<void> savePrefs(String userId, NotificationPrefs prefs) =>
      _doc(userId).set(prefs);
}
