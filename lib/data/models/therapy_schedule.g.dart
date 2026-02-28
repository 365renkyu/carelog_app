// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'therapy_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TherapyScheduleImpl _$$TherapyScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$TherapyScheduleImpl(
      id: json['id'] as String,
      childId: json['childId'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      facilityName: json['facilityName'] as String,
      memo: json['memo'] as String?,
      repeatType: json['repeatType'] as String? ?? 'none',
      repeatDayOfWeek: (json['repeatDayOfWeek'] as num?)?.toInt(),
      repeatUntil: json['repeatUntil'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$TherapyScheduleImplToJson(
        _$TherapyScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'childId': instance.childId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'facilityName': instance.facilityName,
      'memo': instance.memo,
      'repeatType': instance.repeatType,
      'repeatDayOfWeek': instance.repeatDayOfWeek,
      'repeatUntil': instance.repeatUntil,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
