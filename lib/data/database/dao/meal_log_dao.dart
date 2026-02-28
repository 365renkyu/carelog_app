import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';

class MealLogDao {
  const MealLogDao();

  static const _table = 'meal_logs';

  Future<List<MealLog>> findByDailyRecordId(String dailyRecordId) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'dailyRecordId = ?',
      whereArgs: [dailyRecordId],
      orderBy: 'mealTime ASC',
    );
    return rows.map(MealLog.fromJson).toList();
  }

  Future<void> insert(MealLog log) async {
    final db = await AppDatabase.instance.database;
    await db.insert(_table, log.toJson());
  }

  Future<void> update(MealLog log) async {
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
