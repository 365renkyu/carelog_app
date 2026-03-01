import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';

/// 欠席連絡定型文のプレースホルダー置換
///
/// 対応プレースホルダー:
///   [日付]    例: 3月5日(月)
///   [開始時刻] 例: 10:00
///   [終了時刻] 例: 12:00
///   [事業所名] 例： リタリコジュニア新宿教室
class TemplateFormatter {
  TemplateFormatter._();

  static String format(String template, TherapySchedule schedule) {
    final date = DateTime.parse(schedule.date).toAbsenceDate();
    return template
        .replaceAll('[日付]', date)
        .replaceAll('[開始時刻]', schedule.startTime)
        .replaceAll('[終了時刻]', schedule.endTime)
        .replaceAll('[事業所名]', schedule.facilityName);
  }
}
