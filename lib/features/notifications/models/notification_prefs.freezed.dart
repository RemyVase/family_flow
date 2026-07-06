// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_prefs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPrefs {

/// Master switch; nothing is pushed when false.
 bool get masterEnabled; bool get remindTasks; ReminderLeadTime get leadTime; bool get morningSummary; bool get eveningReminder; bool get overdueAlert; bool get tribeLifeAlerts;/// No pushes between 21:00 and 7:30.
 bool get quietNight;
/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsCopyWith<NotificationPrefs> get copyWith => _$NotificationPrefsCopyWithImpl<NotificationPrefs>(this as NotificationPrefs, _$identity);

  /// Serializes this NotificationPrefs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefs&&(identical(other.masterEnabled, masterEnabled) || other.masterEnabled == masterEnabled)&&(identical(other.remindTasks, remindTasks) || other.remindTasks == remindTasks)&&(identical(other.leadTime, leadTime) || other.leadTime == leadTime)&&(identical(other.morningSummary, morningSummary) || other.morningSummary == morningSummary)&&(identical(other.eveningReminder, eveningReminder) || other.eveningReminder == eveningReminder)&&(identical(other.overdueAlert, overdueAlert) || other.overdueAlert == overdueAlert)&&(identical(other.tribeLifeAlerts, tribeLifeAlerts) || other.tribeLifeAlerts == tribeLifeAlerts)&&(identical(other.quietNight, quietNight) || other.quietNight == quietNight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,masterEnabled,remindTasks,leadTime,morningSummary,eveningReminder,overdueAlert,tribeLifeAlerts,quietNight);

