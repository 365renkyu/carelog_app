import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';

/// 欠席連絡定型文のプレースホルダー置換
///
/// 対応プレースホルダー:
///   {date}         → 日付 (例: 3月5日)
///   {startTime}    → 開始時刻 (例: 10:00)
///   {endTime}      → 終了時刻 (例: 12:00)
///   {facilityName} → 施設名
class TemplateFormatter {
  TemplateFormatter._();

  static String format(String template, TherapySchedule schedule) {
    final date = DateTime.parse(schedule.date).toAbsenceDate();
    return template
        .replaceAll('{date}', date)
        .replaceAll('{startTime}', schedule.startTime)
        .replaceAll('{endTime}', schedule.endTime)
        .replaceAll('{facilityName}', schedule.facilityName);
  }
}
