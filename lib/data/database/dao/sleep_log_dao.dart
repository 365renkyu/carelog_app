import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';

class SleepLogDao {
  const SleepLogDao();

  static const _table = 'sleep_logs';

  Future<List<SleepLog>> findByDailyRecordId(String dailyRecordId) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'dailyRecordId = ?',
      whereArgs: [dailyRecordId],
      orderBy: 'sleepStartTime ASC',
    );
    return rows.map(SleepLog.fromJson).toList();
  }

  Future<List<SleepLog>> findByChildAndDateRange(
    String childId,
    String from,
    String to,
  ) async {
    final db = await AppDatabase.instance.database;
    // daily_records と JOIN して日付範囲で絞る
    final rows = await db.rawQuery('''
      SELECT sl.*
      FROM sleep_logs sl
      INNER JOIN daily_records dr ON sl.dailyRecordId = dr.id
      WHERE sl.childId = ? AND dr.date >= ? AND dr.date <= ?
      ORDER BY dr.date ASC, sl.sleepStartTime ASC
    ''', [childId, from, to]);
    return rows.map(SleepLog.fromJson).toList();
  }

  Future<void> insert(SleepLog log) async {
    final db = await AppDatabase.instance.database;
    await db.insert(_table, log.toJson());
  }

  Future<void> update(SleepLog log) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      _table,
      log.toJson(),
      where: 'id = ?',
      whereArgs: [log.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteByDailyRecordId(String dailyRecordId) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      _table,
      where: 'dailyRecordId = ?',
      whereArgs: [dailyRecordId],
    );
  }
}
