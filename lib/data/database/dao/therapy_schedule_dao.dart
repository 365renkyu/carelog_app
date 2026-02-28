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
    // 通常スケジュール（当日）
    final rows = await db.query(
      _table,
      where: "childId = ? AND date = ? AND repeatType = 'none'",
      whereArgs: [childId, date],
      orderBy: 'startTime ASC',
    );
    final direct = rows.map(TherapySchedule.fromJson).toList();

    // 繰り返しスケジュール（当日が範囲内かつ曜日一致）
    final targetDate = DateTime.parse(date);
    final weekday = targetDate.weekday - 1; // 0=月〜6=日
    final repeatRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'weekly' AND repeatDayOfWeek = ? AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, weekday, date, date],
      orderBy: 'startTime ASC',
    );
    final repeated = repeatRows
        .map(TherapySchedule.fromJson)
        // 仮想的な「この日」のインスタンスとして date を上書き
        .map((s) => s.copyWith(date: date))
        .toList();

    return [...direct, ...repeated]
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Future<List<TherapySchedule>> findByDateRange(
    String childId,
    String from,
    String to,
  ) async {
    final db = await AppDatabase.instance.database;
    // 通常スケジュール
    final rows = await db.query(
      _table,
      where: "childId = ? AND date >= ? AND date <= ? AND repeatType = 'none'",
      whereArgs: [childId, from, to],
      orderBy: 'date ASC, startTime ASC',
    );
    final direct = rows.map(TherapySchedule.fromJson).toList();

    // 繰り返しスケジュールを期間内で展開
    final repeatRows = await db.query(
      _table,
      where: "childId = ? AND repeatType = 'weekly' AND date <= ? AND (repeatUntil IS NULL OR repeatUntil >= ?)",
      whereArgs: [childId, to, from],
      orderBy: 'startTime ASC',
    );
    final repeatTemplates = repeatRows.map(TherapySchedule.fromJson).toList();

    final expanded = <TherapySchedule>[];
    final fromDate = DateTime.parse(from);
    final toDate = DateTime.parse(to);

    for (final tmpl in repeatTemplates) {
      final startDate = DateTime.parse(tmpl.date);
      final endDate = tmpl.repeatUntil != null
          ? DateTime.parse(tmpl.repeatUntil!)
          : toDate;
      final dayOfWeek = tmpl.repeatDayOfWeek; // 0=月〜6=日
      if (dayOfWeek == null) continue;

      // 期間内の該当曜日を列挙
      DateTime cur = fromDate;
      while (!cur.isAfter(toDate) && !cur.isAfter(endDate)) {
        if (!cur.isBefore(startDate) && (cur.weekday - 1) == dayOfWeek) {
          final dateKey = cur.toIso8601String().substring(0, 10);
          expanded.add(tmpl.copyWith(date: dateKey));
        }
        cur = cur.add(const Duration(days: 1));
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
