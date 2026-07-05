import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/features/tribe/models/mock_members.dart';

/// App-wide tribe state (members and their signature colors).
///
/// Member colors are the visual signature of the tribe and are read by
/// almost every screen, which is why this lives in a cross-feature service.
/// Backed by mock data while the app is design-only.
class TribeService extends ChangeNotifier {
  TribeService({List<Member>? members})
    : _members = List.of(members ?? MockMembers.members);

  final List<Member> _members;

  List<Member> get members => List.unmodifiable(_members);

  String get tribeName => MockMembers.tribeName;
  String get inviteCode => MockMembers.inviteCode;

  Member get currentMember => _members.firstWhere((m) => m.isCurrentUser);

  Member memberById(String id) => _members.firstWhere((m) => m.id == id);

  /// Members ranked by weekly points, best first.
  List<Member> get ranking =>
      [..._members]..sort((a, b) => b.weeklyPoints.compareTo(a.weeklyPoints));

  int get weeklyTotalPoints =>
      _members.fold(0, (sum, m) => sum + m.weeklyPoints);

  /// Changes a member's signature color (chief-only action in the UI).
  void setMemberColor(String memberId, Color color) {
    final index = _members.indexWhere((m) => m.id == memberId);
    if (index == -1) return;
    _members[index] = _members[index].copyWith(color: color);
    notifyListeners();
  }
}
