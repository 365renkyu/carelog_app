import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';

part 'daily_record_detail.freezed.dart';

/// DailyRecord に紐づくログを集約したモデル（DB JOINの代替）
@freezed
class DailyRecordDetail with _$DailyRecordDetail {
  const factory DailyRecordDetail({
    required DailyRecord record,
    required List<SleepLog> sleepLogs,
    required List<MealLog> mealLogs,
  }) = _DailyRecordDetail;
}
