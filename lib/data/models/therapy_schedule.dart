import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapy_schedule.freezed.dart';
part 'therapy_schedule.g.dart';

@freezed
class TherapySchedule with _$TherapySchedule {
  const factory TherapySchedule({
    required String id,
    required String childId,
    required String date,         // 'YYYY-MM-DD'（繰り返しの場合は起点日）
    required String startTime,    // 'HH:mm'
    required String endTime,      // 'HH:mm'
    required String facilityName,
    String? memo,
    @Default('none') String repeatType,      // 'none' | 'weekly'
    int? repeatDayOfWeek,                    // 0=月〜6=日 (weeklyのみ)
    String? repeatUntil,                     // 'YYYY-MM-DD' (繰り返し終了日)
    required String createdAt,
    required String updatedAt,
  }) = _TherapySchedule;

  factory TherapySchedule.fromJson(Map<String, dynamic> json) =>
      _$TherapyScheduleFromJson(json);
}
