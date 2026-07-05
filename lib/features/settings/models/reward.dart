import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward.freezed.dart';

@freezed
abstract class Reward with _$Reward {
  const factory Reward({
    required String id,
    required String name,
    required int goal,

    /// Member the reward belongs to; null when it is a tribe-wide goal.
    String? memberId,
  }) = _Reward;
}
