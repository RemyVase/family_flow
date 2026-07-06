// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tribe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tribe {

 String get id; String get name; String get ownerId; String get inviteCode;@ColorIntConverter() Color get color;
/// Create a copy of Tribe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TribeCopyWith<Tribe> get copyWith => _$TribeCopyWithImpl<Tribe>(this as Tribe, _$identity);

  /// Serializes this Tribe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tribe&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,inviteCode,color);

@override
String toString() {
  return 'Tribe(id: $id, name: $name, ownerId: $ownerId, inviteCode: $inviteCode, color: $color)';
}


}

/// @nodoc
abstract mixin class $TribeCopyWith<$Res>  {
  factory $TribeCopyWith(Tribe value, $Res Function(Tribe) _then) = _$TribeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String ownerId, String inviteCode,@ColorIntConverter() Color color
});




}
/// @nodoc
class _$TribeCopyWithImpl<$Res>
    implements $TribeCopyWith<$Res> {
  _$TribeCopyWithImpl(this._self, this._then);

  final Tribe _self;
  final $Res Function(Tribe) _then;

/// Create a copy of Tribe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? inviteCode = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [Tribe].
extension TribePatterns on Tribe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tribe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tribe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tribe value)  $default,){
final _that = this;
switch (_that) {
case _Tribe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tribe value)?  $default,){
final _that = this;
switch (_that) {
case _Tribe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String ownerId,  String inviteCode, @ColorIntConverter()  Color color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tribe() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.inviteCode,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String ownerId,  String inviteCode, @ColorIntConverter()  Color color)  $default,) {final _that = this;
switch (_that) {
case _Tribe():
return $default(_that.id,_that.name,_that.ownerId,_that.inviteCode,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String ownerId,  String inviteCode, @ColorIntConverter()  Color color)?  $default,) {final _that = this;
switch (_that) {
case _Tribe() when $default != null:
return $default(_that.id,_that.name,_that.ownerId,_that.inviteCode,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tribe implements Tribe {
  const _Tribe({required this.id, required this.name, required this.ownerId, required this.inviteCode, @ColorIntConverter() required this.color});
  factory _Tribe.fromJson(Map<String, dynamic> json) => _$TribeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String ownerId;
@override final  String inviteCode;
@override@ColorIntConverter() final  Color color;

/// Create a copy of Tribe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TribeCopyWith<_Tribe> get copyWith => __$TribeCopyWithImpl<_Tribe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TribeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tribe&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,ownerId,inviteCode,color);

@override
String toString() {
  return 'Tribe(id: $id, name: $name, ownerId: $ownerId, inviteCode: $inviteCode, color: $color)';
}


}

/// @nodoc
abstract mixin class _$TribeCopyWith<$Res> implements $TribeCopyWith<$Res> {
  factory _$TribeCopyWith(_Tribe value, $Res Function(_Tribe) _then) = __$TribeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String ownerId, String inviteCode,@ColorIntConverter() Color color
});




}
/// @nodoc
class __$TribeCopyWithImpl<$Res>
    implements _$TribeCopyWith<$Res> {
  __$TribeCopyWithImpl(this._self, this._then);

  final _Tribe _self;
  final $Res Function(_Tribe) _then;

/// Create a copy of Tribe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? ownerId = null,Object? inviteCode = null,Object? color = null,}) {
  return _then(_Tribe(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
