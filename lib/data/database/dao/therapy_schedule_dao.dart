import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';

class TherapyScheduleDao {
  const TherapyScheduleDao();

  static const _table = 'therapy_schedules';

  Future<List<TherapySchedule>> findByDate(
    String childId,
    String date,
  ) async {
    final db = await AppDatabase.instance.database;
    final targetDate = DateTime.parse(date);

    // 通常スケジュール（当日）
    final rows = await db.query(
      _table,
      where: "childId = ? AND date = ? AND repeatType = 'none'",
      whereArgs: [childId, date],
      orderBy: 'startTime ASC',
    );
    final direct = rows.map(TherapySchedule.fromJson).toList();

    // 毎週繰り返し
    final weekday = targetDate.weekday - 1; // 0=月〜6=日
    final weeklyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'weekly' AND repeatDayOfWeek = ? "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, weekday, date, date],
      orderBy: 'startTime ASC',
    );
    final weekly = weeklyRows
        .map(TherapySchedule.fromJson)
        .map((s) => s.copyWith(date: date))
        .toList();

    // 毎日繰り返し
    final dailyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'daily' "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, date, date],
      orderBy: 'startTime ASC',
    );
    final daily = dailyRows
        .map(TherapySchedule.fromJson)
        .map((s) => s.copyWith(date: date))
        .toList();

    // 毎月繰り返し（同じ日付の日、例: 毎月15日）
    final dayOfMonth = targetDate.day;
    final monthlyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'monthly' "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, date, date],
      orderBy: 'startTime ASC',
    );
    final monthly = monthlyRows
        .map(TherapySchedule.fromJson)
        .where((s) {
          final originDay = DateTime.parse(s.date).day;
          return originDay == dayOfMonth;
        })
        .map((s) => s.copyWith(date: date))
        .toList();

    return [...direct, ...weekly, ...daily, ...monthly]
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Future<List<TherapySchedule>> findByDateRange(
    String childId,
    String from,
    String to,
  ) async {
    final db = await AppDatabase.instance.database;
    final fromDate = DateTime.parse(from);
    final toDate = DateTime.parse(to);

    // 通常スケジュール
    final rows = await db.query(
      _table,
      where: "childId = ? AND date >= ? AND date <= ? AND repeatType = 'none'",
      whereArgs: [childId, from, to],
      orderBy: 'date ASC, startTime ASC',
    );
    final direct = rows.map(TherapySchedule.fromJson).toList();

    // 毎週繰り返しを期間内で展開
    final weeklyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'weekly' "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, to, from],
      orderBy: 'startTime ASC',
    );
    final weeklyTemplates = weeklyRows.map(TherapySchedule.fromJson).toList();

    // 毎日繰り返しを期間内で展開
    final dailyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'daily' "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, to, from],
      orderBy: 'startTime ASC',
    );
    final dailyTemplates = dailyRows.map(TherapySchedule.fromJson).toList();

    // 毎月繰り返しを期間内で展開
    final monthlyRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'monthly' "
          "AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, to, from],
      orderBy: 'startTime ASC',
    );
    final monthlyTemplates = monthlyRows.map(TherapySchedule.fromJson).toList();

    final expanded = <TherapySchedule>[];

    for (final tmpl in weeklyTemplates) {
      final startDate = DateTime.parse(tmpl.date);
      final endDate = tmpl.repeatUntil != null
          ? DateTime.parse(tmpl.repeatUntil!)
          : toDate;
      final dayOfWeek = tmpl.repeatDayOfWeek;
      if (dayOfWeek == null) continue;
      DateTime cur = fromDate;
      while (!cur.isAfter(toDate) && !cur.isAfter(endDate)) {
        if (!cur.isBefore(startDate) && (cur.weekday - 1) == dayOfWeek) {
          final dateKey = cur.toIso8601String().substring(0, 10);
          expanded.add(tmpl.copyWith(date: dateKey));
        }
        cur = cur.add(const Duration(days: 1));
      }
    }

    for (final tmpl in dailyTemplates) {
      final startDate = DateTime.parse(tmpl.date);
      final endDate = tmpl.repeatUntil != null
          ? DateTime.parse(tmpl.repeatUntil!)
          : toDate;
      DateTime cur = fromDate.isBefore(startDate) ? startDate : fromDate;
      while (!cur.isAfter(toDate) && !cur.isAfter(endDate)) {
        final dateKey = cur.toIso8601String().substring(0, 10);
        expanded.add(tmpl.copyWith(date: dateKey));
        cur = cur.add(const Duration(days: 1));
      }
    }

    for (final tmpl in monthlyTemplates) {
      final startDate = DateTime.parse(tmpl.date);
      final endDate = tmpl.repeatUntil != null
          ? DateTime.parse(tmpl.repeatUntil!)
          : toDate;
      final dayOfMonth = startDate.day;
      // 期間内の各月について同日付を展開
      int year = fromDate.year;
      int month = fromDate.month;
      while (true) {
        // その月の最終日を超えないようにクランプ
        final lastDay = DateTime(year, month + 1, 0).day;
        final targetDay = dayOfMonth <= lastDay ? dayOfMonth : lastDay;
        final candidate = DateTime(year, month, targetDay);
        if (candidate.isAfter(toDate) || candidate.isAfter(endDate)) break;
        if (!candidate.isBefore(fromDate) && !candidate.isBefore(startDate)) {
          final dateKey = candidate.toIso8601String().substring(0, 10);
          expanded.add(tmpl.copyWith(date: dateKey));
        }
        month++;
        if (month > 12) {
          month = 1;
          year++;
        }
      }
    }

    final all = [...direct, ...expanded]
      ..sort((a, b) {
        final d = a.date.compareTo(b.date);
        return d != 0 ? d : a.startTime.compareTo(b.startTime);
      });
    return all;
  }

  Future<TherapySchedule?> findById(String id) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return TherapySchedule.fromJson(rows.first);
  }

  /// 同日の既存スケジュール数（重複チェック用）
  Future<int> countByDate(String childId, String date) async {
    final db = await AppDatabase.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as cnt FROM $_table WHERE childId = ? AND date = ?',
      [childId, date],
    );
    return result.first['cnt'] as int;
  }

  Future<void> insert(TherapySchedule schedule) async {
    final db = await AppDatabase.instance.database;
    await db.insert(_table, schedule.toJson());
  }

  Future<void> update(TherapySchedule schedule) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      _table,
      schedule.toJson(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
