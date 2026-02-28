import 'package:ikuji_kiroku_app/data/database/dao/absence_template_dao.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';
import 'package:ikuji_kiroku_app/data/repositories/absence_template_repository.dart';

class AbsenceTemplateRepositoryImpl implements AbsenceTemplateRepository {
  const AbsenceTemplateRepositoryImpl({required this.dao});

  final AbsenceTemplateDao dao;

  @override
  Future<List<AbsenceTemplate>> getAll(String childId) =>
      dao.findAll(childId);

  @override
  Future<AbsenceTemplate?> getById(String id) => dao.findById(id);

  @override
  Future<void> save(AbsenceTemplate template) => dao.insert(template);

  @override
  Future<void> update(AbsenceTemplate template) => dao.update(template);

  @override
  Future<void> delete(String id) => dao.delete(id);
}
