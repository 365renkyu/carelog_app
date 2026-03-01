import 'package:ikuji_kiroku_app/data/database/app_database.dart';
import 'package:ikuji_kiroku_app/data/models/child.dart';

class ChildDao {
  const ChildDao();

  static const _table = 'children';

  Future<Child?> findById(String id) async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Child.fromJson(rows.first);
  }

  Future<List<Child>> findAll() async {
    final db = await AppDatabase.instance.database;
    final rows = await db.query(_table, orderBy: 'createdAt ASC');
    return rows.map(Child.fromJson).toList();
  }

  Future<void> insert(Child child) async {
    final db = await AppDatabase.instance.database;
    await db.insert(_table, child.toJson());
  }

  Future<void> update(Child child) async {
    final db = await AppDatabase.instance.database;
    await db.update(
      _table,
      child.toJson(),
      where: 'id = ?',
      whereArgs: [child.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance.database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
