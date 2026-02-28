import 'package:sqflite/sqflite.dart';
import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record.dart';

class DailyRecordDao {
  const DailyRecordDao();

  static const _table = 'daily_records';

  Future<DailyRecord?> findByDate(String childId, String date) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'childId = ? AND date = ?',
      whereArgs: [childId, date],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return DailyRecord.fromJson(rows.first);
  }

  /// 期間内の記録を日付昇順で返す
  Future<List<DailyRecord>> findByDateRange(
    String childId,
    String from,
    String to,
  ) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'childId = ? AND date >= ? AND date <= ?',
      whereArgs: [childId, from, to],
      orderBy: 'date ASC',
    );
    return rows.map(DailyRecord.fromJson).toList();
  }

  /// 記録がある日付一覧（カレンダーのマーキング用）
  Future<List<String>> findRecordedDates(String childId) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      columns: ['date'],
      where: 'childId = ?',
      whereArgs: [childId],
    );
    return rows.map((r) => r['date'] as String).toList();
  }

  Future<void> upsert(DailyRecord record) async {
    final db = await AppDatabase.instance.database;
    await db.insert(
      _table,
      record.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
