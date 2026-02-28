// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceTemplateImpl _$$AbsenceTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$AbsenceTemplateImpl(
      id: json['id'] as String,
      childId: json['childId'] as String,
      title: json['title'] as String,
      template: json['template'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$AbsenceTemplateImplToJson(
        _$AbsenceTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childId': instance.childId,
      'title': instance.title,
      'template': instance.template,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
