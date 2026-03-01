import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// SQLite 保存用キー 'YYYY-MM-DD'
  String toDateKey() => DateFormat('yyyy-MM-dd').format(this);

  /// 表示用日付 '2024年1月1日(月)'
  String toDisplayDate() => DateFormat('yyyy/M/d(E)', 'ja').format(this);

  /// 表示用月 '2024年1月'
  String toDisplayMonth() => DateFormat('yyyy年M月', 'ja').format(this);

  /// 表示用時刻 'HH:mm'
  String toDisplayTime() => DateFormat('HH:mm').format(this);

  /// 欠席連絡用 'M月d日(月)'
  String toAbsenceDate() => DateFormat('M月d日(E)', 'ja').format(this);

  /// ISO8601文字列に変換
  String toIso8601() => toIso8601String();

  /// その週の月曜日を返す
  DateTime get weekStart {
    final diff = weekday - DateTime.monday;
    return subtract(Duration(days: diff));
  }

  /// dateKeyが同じ日かどうか
  bool isSameDayAs(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

extension StringDateExtension on String {
  /// 'YYYY-MM-DD' → DateTime
  DateTime toDateTime() => DateTime.parse(this);

  /// ISO8601文字列 → DateTime
  DateTime toDateTimeFromIso() => DateTime.parse(this);
}
