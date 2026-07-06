// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get name; TaskMoment get moment; String get time; int get points;/// Assignee; null while the task is still up for grabs ("à répartir").
 String? get memberId; TaskRecurrence get recurrence;/// Recurring task handed to a different member each time.
 bool get isRotating; bool get isDone; bool get hasPhoto; String? get description;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.time, time) || other.time == time)&&(identical(other.points, points) || other.points == points)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.isRotating, isRotating) || other.isRotating == isRotating)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.hasPhoto, hasPhoto) || other.hasPhoto == hasPhoto)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,moment,time,points,memberId,recurrence,isRotating,isDone,hasPhoto,description);

@override
String toString() {
  return 'Task(id: $id, name: $name, moment: $moment, time: $time, points: $points, memberId: $memberId, recurrence: $recurrence, isRotating: $isRotating, isDone: $isDone, hasPhoto: $hasPhoto, description: $description)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String name, TaskMoment moment, String time, int points, String? memberId, TaskRecurrence recurrence, bool isRotating, bool isDone, bool hasPhoto, String? description
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? moment = null,Object? time = null,Object? points = null,Object? memberId = freezed,Object? recurrence = null,Object? isRotating = null,Object? isDone = null,Object? hasPhoto = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as TaskMoment,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String?,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as TaskRecurrence,isRotating: null == isRotating ? _self.isRotating : isRotating // ignore: cast_nullable_to_non_nullable
as bool,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  TaskMoment moment,  String time,  int points,  String? memberId,  TaskRecurrence recurrence,  bool isRotating,  bool isDone,  bool hasPhoto,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.name,_that.moment,_that.time,_that.points,_that.memberId,_that.recurrence,_that.isRotating,_that.isDone,_that.hasPhoto,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  TaskMoment moment,  String time,  int points,  String? memberId,  TaskRecurrence recurrence,  bool isRotating,  bool isDone,  bool hasPhoto,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.name,_that.moment,_that.time,_that.points,_that.memberId,_that.recurrence,_that.isRotating,_that.isDone,_that.hasPhoto,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  TaskMoment moment,  String time,  int points,  String? memberId,  TaskRecurrence recurrence,  bool isRotating,  bool isDone,  bool hasPhoto,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.name,_that.moment,_that.time,_that.points,_that.memberId,_that.recurrence,_that.isRotating,_that.isDone,_that.hasPhoto,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, required this.name, required this.moment, required this.time, required this.points, this.memberId, this.recurrence = TaskRecurrence.once, this.isRotating = false, this.isDone = false, this.hasPhoto = false, this.description}): super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String name;
@override final  TaskMoment moment;
@override final  String time;
@override final  int points;
/// Assignee; null while the task is still up for grabs ("à répartir").
@override final  String? memberId;
@override@JsonKey() final  TaskRecurrence recurrence;
/// Recurring task handed to a different member each time.
@override@JsonKey() final  bool isRotating;
@override@JsonKey() final  bool isDone;
@override@JsonKey() final  bool hasPhoto;
@override final  String? description;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.moment, moment) || other.moment == moment)&&(identical(other.time, time) || other.time == time)&&(identical(other.points, points) || other.points == points)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.recurrence, recurrence) || other.recurrence == recurrence)&&(identical(other.isRotating, isRotating) || other.isRotating == isRotating)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.hasPhoto, hasPhoto) || other.hasPhoto == hasPhoto)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,moment,time,points,memberId,recurrence,isRotating,isDone,hasPhoto,description);

@override
String toString() {
  return 'Task(id: $id, name: $name, moment: $moment, time: $time, points: $points, memberId: $memberId, recurrence: $recurrence, isRotating: $isRotating, isDone: $isDone, hasPhoto: $hasPhoto, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, TaskMoment moment, String time, int points, String? memberId, TaskRecurrence recurrence, bool isRotating, bool isDone, bool hasPhoto, String? description
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? moment = null,Object? time = null,Object? points = null,Object? memberId = freezed,Object? recurrence = null,Object? isRotating = null,Object? isDone = null,Object? hasPhoto = null,Object? description = freezed,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,moment: null == moment ? _self.moment : moment // ignore: cast_nullable_to_non_nullable
as TaskMoment,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as String?,recurrence: null == recurrence ? _self.recurrence : recurrence // ignore: cast_nullable_to_non_nullable
as TaskRecurrence,isRotating: null == isRotating ? _self.isRotating : isRotating // ignore: cast_nullable_to_non_nullable
as bool,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,hasPhoto: null == hasPhoto ? _self.hasPhoto : hasPhoto // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
