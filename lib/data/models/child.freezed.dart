// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Child _$ChildFromJson(Map<String, dynamic> json) {
  return _Child.fromJson(json);
}

/// @nodoc
mixin _$Child {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get birthDate => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildCopyWith<Child> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildCopyWith<$Res> {
  factory $ChildCopyWith(Child value, $Res Function(Child) then) =
      _$ChildCopyWithImpl<$Res, Child>;
  @useResult
  $Res call({String id, String name, String birthDate, String createdAt});
}

/// @nodoc
class _$ChildCopyWithImpl<$Res, $Val extends Child>
    implements $ChildCopyWith<$Res> {
  _$ChildCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthDate = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id as String,
      name: null == name
          ? _value.name
          : name as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildImplCopyWith<$Res> implements $ChildCopyWith<$Res> {
  factory _$$ChildImplCopyWith(
          _$ChildImpl value, $Res Function(_$ChildImpl) then) =
      __$$ChildImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String birthDate, String createdAt});
}

/// @nodoc
class __$$ChildImplCopyWithImpl<$Res>
    extends _$ChildCopyWithImpl<$Res, _$ChildImpl>
    implements _$$ChildImplCopyWith<$Res> {
  __$$ChildImplCopyWithImpl(
      _$ChildImpl _value, $Res Function(_$ChildImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? birthDate = null,
    Object? createdAt = null,
  }) {
    return _then(_$ChildImpl(
      id: null == id
          ? _value.id
          : id as String,
      name: null == name
          ? _value.name
          : name as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChildImpl implements _Child {
  const _$ChildImpl({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.createdAt,
  });

  factory _$ChildImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChildImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String birthDate;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'Child(id: $id, name: $name, birthDate: $birthDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, birthDate, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildImplCopyWith<_$ChildImpl> get copyWith =>
      __$$ChildImplCopyWithImpl<_$ChildImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChildImplToJson(
      this,
    );
  }
}

abstract class _Child implements Child {
  const factory _Child({
    required final String id,
    required final String name,
    required final String birthDate,
    required final String createdAt,
  }) = _$ChildImpl;

  factory _Child.fromJson(Map<String, dynamic> json) = _$ChildImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get birthDate;
  @override
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChildImplCopyWith<_$ChildImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
