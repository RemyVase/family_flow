// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tribe_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TribeInvite {

 String get id; String get tribeId; String get tribeName;/// Denormalized member count, shown on the join screen and used to pick
/// the next member color. Refreshed best-effort on join/leave.
 int get memberCount;
/// Create a copy of TribeInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TribeInviteCopyWith<TribeInvite> get copyWith => _$TribeInviteCopyWithImpl<TribeInvite>(this as TribeInvite, _$identity);

  /// Serializes this TribeInvite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TribeInvite&&(identical(other.id, id) || other.id == id)&&(identical(other.tribeId, tribeId) || other.tribeId == tribeId)&&(identical(other.tribeName, tribeName) || other.tribeName == tribeName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tribeId,tribeName,memberCount);

@override
String toString() {
  return 'TribeInvite(id: $id, tribeId: $tribeId, tribeName: $tribeName, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class $TribeInviteCopyWith<$Res>  {
  factory $TribeInviteCopyWith(TribeInvite value, $Res Function(TribeInvite) _then) = _$TribeInviteCopyWithImpl;
@useResult
$Res call({
 String id, String tribeId, String tribeName, int memberCount
});




}
/// @nodoc
class _$TribeInviteCopyWithImpl<$Res>
    implements $TribeInviteCopyWith<$Res> {
  _$TribeInviteCopyWithImpl(this._self, this._then);

  final TribeInvite _self;
  final $Res Function(TribeInvite) _then;

/// Create a copy of TribeInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tribeId = null,Object? tribeName = null,Object? memberCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tribeId: null == tribeId ? _self.tribeId : tribeId // ignore: cast_nullable_to_non_nullable
as String,tribeName: null == tribeName ? _self.tribeName : tribeName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TribeInvite].
extension TribeInvitePatterns on TribeInvite {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TribeInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TribeInvite() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TribeInvite value)  $default,){
final _that = this;
switch (_that) {
case _TribeInvite():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TribeInvite value)?  $default,){
final _that = this;
switch (_that) {
case _TribeInvite() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tribeId,  String tribeName,  int memberCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TribeInvite() when $default != null:
return $default(_that.id,_that.tribeId,_that.tribeName,_that.memberCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tribeId,  String tribeName,  int memberCount)  $default,) {final _that = this;
switch (_that) {
case _TribeInvite():
return $default(_that.id,_that.tribeId,_that.tribeName,_that.memberCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tribeId,  String tribeName,  int memberCount)?  $default,) {final _that = this;
switch (_that) {
case _TribeInvite() when $default != null:
return $default(_that.id,_that.tribeId,_that.tribeName,_that.memberCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TribeInvite implements TribeInvite {
  const _TribeInvite({required this.id, required this.tribeId, required this.tribeName, this.memberCount = 1});
  factory _TribeInvite.fromJson(Map<String, dynamic> json) => _$TribeInviteFromJson(json);

@override final  String id;
@override final  String tribeId;
@override final  String tribeName;
/// Denormalized member count, shown on the join screen and used to pick
/// the next member color. Refreshed best-effort on join/leave.
@override@JsonKey() final  int memberCount;

/// Create a copy of TribeInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TribeInviteCopyWith<_TribeInvite> get copyWith => __$TribeInviteCopyWithImpl<_TribeInvite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TribeInviteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TribeInvite&&(identical(other.id, id) || other.id == id)&&(identical(other.tribeId, tribeId) || other.tribeId == tribeId)&&(identical(other.tribeName, tribeName) || other.tribeName == tribeName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tribeId,tribeName,memberCount);

@override
String toString() {
  return 'TribeInvite(id: $id, tribeId: $tribeId, tribeName: $tribeName, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class _$TribeInviteCopyWith<$Res> implements $TribeInviteCopyWith<$Res> {
  factory _$TribeInviteCopyWith(_TribeInvite value, $Res Function(_TribeInvite) _then) = __$TribeInviteCopyWithImpl;
@override @useResult
$Res call({
 String id, String tribeId, String tribeName, int memberCount
});




}
/// @nodoc
class __$TribeInviteCopyWithImpl<$Res>
    implements _$TribeInviteCopyWith<$Res> {
  __$TribeInviteCopyWithImpl(this._self, this._then);

  final _TribeInvite _self;
  final $Res Function(_TribeInvite) _then;

/// Create a copy of TribeInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tribeId = null,Object? tribeName = null,Object? memberCount = null,}) {
  return _then(_TribeInvite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tribeId: null == tribeId ? _self.tribeId : tribeId // ignore: cast_nullable_to_non_nullable
as String,tribeName: null == tribeName ? _self.tribeName : tribeName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
