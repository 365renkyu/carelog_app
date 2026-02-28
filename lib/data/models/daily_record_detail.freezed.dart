// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_record_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyRecordDetail {
  DailyRecord get record => throw _privateConstructorUsedError;
  List<SleepLog> get sleepLogs => throw _privateConstructorUsedError;
  List<MealLog> get mealLogs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyRecordDetailCopyWith<DailyRecordDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRecordDetailCopyWith<$Res> {
  factory $DailyRecordDetailCopyWith(
          DailyRecordDetail value, $Res Function(DailyRecordDetail) then) =
      _$DailyRecordDetailCopyWithImpl<$Res, DailyRecordDetail>;
  @useResult
  $Res call(
      {DailyRecord record, List<SleepLog> sleepLogs, List<MealLog> mealLogs});

  $DailyRecordCopyWith<$Res> get record;
}

/// @nodoc
class _$DailyRecordDetailCopyWithImpl<$Res, $Val extends DailyRecordDetail>
    implements $DailyRecordDetailCopyWith<$Res> {
  _$DailyRecordDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
    Object? sleepLogs = null,
    Object? mealLogs = null,
  }) {
    return _then(_value.copyWith(
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as DailyRecord,
      sleepLogs: null == sleepLogs
          ? _value.sleepLogs
          : sleepLogs // ignore: cast_nullable_to_non_nullable
              as List<SleepLog>,
      mealLogs: null == mealLogs
          ? _value.mealLogs
          : mealLogs // ignore: cast_nullable_to_non_nullable
              as List<MealLog>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DailyRecordCopyWith<$Res> get record {
    return $DailyRecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyRecordDetailImplCopyWith<$Res>
    implements $DailyRecordDetailCopyWith<$Res> {
  factory _$$DailyRecordDetailImplCopyWith(_$DailyRecordDetailImpl value,
          $Res Function(_$DailyRecordDetailImpl) then) =
      __$$DailyRecordDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DailyRecord record, List<SleepLog> sleepLogs, List<MealLog> mealLogs});

  @override
  $DailyRecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$DailyRecordDetailImplCopyWithImpl<$Res>
    extends _$DailyRecordDetailCopyWithImpl<$Res, _$DailyRecordDetailImpl>
    implements _$$DailyRecordDetailImplCopyWith<$Res> {
  __$$DailyRecordDetailImplCopyWithImpl(_$DailyRecordDetailImpl _value,
      $Res Function(_$DailyRecordDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
    Object? sleepLogs = null,
    Object? mealLogs = null,
  }) {
    return _then(_$DailyRecordDetailImpl(
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as DailyRecord,
      sleepLogs: null == sleepLogs
          ? _value._sleepLogs
          : sleepLogs // ignore: cast_nullable_to_non_nullable
              as List<SleepLog>,
      mealLogs: null == mealLogs
          ? _value._mealLogs
          : mealLogs // ignore: cast_nullable_to_non_nullable
              as List<MealLog>,
    ));
  }
}

/// @nodoc

class _$DailyRecordDetailImpl implements _DailyRecordDetail {
  const _$DailyRecordDetailImpl(
      {required this.record,
      required final List<SleepLog> sleepLogs,
      required final List<MealLog> mealLogs})
      : _sleepLogs = sleepLogs,
        _mealLogs = mealLogs;

  @override
  final DailyRecord record;
  final List<SleepLog> _sleepLogs;
  @override
  List<SleepLog> get sleepLogs {
    if (_sleepLogs is EqualUnmodifiableListView) return _sleepLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sleepLogs);
  }

  final List<MealLog> _mealLogs;
  @override
  List<MealLog> get mealLogs {
    if (_mealLogs is EqualUnmodifiableListView) return _mealLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mealLogs);
  }

  @override
  String toString() {
    return 'DailyRecordDetail(record: $record, sleepLogs: $sleepLogs, mealLogs: $mealLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRecordDetailImpl &&
            (identical(other.record, record) || other.record == record) &&
            const DeepCollectionEquality()
                .equals(other._sleepLogs, _sleepLogs) &&
            const DeepCollectionEquality().equals(other._mealLogs, _mealLogs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      record,
      const DeepCollectionEquality().hash(_sleepLogs),
      const DeepCollectionEquality().hash(_mealLogs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRecordDetailImplCopyWith<_$DailyRecordDetailImpl> get copyWith =>
      __$$DailyRecordDetailImplCopyWithImpl<_$DailyRecordDetailImpl>(
          this, _$identity);
}

abstract class _DailyRecordDetail implements DailyRecordDetail {
  const factory _DailyRecordDetail(
      {required final DailyRecord record,
      required final List<SleepLog> sleepLogs,
      required final List<MealLog> mealLogs}) = _$DailyRecordDetailImpl;

  @override
  DailyRecord get record;
  @override
  List<SleepLog> get sleepLogs;
  @override
  List<MealLog> get mealLogs;
  @override
  @JsonKey(ignore: true)
  _$$DailyRecordDetailImplCopyWith<_$DailyRecordDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
