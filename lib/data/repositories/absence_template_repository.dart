import 'package:ikuji_kiroku_app/data/models/absence_template.dart';

abstract class AbsenceTemplateRepository {
  Future<List<AbsenceTemplate>> getAll(String childId);
  Future<AbsenceTemplate?> getById(String id);
  Future<void> save(AbsenceTemplate template);
  Future<void> update(AbsenceTemplate template);
  Future<void> delete(String id);
}
