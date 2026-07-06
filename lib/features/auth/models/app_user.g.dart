// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  email: json['email'] as String,
  tribeId: json['tribeId'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'email': instance.email,
  'tribeId': instance.tribeId,
};
