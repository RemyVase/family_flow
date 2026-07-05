import 'package:our_tribe/features/settings/models/reward.dart';

/// Demo rewards used while the app is design-only (no backend wired yet).
abstract final class MockRewards {
  /// Weekly tribe points balance shown on the rewards screen.
  static const int weeklyTribePoints = 84;

  static const List<Reward> rewards = [
    Reward(id: 'r1', name: 'Sortie ciné en tribu', goal: 100),
    Reward(id: 'r2', name: 'Léa choisit le repas', goal: 40, memberId: 'lea'),
    Reward(id: 'r3', name: 'Soirée jeux', goal: 70),
    Reward(id: 'r4', name: '1h de jeu bonus', goal: 30, memberId: 'tom'),
  ];
}
