// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tribe_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TribeInvite _$TribeInviteFromJson(Map<String, dynamic> json) => _TribeInvite(
  id: json['id'] as String,
  tribeId: json['tribeId'] as String,
  tribeName: json['tribeName'] as String,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$TribeInviteToJson(_TribeInvite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tribeId': instance.tribeId,
      'tribeName': instance.tribeName,
      'memberCount': instance.memberCount,
    };
