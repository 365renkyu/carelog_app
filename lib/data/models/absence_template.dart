import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence_template.freezed.dart';
part 'absence_template.g.dart';

/// 欠席連絡定型文
///
/// 使用できるプレースホルダー:
///   {date}         → 日付 (例: 3月5日)
///   {startTime}    → 開始時刻 (例: 10:00)
///   {endTime}      → 終了時刻 (例: 12:00)
///   {facilityName} → 施設名
@freezed
class AbsenceTemplate with _$AbsenceTemplate {
  const factory AbsenceTemplate({
    required String id,
    required String childId,
    required String title,
    required String template,
    required String createdAt,
    required String updatedAt,
  }) = _AbsenceTemplate;

  factory AbsenceTemplate.fromJson(Map<String, dynamic> json) =>
      _$AbsenceTemplateFromJson(json);
}
