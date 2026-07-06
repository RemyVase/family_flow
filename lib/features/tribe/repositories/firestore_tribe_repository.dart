import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/tribe.dart';
import 'package:our_tribe/features/tribe/models/tribe_invite.dart';
import 'package:our_tribe/features/tribe/repositories/tribe_repository.dart';

/// Firestore implementation of [TribeRepository].
class FirestoreTribeRepository implements TribeRepository {
  FirestoreTribeRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Tribe> get _tribes => _firestore
      .collection('tribes')
      .withConverter<Tribe>(
        fromFirestore: (snap, _) =>
            Tribe.fromJson({...snap.data()!, 'id': snap.id}),
        toFirestore: (tribe, _) => tribe.toJson()..remove('id'),
      );

  CollectionReference<TribeInvite> get _invites => _firestore
      .collection('invites')
      .withConverter<TribeInvite>(
        fromFirestore: (snap, _) =>
            TribeInvite.fromJson({...snap.data()!, 'id': snap.id}),
        toFirestore: (invite, _) => invite.toJson()..remove('id'),
      );

  CollectionReference<Member> _members(String tribeId) => _firestore
      .collection('tribes')
      .doc(tribeId)
      .collection('members')
      .withConverter<Member>(
        fromFirestore: (snap, _) =>
            Member.fromJson({...snap.data()!, 'id': snap.id}),
        toFirestore: (member, _) => member.toJson()..remove('id'),
      );

  @override
  Stream<Tribe?> watchTribe(String tribeId) =>
      _tribes.doc(tribeId).snapshots().map((snap) => snap.data());

  @override
  Stream<List<Member>> watchMembers(String tribeId) => _members(
    tribeId,
  ).snapshots().map((query) => query.docs.map((doc) => doc.data()).toList());

  @override
  Future<String> createTribe({
    required Tribe tribe,
    required Member founder,
  }) async {
    final tribeDoc = _tribes.doc();
    final batch = _firestore.batch()
      ..set(tribeDoc, tribe.copyWith(id: tribeDoc.id))
      ..set(
        _invites.doc(tribe.inviteCode),
        TribeInvite(
          id: tribe.inviteCode,
          tribeId: tribeDoc.id,
          tribeName: tribe.name,
        ),
      )
      ..set(_members(tribeDoc.id).doc(founder.id), founder);
    await batch.commit();
    return tribeDoc.id;
  }

  @override
  Future<TribeInvite?> fetchInvite(String code) async {
    final snap = await _invites.doc(code).get();
    return snap.data();
  }

  @override
  Future<void> joinTribe({
    required TribeInvite invite,
    required Member member,
  }) {
    // The `joinCode` field is the proof of invitation the security rules
    // check on create; it is written alongside the member document.
    return _firestore
        .collection('tribes')
        .doc(invite.tribeId)
        .collection('members')
        .doc(member.id)
        .set({...member.toJson()..remove('id'), 'joinCode': invite.id});
  }

  @override
  Future<void> saveMember(String tribeId, Member member) =>
      _members(tribeId).doc(member.id).set(member);

  @override
  Future<void> removeMember(String tribeId, String memberId) =>
      _members(tribeId).doc(memberId).delete();

  @override
  Future<void> updateInviteMemberCount(String code, int memberCount) =>
      _firestore.collection('invites').doc(code).update({
        'memberCount': memberCount,
      });

  @override
  Future<void> deleteTribe({required Tribe tribe, required String memberId}) {
    final batch = _firestore.batch()
      ..delete(_members(tribe.id).doc(memberId))
      ..delete(_invites.doc(tribe.inviteCode))
      ..delete(_tribes.doc(tribe.id));
    return batch.commit();
  }
}
