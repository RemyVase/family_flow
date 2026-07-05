import 'package:flutter/foundation.dart';
import 'package:our_tribe/features/settings/models/mock_rewards.dart';
import 'package:our_tribe/features/settings/models/reward.dart';

/// State of the rewards settings screen. Mock data for now.
class RewardsController extends ChangeNotifier {
  RewardsController({List<Reward>? rewards})
    : _rewards = List.of(rewards ?? MockRewards.rewards);

  final List<Reward> _rewards;

  List<Reward> get rewards => List.unmodifiable(_rewards);

  int get weeklyTribePoints => MockRewards.weeklyTribePoints;

  double progressFor(Reward reward) =>
      (weeklyTribePoints / reward.goal).clamp(0, 1).toDouble();

  bool isUnlocked(Reward reward) => weeklyTribePoints >= reward.goal;

  int remainingFor(Reward reward) =>
      (reward.goal - weeklyTribePoints).clamp(0, reward.goal);
}
