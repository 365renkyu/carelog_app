// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SleepLog _$SleepLogFromJson(Map<String, dynamic> json) {
  return _SleepLog.fromJson(json);
}

/// @nodoc
mixin _$SleepLog {
  String get id => throw _privateConstructorUsedError;
  String get dailyRecordId => throw _privateConstructorUsedError;
  String get childId => throw _privateConstructorUsedError;
  String? get bedtimeStartTime =>
      throw _privateConstructorUsedError; // 寝かしつけ開始時刻（ISO8601, nullable）
  String get sleepStartTime =>
      throw _privateConstructorUsedError; // 入眠時刻（ISO8601）
  String? get sleepEndTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SleepLogCopyWith<SleepLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepLogCopyWith<$Res> {
  factory $SleepLogCopyWith(SleepLog value, $Res Function(SleepLog) then) =
      _$SleepLogCopyWithImpl<$Res, SleepLog>;
  @useResult
  $Res call(
      {String id,
      String dailyRecordId,
      String childId,
      String? bedtimeStartTime,
      String sleepStartTime,
      String? sleepEndTime});
}

/// @nodoc
class _$SleepLogCopyWithImpl<$Res, $Val extends SleepLog>
    implements $SleepLogCopyWith<$Res> {
  _$SleepLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dailyRecordId = null,
    Object? childId = null,
    Object? bedtimeStartTime = freezed,
    Object? sleepStartTime = null,
    Object? sleepEndTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dailyRecordId: null == dailyRecordId
          ? _value.dailyRecordId
          : dailyRecordId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      bedtimeStartTime: freezed == bedtimeStartTime
          ? _value.bedtimeStartTime
          : bedtimeStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepStartTime: null == sleepStartTime
          ? _value.sleepStartTime
          : sleepStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      sleepEndTime: freezed == sleepEndTime
          ? _value.sleepEndTime
          : sleepEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepLogImplCopyWith<$Res>
    implements $SleepLogCopyWith<$Res> {
  factory _$$SleepLogImplCopyWith(
          _$SleepLogImpl value, $Res Function(_$SleepLogImpl) then) =
      __$$SleepLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dailyRecordId,
      String childId,
      String? bedtimeStartTime,
      String sleepStartTime,
      String? sleepEndTime});
}

/// @nodoc
class __$$SleepLogImplCopyWithImpl<$Res>
    extends _$SleepLogCopyWithImpl<$Res, _$SleepLogImpl>
    implements _$$SleepLogImplCopyWith<$Res> {
  __$$SleepLogImplCopyWithImpl(
      _$SleepLogImpl _value, $Res Function(_$SleepLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dailyRecordId = null,
    Object? childId = null,
    Object? bedtimeStartTime = freezed,
    Object? sleepStartTime = null,
    Object? sleepEndTime = freezed,
  }) {
    return _then(_$SleepLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dailyRecordId: null == dailyRecordId
          ? _value.dailyRecordId
          : dailyRecordId // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      bedtimeStartTime: freezed == bedtimeStartTime
          ? _value.bedtimeStartTime
          : bedtimeStartTime // ignore: cast_nullable_to_non_nullable
              as String?,
      sleepStartTime: null == sleepStartTime
          ? _value.sleepStartTime
          : sleepStartTime // ignore: cast_nullable_to_non_nullable
              as String,
      sleepEndTime: freezed == sleepEndTime
          ? _value.sleepEndTime
          : sleepEndTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepLogImpl implements _SleepLog {
  const _$SleepLogImpl(
      {required this.id,
      required this.dailyRecordId,
      required this.childId,
      this.bedtimeStartTime,
      required this.sleepStartTime,
      this.sleepEndTime});

  factory _$SleepLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepLogImplFromJson(json);

  @override
  final String id;
  @override
  final String dailyRecordId;
  @override
  final String childId;
  @override
  final String? bedtimeStartTime;
// 寝かしつけ開始時刻（ISO8601, nullable）
  @override
  final String sleepStartTime;
// 入眠時刻（ISO8601）
  @override
  final String? sleepEndTime;

  @override
  String toString() {
    return 'SleepLog(id: $id, dailyRecordId: $dailyRecordId, childId: $childId, bedtimeStartTime: $bedtimeStartTime, sleepStartTime: $sleepStartTime, sleepEndTime: $sleepEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dailyRecordId, dailyRecordId) ||
                other.dailyRecordId == dailyRecordId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.bedtimeStartTime, bedtimeStartTime) ||
                other.bedtimeStartTime == bedtimeStartTime) &&
            (identical(other.sleepStartTime, sleepStartTime) ||
                other.sleepStartTime == sleepStartTime) &&
            (identical(other.sleepEndTime, sleepEndTime) ||
                other.sleepEndTime == sleepEndTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, dailyRecordId, childId,
      bedtimeStartTime, sleepStartTime, sleepEndTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      __$$SleepLogImplCopyWithImpl<_$SleepLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepLogImplToJson(
      this,
    );
  }
}

abstract class _SleepLog implements SleepLog {
  const factory _SleepLog(
      {required final String id,
      required final String dailyRecordId,
      required final String childId,
      final String? bedtimeStartTime,
      required final String sleepStartTime,
      final String? sleepEndTime}) = _$SleepLogImpl;

  factory _SleepLog.fromJson(Map<String, dynamic> json) =
      _$SleepLogImpl.fromJson;

  @override
  String get id;
  @override
  String get dailyRecordId;
  @override
  String get childId;
  @override
  String? get bedtimeStartTime;
  @override // 寝かしつけ開始時刻（ISO8601, nullable）
  String get sleepStartTime;
  @override // 入眠時刻（ISO8601）
  String? get sleepEndTime;
  @override
  @JsonKey(ignore: true)
  _$$SleepLogImplCopyWith<_$SleepLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
