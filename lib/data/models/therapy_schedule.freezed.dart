// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapy_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TherapySchedule _$TherapyScheduleFromJson(Map<String, dynamic> json) {
  return _TherapySchedule.fromJson(json);
}

/// @nodoc
mixin _$TherapySchedule {
  String get id => throw _privateConstructorUsedError;
  String get childId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // 'YYYY-MM-DD'
  String get startTime => throw _privateConstructorUsedError; // 'HH:mm'
  String get endTime => throw _privateConstructorUsedError; // 'HH:mm'
  String get facilityName => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  String get repeatType => throw _privateConstructorUsedError;
  int? get repeatDayOfWeek => throw _privateConstructorUsedError;
  String? get repeatUntil => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TherapyScheduleCopyWith<TherapySchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TherapyScheduleCopyWith<$Res> {
  factory $TherapyScheduleCopyWith(
          TherapySchedule value, $Res Function(TherapySchedule) then) =
      _$TherapyScheduleCopyWithImpl<$Res, TherapySchedule>;
  @useResult
  $Res call(
      {String id,
      String childId,
      String date,
      String startTime,
      String endTime,
      String facilityName,
      String? memo,
      String repeatType,
      int? repeatDayOfWeek,
      String? repeatUntil,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$TherapyScheduleCopyWithImpl<$Res, $Val extends TherapySchedule>
    implements $TherapyScheduleCopyWith<$Res> {
  _$TherapyScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? facilityName = null,
    Object? memo = freezed,
    Object? repeatType = null,
    Object? repeatDayOfWeek = freezed,
    Object? repeatUntil = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      facilityName: null == facilityName
          ? _value.facilityName
          : facilityName // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      repeatType: null == repeatType
          ? _value.repeatType
          : repeatType // ignore: cast_nullable_to_non_nullable
              as String,
      repeatDayOfWeek: freezed == repeatDayOfWeek
          ? _value.repeatDayOfWeek
          : repeatDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      repeatUntil: freezed == repeatUntil
          ? _value.repeatUntil
          : repeatUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TherapyScheduleImplCopyWith<$Res>
    implements $TherapyScheduleCopyWith<$Res> {
  factory _$$TherapyScheduleImplCopyWith(_$TherapyScheduleImpl value,
          $Res Function(_$TherapyScheduleImpl) then) =
      __$$TherapyScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String childId,
      String date,
      String startTime,
      String endTime,
      String facilityName,
      String? memo,
      String repeatType,
      int? repeatDayOfWeek,
      String? repeatUntil,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$TherapyScheduleImplCopyWithImpl<$Res>
    extends _$TherapyScheduleCopyWithImpl<$Res, _$TherapyScheduleImpl>
    implements _$$TherapyScheduleImplCopyWith<$Res> {
  __$$TherapyScheduleImplCopyWithImpl(
      _$TherapyScheduleImpl _value, $Res Function(_$TherapyScheduleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? facilityName = null,
    Object? memo = freezed,
    Object? repeatType = null,
    Object? repeatDayOfWeek = freezed,
    Object? repeatUntil = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TherapyScheduleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      facilityName: null == facilityName
          ? _value.facilityName
          : facilityName // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      repeatType: null == repeatType
          ? _value.repeatType
          : repeatType // ignore: cast_nullable_to_non_nullable
              as String,
      repeatDayOfWeek: freezed == repeatDayOfWeek
          ? _value.repeatDayOfWeek
          : repeatDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      repeatUntil: freezed == repeatUntil
          ? _value.repeatUntil
          : repeatUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TherapyScheduleImpl implements _TherapySchedule {
  const _$TherapyScheduleImpl(
      {required this.id,
      required this.childId,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.facilityName,
      this.memo,
      this.repeatType = 'none',
      this.repeatDayOfWeek,
      this.repeatUntil,
      required this.createdAt,
      required this.updatedAt});

  factory _$TherapyScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TherapyScheduleImplFromJson(json);

  @override
  final String id;
  @override
  final String childId;
  @override
  final String date;
// 'YYYY-MM-DD'
  @override
  final String startTime;
// 'HH:mm'
  @override
  final String endTime;
// 'HH:mm'
  @override
  final String facilityName;
  @override
  final String? memo;
  @override
  @JsonKey()
  final String repeatType;
  @override
  final int? repeatDayOfWeek;
  @override
  final String? repeatUntil;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'TherapySchedule(id: $id, childId: $childId, date: $date, startTime: $startTime, endTime: $endTime, facilityName: $facilityName, memo: $memo, repeatType: $repeatType, repeatDayOfWeek: $repeatDayOfWeek, repeatUntil: $repeatUntil, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TherapyScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.facilityName, facilityName) ||
                other.facilityName == facilityName) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.repeatType, repeatType) ||
                other.repeatType == repeatType) &&
            (identical(other.repeatDayOfWeek, repeatDayOfWeek) ||
                other.repeatDayOfWeek == repeatDayOfWeek) &&
            (identical(other.repeatUntil, repeatUntil) ||
                other.repeatUntil == repeatUntil) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, childId, date, startTime,
      endTime, facilityName, memo, repeatType, repeatDayOfWeek, repeatUntil,
      createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TherapyScheduleImplCopyWith<_$TherapyScheduleImpl> get copyWith =>
      __$$TherapyScheduleImplCopyWithImpl<_$TherapyScheduleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TherapyScheduleImplToJson(
      this,
    );
  }
}

abstract class _TherapySchedule implements TherapySchedule {
  const factory _TherapySchedule(
      {required final String id,
      required final String childId,
      required final String date,
      required final String startTime,
      required final String endTime,
      required final String facilityName,
      final String? memo,
      final String repeatType,
      final int? repeatDayOfWeek,
      final String? repeatUntil,
      required final String createdAt,
      required final String updatedAt}) = _$TherapyScheduleImpl;

  factory _TherapySchedule.fromJson(Map<String, dynamic> json) =
      _$TherapyScheduleImpl.fromJson;

  @override
  String get id;
  @override
  String get childId;
  @override
  String get date;
  @override // 'YYYY-MM-DD'
  String get startTime;
  @override // 'HH:mm'
  String get endTime;
  @override // 'HH:mm'
  String get facilityName;
  @override
  String? get memo;
  @override
  String get repeatType;
  @override
  int? get repeatDayOfWeek;
  @override
  String? get repeatUntil;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TherapyScheduleImplCopyWith<_$TherapyScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
