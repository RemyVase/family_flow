import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Points d'accès centralisés aux services Firebase.
///
/// Évite d'appeler `.instance` partout dans le code et facilite un futur
/// remplacement par des fakes en test.
class FirebaseServices {
  FirebaseServices._();

  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
}
