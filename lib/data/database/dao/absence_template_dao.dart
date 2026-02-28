import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';

class AbsenceTemplateDao {
  const AbsenceTemplateDao();

  static const _table = 'absence_templates';

  Future<List<AbsenceTemplate>> findAll(String childId) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'childId = ?',
      whereArgs: [childId],
      orderBy: 'createdAt ASC',
    );
    return rows.map(AbsenceTemplate.fromJson).toList();
  }

  Future<AbsenceTemplate?> findById(String id) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return AbsenceTemplate.fromJson(rows.first);
  }

  Future<void> insert(AbsenceTemplate template) async {
    final db = await AppDatabase.instance.database;
    await db.insert(_table, template.toJson());
  }

  Future<void> update(AbsenceTemplate template) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      _table,
      template.toJson(),
      where: 'id = ?',
      whereArgs: [template.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
