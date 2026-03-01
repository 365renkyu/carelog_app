import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/models/mood.dart';
import 'package:ikuji_kiroku_app/features/export/export_field.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';

class RecordTextFormatter {
  RecordTextFormatter._();

  /// 1日分のテキストを生成する
  static String formatDay({
    required DateTime date,
    required DailyRecordDetail detail,
    required Set<ExportField> fields,
  }) {
    final buf = StringBuffer();
    buf.writeln('【${date.toDisplayDate()}】');

    _appendIfEnabled(buf, fields, ExportField.mood, () {
      final mood = Mood.fromValue(detail.record.mood);
      return '■機嫌: ${mood.label}\n';
    });

    _appendIfEnabled(buf, fields, ExportField.sleepLogs, () {
      if (detail.sleepLogs.isEmpty) return null;
      final lines = detail.sleepLogs.map((log) {
        final bedtime = log.bedtimeStartTime != null
            ? '寝かしつけ開始: ${DateTime.parse(log.bedtimeStartTime!).toDisplayTime()} / '
            : '';
        final start = DateTime.parse(log.sleepStartTime).toDisplayTime();
        final end = log.sleepEndTime != null
            ? DateTime.parse(log.sleepEndTime!).toDisplayTime()
            : '就寝中';
        return '  ${bedtime}入眠: $start → 起床: $end'; // ignore: unnecessary_brace_in_string_interps
      });
      return '■睡眠:\n${lines.join('\n')}\n';
    });

    _appendIfEnabled(buf, fields, ExportField.mealLogs, () {
      if (detail.mealLogs.isEmpty) return null;
      final lines = detail.mealLogs.map(
        (log) =>
            '  ${DateTime.parse(log.mealTime).toDisplayTime()}: ${log.content}',
      );
      return '■食事:\n${lines.join('\n')}\n';
    });

    _appendTextIfEnabled(buf, fields, ExportField.notes,
        '■${AppStrings.fieldNotes}', '${detail.record.notes}\n');
    _appendTextIfEnabled(buf, fields, ExportField.achievements,
        '■${AppStrings.fieldAchievements}', '${detail.record.achievements}\n');
    _appendTextIfEnabled(buf, fields, ExportField.cuteMoments,
        '■${AppStrings.fieldCuteMoments}', '${detail.record.cuteMoments}\n');
    _appendTextIfEnabled(buf, fields, ExportField.concerns,
        '■${AppStrings.fieldConcerns}', '${detail.record.concerns}\n');
    _appendTextIfEnabled(buf, fields, ExportField.therapyMemo,
        '■${AppStrings.fieldTherapyMemo}', '${detail.record.therapyMemo}\n');

    return buf.toString().trimRight();
  }

  /// 期間指定のテキストを生成する
  static String formatPeriod({
    required DateTime from,
    required DateTime to,
    required List<DailyRecordDetail> details,
    required Set<ExportField> fields,
  }) {
    final buf = StringBuffer();
    buf.writeln('【${from.toDisplayDate()} 〜 ${to.toDisplayDate()}】');
    buf.writeln('');

    for (final detail in details) {
      final date = DateTime.parse(detail.record.date);
      buf.writeln(formatDay(date: date, detail: detail, fields: fields));
      buf.writeln('');
    }

    return buf.toString().trimRight();
  }

  // ── helpers ────────────────────────────────────────────────────────────────

  static void _appendIfEnabled(
    StringBuffer buf,
    Set<ExportField> fields,
    ExportField field,
    String? Function() builder,
  ) {
    if (!fields.contains(field)) return;
    final text = builder();
    if (text != null) buf.writeln(text);
  }

  static void _appendTextIfEnabled(
    StringBuffer buf,
    Set<ExportField> fields,
    ExportField field,
    String label,
    String? value,
  ) {
    if (!fields.contains(field)) return;
    if (value == null || value.isEmpty) return;
    buf.writeln('$label:');
    buf.writeln(value);
  }
}
