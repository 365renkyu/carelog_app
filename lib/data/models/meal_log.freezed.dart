// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealLog _$MealLogFromJson(Map<String, dynamic> json) {
  return _MealLog.fromJson(json);
}

/// @nodoc
mixin _$MealLog {
  String get id => throw _privateConstructorUsedError;
  String get dailyRecordId => throw _privateConstructorUsedError;
  String get childId => throw _privateConstructorUsedError;
  String get mealTime => throw _privateConstructorUsedError; // ISO8601
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MealLogCopyWith<MealLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealLogCopyWith<$Res> {
  factory $MealLogCopyWith(MealLog value, $Res Function(MealLog) then) =
      _$MealLogCopyWithImpl<$Res, MealLog>;
  @useResult
  $Res call(
      {String id,
      String dailyRecordId,
      String childId,
      String mealTime,
      String content});
}

/// @nodoc
class _$MealLogCopyWithImpl<$Res, $Val extends MealLog>
    implements $MealLogCopyWith<$Res> {
  _$MealLogCopyWithImpl(this._value, this._then);

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
    Object? mealTime = null,
    Object? content = null,
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
      mealTime: null == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealLogImplCopyWith<$Res> implements $MealLogCopyWith<$Res> {
  factory _$$MealLogImplCopyWith(
          _$MealLogImpl value, $Res Function(_$MealLogImpl) then) =
      __$$MealLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dailyRecordId,
      String childId,
      String mealTime,
      String content});
}

/// @nodoc
class __$$MealLogImplCopyWithImpl<$Res>
    extends _$MealLogCopyWithImpl<$Res, _$MealLogImpl>
    implements _$$MealLogImplCopyWith<$Res> {
  __$$MealLogImplCopyWithImpl(
      _$MealLogImpl _value, $Res Function(_$MealLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dailyRecordId = null,
    Object? childId = null,
    Object? mealTime = null,
    Object? content = null,
  }) {
    return _then(_$MealLogImpl(
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
      mealTime: null == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealLogImpl implements _MealLog {
  const _$MealLogImpl(
      {required this.id,
      required this.dailyRecordId,
      required this.childId,
      required this.mealTime,
      required this.content});

  factory _$MealLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealLogImplFromJson(json);

  @override
  final String id;
  @override
  final String dailyRecordId;
  @override
  final String childId;
  @override
  final String mealTime;
// ISO8601
  @override
  final String content;

  @override
  String toString() {
    return 'MealLog(id: $id, dailyRecordId: $dailyRecordId, childId: $childId, mealTime: $mealTime, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dailyRecordId, dailyRecordId) ||
                other.dailyRecordId == dailyRecordId) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.mealTime, mealTime) ||
                other.mealTime == mealTime) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, dailyRecordId, childId, mealTime, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MealLogImplCopyWith<_$MealLogImpl> get copyWith =>
      __$$MealLogImplCopyWithImpl<_$MealLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealLogImplToJson(
      this,
    );
  }
}

abstract class _MealLog implements MealLog {
  const factory _MealLog(
      {required final String id,
      required final String dailyRecordId,
      required final String childId,
      required final String mealTime,
      required final String content}) = _$MealLogImpl;

  factory _MealLog.fromJson(Map<String, dynamic> json) = _$MealLogImpl.fromJson;

  @override
  String get id;
  @override
  String get dailyRecordId;
  @override
  String get childId;
  @override
  String get mealTime;
  @override // ISO8601
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$MealLogImplCopyWith<_$MealLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
