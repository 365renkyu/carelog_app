import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_log.freezed.dart';
part 'meal_log.g.dart';

@freezed
class MealLog with _$MealLog {
  const factory MealLog({
    required String id,
    required String dailyRecordId,
    required String childId,
    required String mealTime,  // ISO8601
    required String content,
  }) = _MealLog;

  factory MealLog.fromJson(Map<String, dynamic> json) =>
      _$MealLogFromJson(json);
}
