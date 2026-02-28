// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyRecord _$DailyRecordFromJson(Map<String, dynamic> json) {
  return _DailyRecord.fromJson(json);
}

/// @nodoc
mixin _$DailyRecord {
  String get id => throw _privateConstructorUsedError;
  String get childId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // 'YYYY-MM-DD'
  int get mood => throw _privateConstructorUsedError; // Mood.value
  String? get notes => throw _privateConstructorUsedError; // その日の様子
  String? get achievements => throw _privateConstructorUsedError; // できたこと
  String? get cuteMoments => throw _privateConstructorUsedError; // かわいいと感じたこと
  String? get concerns => throw _privateConstructorUsedError; // 課題・悩み
  String? get therapyMemo => throw _privateConstructorUsedError; // 療育メモ
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyRecordCopyWith<DailyRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRecordCopyWith<$Res> {
  factory $DailyRecordCopyWith(
          DailyRecord value, $Res Function(DailyRecord) then) =
      _$DailyRecordCopyWithImpl<$Res, DailyRecord>;
  @useResult
  $Res call(
      {String id,
      String childId,
      String date,
      int mood,
      String? notes,
      String? achievements,
      String? cuteMoments,
      String? concerns,
      String? therapyMemo,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$DailyRecordCopyWithImpl<$Res, $Val extends DailyRecord>
    implements $DailyRecordCopyWith<$Res> {
  _$DailyRecordCopyWithImpl(this._value, this._then);

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
    Object? mood = null,
    Object? notes = freezed,
    Object? achievements = freezed,
    Object? cuteMoments = freezed,
    Object? concerns = freezed,
    Object? therapyMemo = freezed,
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
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      achievements: freezed == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as String?,
      cuteMoments: freezed == cuteMoments
          ? _value.cuteMoments
          : cuteMoments // ignore: cast_nullable_to_non_nullable
              as String?,
      concerns: freezed == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as String?,
      therapyMemo: freezed == therapyMemo
          ? _value.therapyMemo
          : therapyMemo // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DailyRecordImplCopyWith<$Res>
    implements $DailyRecordCopyWith<$Res> {
  factory _$$DailyRecordImplCopyWith(
          _$DailyRecordImpl value, $Res Function(_$DailyRecordImpl) then) =
      __$$DailyRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String childId,
      String date,
      int mood,
      String? notes,
      String? achievements,
      String? cuteMoments,
      String? concerns,
      String? therapyMemo,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$DailyRecordImplCopyWithImpl<$Res>
    extends _$DailyRecordCopyWithImpl<$Res, _$DailyRecordImpl>
    implements _$$DailyRecordImplCopyWith<$Res> {
  __$$DailyRecordImplCopyWithImpl(
      _$DailyRecordImpl _value, $Res Function(_$DailyRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? date = null,
    Object? mood = null,
    Object? notes = freezed,
    Object? achievements = freezed,
    Object? cuteMoments = freezed,
    Object? concerns = freezed,
    Object? therapyMemo = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DailyRecordImpl(
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
      mood: null == mood
          ? _value.mood
          : mood // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      achievements: freezed == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as String?,
      cuteMoments: freezed == cuteMoments
          ? _value.cuteMoments
          : cuteMoments // ignore: cast_nullable_to_non_nullable
              as String?,
      concerns: freezed == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as String?,
      therapyMemo: freezed == therapyMemo
          ? _value.therapyMemo
          : therapyMemo // ignore: cast_nullable_to_non_nullable
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
class _$DailyRecordImpl implements _DailyRecord {
  const _$DailyRecordImpl(
      {required this.id,
      required this.childId,
      required this.date,
      required this.mood,
      this.notes,
      this.achievements,
      this.cuteMoments,
      this.concerns,
      this.therapyMemo,
      required this.createdAt,
      required this.updatedAt});

  factory _$DailyRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRecordImplFromJson(json);

  @override
  final String id;
  @override
  final String childId;
  @override
  final String date;
// 'YYYY-MM-DD'
  @override
  final int mood;
// Mood.value
  @override
  final String? notes;
// その日の様子
  @override
  final String? achievements;
// できたこと
  @override
  final String? cuteMoments;
// かわいいと感じたこと
  @override
  final String? concerns;
// 課題・悩み
  @override
  final String? therapyMemo;
// 療育メモ
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'DailyRecord(id: $id, childId: $childId, date: $date, mood: $mood, notes: $notes, achievements: $achievements, cuteMoments: $cuteMoments, concerns: $concerns, therapyMemo: $therapyMemo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.mood, mood) || other.mood == mood) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.achievements, achievements) ||
                other.achievements == achievements) &&
            (identical(other.cuteMoments, cuteMoments) ||
                other.cuteMoments == cuteMoments) &&
            (identical(other.concerns, concerns) ||
                other.concerns == concerns) &&
            (identical(other.therapyMemo, therapyMemo) ||
                other.therapyMemo == therapyMemo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, childId, date, mood, notes,
      achievements, cuteMoments, concerns, therapyMemo, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRecordImplCopyWith<_$DailyRecordImpl> get copyWith =>
      __$$DailyRecordImplCopyWithImpl<_$DailyRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRecordImplToJson(
      this,
    );
  }
}

abstract class _DailyRecord implements DailyRecord {
  const factory _DailyRecord(
      {required final String id,
      required final String childId,
      required final String date,
      required final int mood,
      final String? notes,
      final String? achievements,
      final String? cuteMoments,
      final String? concerns,
      final String? therapyMemo,
      required final String createdAt,
      required final String updatedAt}) = _$DailyRecordImpl;

  factory _DailyRecord.fromJson(Map<String, dynamic> json) =
      _$DailyRecordImpl.fromJson;

  @override
  String get id;
  @override
  String get childId;
  @override
  String get date;
  @override // 'YYYY-MM-DD'
  int get mood;
  @override // Mood.value
  String? get notes;
  @override // その日の様子
  String? get achievements;
  @override // できたこと
  String? get cuteMoments;
  @override // かわいいと感じたこと
  String? get concerns;
  @override // 課題・悩み
  String? get therapyMemo;
  @override // 療育メモ
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DailyRecordImplCopyWith<_$DailyRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
