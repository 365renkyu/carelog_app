// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealLogImpl _$$MealLogImplFromJson(Map<String, dynamic> json) =>
    _$MealLogImpl(
      id: json['id'] as String,
      dailyRecordId: json['dailyRecordId'] as String,
      childId: json['childId'] as String,
      mealTime: json['mealTime'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$MealLogImplToJson(_$MealLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dailyRecordId': instance.dailyRecordId,
      'childId': instance.childId,
      'mealTime': instance.mealTime,
      'content': instance.content,
    };
