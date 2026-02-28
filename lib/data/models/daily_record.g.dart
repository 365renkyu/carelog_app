// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRecordImpl _$$DailyRecordImplFromJson(Map<String, dynamic> json) =>
    _$DailyRecordImpl(
      id: json['id'] as String,
      childId: json['childId'] as String,
      date: json['date'] as String,
      mood: (json['mood'] as num).toInt(),
      notes: json['notes'] as String?,
      achievements: json['achievements'] as String?,
      cuteMoments: json['cuteMoments'] as String?,
      concerns: json['concerns'] as String?,
      therapyMemo: json['therapyMemo'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$DailyRecordImplToJson(_$DailyRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childId': instance.childId,
      'date': instance.date,
      'mood': instance.mood,
      'notes': instance.notes,
      'achievements': instance.achievements,
      'cuteMoments': instance.cuteMoments,
      'concerns': instance.concerns,
      'therapyMemo': instance.therapyMemo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
