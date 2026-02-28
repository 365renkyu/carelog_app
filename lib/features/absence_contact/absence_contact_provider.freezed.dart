// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence_contact_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AbsenceContactState {
  TherapySchedule? get selectedSchedule => throw _privateConstructorUsedError;
  AbsenceTemplate? get selectedTemplate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AbsenceContactStateCopyWith<AbsenceContactState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbsenceContactStateCopyWith<$Res> {
  factory $AbsenceContactStateCopyWith(
          AbsenceContactState value, $Res Function(AbsenceContactState) then) =
      _$AbsenceContactStateCopyWithImpl<$Res, AbsenceContactState>;
  @useResult
  $Res call(
      {TherapySchedule? selectedSchedule, AbsenceTemplate? selectedTemplate});

  $TherapyScheduleCopyWith<$Res>? get selectedSchedule;
  $AbsenceTemplateCopyWith<$Res>? get selectedTemplate;
}

/// @nodoc
class _$AbsenceContactStateCopyWithImpl<$Res, $Val extends AbsenceContactState>
    implements $AbsenceContactStateCopyWith<$Res> {
  _$AbsenceContactStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSchedule = freezed,
    Object? selectedTemplate = freezed,
  }) {
    return _then(_value.copyWith(
      selectedSchedule: freezed == selectedSchedule
          ? _value.selectedSchedule
          : selectedSchedule // ignore: cast_nullable_to_non_nullable
              as TherapySchedule?,
      selectedTemplate: freezed == selectedTemplate
          ? _value.selectedTemplate
          : selectedTemplate // ignore: cast_nullable_to_non_nullable
              as AbsenceTemplate?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TherapyScheduleCopyWith<$Res>? get selectedSchedule {
    if (_value.selectedSchedule == null) {
      return null;
    }

    return $TherapyScheduleCopyWith<$Res>(_value.selectedSchedule!, (value) {
      return _then(_value.copyWith(selectedSchedule: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AbsenceTemplateCopyWith<$Res>? get selectedTemplate {
    if (_value.selectedTemplate == null) {
      return null;
    }

    return $AbsenceTemplateCopyWith<$Res>(_value.selectedTemplate!, (value) {
      return _then(_value.copyWith(selectedTemplate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AbsenceContactStateImplCopyWith<$Res>
    implements $AbsenceContactStateCopyWith<$Res> {
  factory _$$AbsenceContactStateImplCopyWith(_$AbsenceContactStateImpl value,
          $Res Function(_$AbsenceContactStateImpl) then) =
      __$$AbsenceContactStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TherapySchedule? selectedSchedule, AbsenceTemplate? selectedTemplate});

  @override
  $TherapyScheduleCopyWith<$Res>? get selectedSchedule;
  @override
  $AbsenceTemplateCopyWith<$Res>? get selectedTemplate;
}

/// @nodoc
class __$$AbsenceContactStateImplCopyWithImpl<$Res>
    extends _$AbsenceContactStateCopyWithImpl<$Res, _$AbsenceContactStateImpl>
    implements _$$AbsenceContactStateImplCopyWith<$Res> {
  __$$AbsenceContactStateImplCopyWithImpl(_$AbsenceContactStateImpl _value,
      $Res Function(_$AbsenceContactStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedSchedule = freezed,
    Object? selectedTemplate = freezed,
  }) {
    return _then(_$AbsenceContactStateImpl(
      selectedSchedule: freezed == selectedSchedule
          ? _value.selectedSchedule
          : selectedSchedule // ignore: cast_nullable_to_non_nullable
              as TherapySchedule?,
      selectedTemplate: freezed == selectedTemplate
          ? _value.selectedTemplate
          : selectedTemplate // ignore: cast_nullable_to_non_nullable
              as AbsenceTemplate?,
    ));
  }
}

/// @nodoc

class _$AbsenceContactStateImpl extends _AbsenceContactState {
  const _$AbsenceContactStateImpl(
      {this.selectedSchedule, this.selectedTemplate})
      : super._();

  @override
  final TherapySchedule? selectedSchedule;
  @override
  final AbsenceTemplate? selectedTemplate;

  @override
  String toString() {
    return 'AbsenceContactState(selectedSchedule: $selectedSchedule, selectedTemplate: $selectedTemplate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbsenceContactStateImpl &&
            (identical(other.selectedSchedule, selectedSchedule) ||
                other.selectedSchedule == selectedSchedule) &&
            (identical(other.selectedTemplate, selectedTemplate) ||
                other.selectedTemplate == selectedTemplate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedSchedule, selectedTemplate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AbsenceContactStateImplCopyWith<_$AbsenceContactStateImpl> get copyWith =>
      __$$AbsenceContactStateImplCopyWithImpl<_$AbsenceContactStateImpl>(
          this, _$identity);
}

abstract class _AbsenceContactState extends AbsenceContactState {
  const factory _AbsenceContactState(
      {final TherapySchedule? selectedSchedule,
      final AbsenceTemplate? selectedTemplate}) = _$AbsenceContactStateImpl;
  const _AbsenceContactState._() : super._();

  @override
  TherapySchedule? get selectedSchedule;
  @override
  AbsenceTemplate? get selectedTemplate;
  @override
  @JsonKey(ignore: true)
  _$$AbsenceContactStateImplCopyWith<_$AbsenceContactStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
