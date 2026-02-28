import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_record.freezed.dart';
part 'daily_record.g.dart';

@freezed
class DailyRecord with _$DailyRecord {
  const factory DailyRecord({
    required String id,
    required String childId,
    required String date,         // 'YYYY-MM-DD'
    required int mood,            // Mood.value
    String? notes,                // その日の様子
    String? achievements,         // できたこと
    String? cuteMoments,          // かわいいと感じたこと
    String? concerns,             // 課題・悩み
    String? therapyMemo,          // 療育メモ
    required String createdAt,
    required String updatedAt,
  }) = _DailyRecord;

  factory DailyRecord.fromJson(Map<String, dynamic> json) =>
      _$DailyRecordFromJson(json);
}
