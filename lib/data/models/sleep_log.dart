import 'package:freezed_annotation/freezed_annotation.dart';

part 'sleep_log.freezed.dart';
part 'sleep_log.g.dart';

@freezed
class SleepLog with _$SleepLog {
  const factory SleepLog({
    required String id,
    required String dailyRecordId,
    required String childId,
    String? bedtimeStartTime,   // 寝かしつけ開始時刻（ISO8601, nullable）
    required String sleepStartTime, // 入眠時刻（ISO8601）
    String? sleepEndTime,       // 起床時刻（ISO8601, null = 就寝中）
  }) = _SleepLog;

  factory SleepLog.fromJson(Map<String, dynamic> json) =>
      _$SleepLogFromJson(json);
}