@override
String toString() {
  return 'NotificationPrefs(masterEnabled: $masterEnabled, remindTasks: $remindTasks, leadTime: $leadTime, morningSummary: $morningSummary, eveningReminder: $eveningReminder, overdueAlert: $overdueAlert, tribeLifeAlerts: $tribeLifeAlerts, quietNight: $quietNight)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsCopyWith<$Res>  {
  factory $NotificationPrefsCopyWith(NotificationPrefs value, $Res Function(NotificationPrefs) _then) = _$NotificationPrefsCopyWithImpl;
@useResult
$Res call({
 bool masterEnabled, bool remindTasks, ReminderLeadTime leadTime, bool morningSummary, bool eveningReminder, bool overdueAlert, bool tribeLifeAlerts, bool quietNight
});




}
/// @nodoc
class _$NotificationPrefsCopyWithImpl<$Res>
    implements $NotificationPrefsCopyWith<$Res> {
  _$NotificationPrefsCopyWithImpl(this._self, this._then);

  final NotificationPrefs _self;
  final $Res Function(NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? masterEnabled = null,Object? remindTasks = null,Object? leadTime = null,Object? morningSummary = null,Object? eveningReminder = null,Object? overdueAlert = null,Object? tribeLifeAlerts = null,Object? quietNight = null,}) {
  return _then(_self.copyWith(
masterEnabled: null == masterEnabled ? _self.masterEnabled : masterEnabled // ignore: cast_nullable_to_non_nullable
as bool,remindTasks: null == remindTasks ? _self.remindTasks : remindTasks // ignore: cast_nullable_to_non_nullable
as bool,leadTime: null == leadTime ? _self.leadTime : leadTime // ignore: cast_nullable_to_non_nullable
as ReminderLeadTime,morningSummary: null == morningSummary ? _self.morningSummary : morningSummary // ignore: cast_nullable_to_non_nullable
as bool,eveningReminder: null == eveningReminder ? _self.eveningReminder : eveningReminder // ignore: cast_nullable_to_non_nullable
as bool,overdueAlert: null == overdueAlert ? _self.overdueAlert : overdueAlert // ignore: cast_nullable_to_non_nullable
as bool,tribeLifeAlerts: null == tribeLifeAlerts ? _self.tribeLifeAlerts : tribeLifeAlerts // ignore: cast_nullable_to_non_nullable
as bool,quietNight: null == quietNight ? _self.quietNight : quietNight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPrefs].
extension NotificationPrefsPatterns on NotificationPrefs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPrefs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPrefs value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPrefs value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool masterEnabled,  bool remindTasks,  ReminderLeadTime leadTime,  bool morningSummary,  bool eveningReminder,  bool overdueAlert,  bool tribeLifeAlerts,  bool quietNight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.masterEnabled,_that.remindTasks,_that.leadTime,_that.morningSummary,_that.eveningReminder,_that.overdueAlert,_that.tribeLifeAlerts,_that.quietNight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool masterEnabled,  bool remindTasks,  ReminderLeadTime leadTime,  bool morningSummary,  bool eveningReminder,  bool overdueAlert,  bool tribeLifeAlerts,  bool quietNight)  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs():
return $default(_that.masterEnabled,_that.remindTasks,_that.leadTime,_that.morningSummary,_that.eveningReminder,_that.overdueAlert,_that.tribeLifeAlerts,_that.quietNight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool masterEnabled,  bool remindTasks,  ReminderLeadTime leadTime,  bool morningSummary,  bool eveningReminder,  bool overdueAlert,  bool tribeLifeAlerts,  bool quietNight)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPrefs() when $default != null:
return $default(_that.masterEnabled,_that.remindTasks,_that.leadTime,_that.morningSummary,_that.eveningReminder,_that.overdueAlert,_that.tribeLifeAlerts,_that.quietNight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPrefs implements NotificationPrefs {
  const _NotificationPrefs({this.masterEnabled = true, this.remindTasks = true, this.leadTime = ReminderLeadTime.thirtyMinutes, this.morningSummary = true, this.eveningReminder = true, this.overdueAlert = true, this.tribeLifeAlerts = true, this.quietNight = true});
  factory _NotificationPrefs.fromJson(Map<String, dynamic> json) => _$NotificationPrefsFromJson(json);

/// Master switch; nothing is pushed when false.
@override@JsonKey() final  bool masterEnabled;
@override@JsonKey() final  bool remindTasks;
@override@JsonKey() final  ReminderLeadTime leadTime;
@override@JsonKey() final  bool morningSummary;
@override@JsonKey() final  bool eveningReminder;
@override@JsonKey() final  bool overdueAlert;
@override@JsonKey() final  bool tribeLifeAlerts;
/// No pushes between 21:00 and 7:30.
@override@JsonKey() final  bool quietNight;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsCopyWith<_NotificationPrefs> get copyWith => __$NotificationPrefsCopyWithImpl<_NotificationPrefs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPrefsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefs&&(identical(other.masterEnabled, masterEnabled) || other.masterEnabled == masterEnabled)&&(identical(other.remindTasks, remindTasks) || other.remindTasks == remindTasks)&&(identical(other.leadTime, leadTime) || other.leadTime == leadTime)&&(identical(other.morningSummary, morningSummary) || other.morningSummary == morningSummary)&&(identical(other.eveningReminder, eveningReminder) || other.eveningReminder == eveningReminder)&&(identical(other.overdueAlert, overdueAlert) || other.overdueAlert == overdueAlert)&&(identical(other.tribeLifeAlerts, tribeLifeAlerts) || other.tribeLifeAlerts == tribeLifeAlerts)&&(identical(other.quietNight, quietNight) || other.quietNight == quietNight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,masterEnabled,remindTasks,leadTime,morningSummary,eveningReminder,overdueAlert,tribeLifeAlerts,quietNight);

@override
String toString() {
  return 'NotificationPrefs(masterEnabled: $masterEnabled, remindTasks: $remindTasks, leadTime: $leadTime, morningSummary: $morningSummary, eveningReminder: $eveningReminder, overdueAlert: $overdueAlert, tribeLifeAlerts: $tribeLifeAlerts, quietNight: $quietNight)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsCopyWith<$Res> implements $NotificationPrefsCopyWith<$Res> {
  factory _$NotificationPrefsCopyWith(_NotificationPrefs value, $Res Function(_NotificationPrefs) _then) = __$NotificationPrefsCopyWithImpl;
@override @useResult
$Res call({
 bool masterEnabled, bool remindTasks, ReminderLeadTime leadTime, bool morningSummary, bool eveningReminder, bool overdueAlert, bool tribeLifeAlerts, bool quietNight
});




}
/// @nodoc
class __$NotificationPrefsCopyWithImpl<$Res>
    implements _$NotificationPrefsCopyWith<$Res> {
  __$NotificationPrefsCopyWithImpl(this._self, this._then);

  final _NotificationPrefs _self;
  final $Res Function(_NotificationPrefs) _then;

/// Create a copy of NotificationPrefs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? masterEnabled = null,Object? remindTasks = null,Object? leadTime = null,Object? morningSummary = null,Object? eveningReminder = null,Object? overdueAlert = null,Object? tribeLifeAlerts = null,Object? quietNight = null,}) {
  return _then(_NotificationPrefs(
masterEnabled: null == masterEnabled ? _self.masterEnabled : masterEnabled // ignore: cast_nullable_to_non_nullable
as bool,remindTasks: null == remindTasks ? _self.remindTasks : remindTasks // ignore: cast_nullable_to_non_nullable
as bool,leadTime: null == leadTime ? _self.leadTime : leadTime // ignore: cast_nullable_to_non_nullable
as ReminderLeadTime,morningSummary: null == morningSummary ? _self.morningSummary : morningSummary // ignore: cast_nullable_to_non_nullable
as bool,eveningReminder: null == eveningReminder ? _self.eveningReminder : eveningReminder // ignore: cast_nullable_to_non_nullable
as bool,overdueAlert: null == overdueAlert ? _self.overdueAlert : overdueAlert // ignore: cast_nullable_to_non_nullable
as bool,tribeLifeAlerts: null == tribeLifeAlerts ? _self.tribeLifeAlerts : tribeLifeAlerts // ignore: cast_nullable_to_non_nullable
as bool,quietNight: null == quietNight ? _self.quietNight : quietNight // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
