// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AbsenceTemplate _$AbsenceTemplateFromJson(Map<String, dynamic> json) {
  return _AbsenceTemplate.fromJson(json);
}

/// @nodoc
mixin _$AbsenceTemplate {
  String get id => throw _privateConstructorUsedError;
  String get childId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get template => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AbsenceTemplateCopyWith<AbsenceTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbsenceTemplateCopyWith<$Res> {
  factory $AbsenceTemplateCopyWith(
          AbsenceTemplate value, $Res Function(AbsenceTemplate) then) =
      _$AbsenceTemplateCopyWithImpl<$Res, AbsenceTemplate>;
  @useResult
  $Res call(
      {String id,
      String childId,
      String title,
      String template,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$AbsenceTemplateCopyWithImpl<$Res, $Val extends AbsenceTemplate>
    implements $AbsenceTemplateCopyWith<$Res> {
  _$AbsenceTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? title = null,
    Object? template = null,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$AbsenceTemplateImplCopyWith<$Res>
    implements $AbsenceTemplateCopyWith<$Res> {
  factory _$$AbsenceTemplateImplCopyWith(_$AbsenceTemplateImpl value,
          $Res Function(_$AbsenceTemplateImpl) then) =
      __$$AbsenceTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String childId,
      String title,
      String template,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$AbsenceTemplateImplCopyWithImpl<$Res>
    extends _$AbsenceTemplateCopyWithImpl<$Res, _$AbsenceTemplateImpl>
    implements _$$AbsenceTemplateImplCopyWith<$Res> {
  __$$AbsenceTemplateImplCopyWithImpl(
      _$AbsenceTemplateImpl _value, $Res Function(_$AbsenceTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? title = null,
    Object? template = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$AbsenceTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$AbsenceTemplateImpl implements _AbsenceTemplate {
  const _$AbsenceTemplateImpl(
      {required this.id,
      required this.childId,
      required this.title,
      required this.template,
      required this.createdAt,
      required this.updatedAt});

  factory _$AbsenceTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AbsenceTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String childId;
  @override
  final String title;
  @override
  final String template;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'AbsenceTemplate(id: $id, childId: $childId, title: $title, template: $template, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbsenceTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, childId, title, template, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AbsenceTemplateImplCopyWith<_$AbsenceTemplateImpl> get copyWith =>
      __$$AbsenceTemplateImplCopyWithImpl<_$AbsenceTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AbsenceTemplateImplToJson(
      this,
    );
  }
}

abstract class _AbsenceTemplate implements AbsenceTemplate {
  const factory _AbsenceTemplate(
      {required final String id,
      required final String childId,
      required final String title,
      required final String template,
      required final String createdAt,
      required final String updatedAt}) = _$AbsenceTemplateImpl;

  factory _AbsenceTemplate.fromJson(Map<String, dynamic> json) =
      _$AbsenceTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get childId;
  @override
  String get title;
  @override
  String get template;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AbsenceTemplateImplCopyWith<_$AbsenceTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
