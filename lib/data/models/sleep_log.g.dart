// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SleepLogImpl _$$SleepLogImplFromJson(Map<String, dynamic> json) =>
    _$SleepLogImpl(
      id: json['id'] as String,
      dailyRecordId: json['dailyRecordId'] as String,
      childId: json['childId'] as String,
      bedtimeStartTime: json['bedtimeStartTime'] as String?,
      sleepStartTime: json['sleepStartTime'] as String,
      sleepEndTime: json['sleepEndTime'] as String?,
    );

Map<String, dynamic> _$$SleepLogImplToJson(_$SleepLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dailyRecordId': instance.dailyRecordId,
      'childId': instance.childId,
      'bedtimeStartTime': instance.bedtimeStartTime,
      'sleepStartTime': instance.sleepStartTime,
      'sleepEndTime': instance.sleepEndTime,
    };
