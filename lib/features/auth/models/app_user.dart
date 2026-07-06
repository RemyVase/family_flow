import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// The signed-in user's own profile document (`users/{uid}`).
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String firstName,
    required String email,

    /// The tribe the user currently belongs to; null during onboarding.
    String? tribeId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
