import 'package:ikuji_kiroku_app/data/database/dao/therapy_schedule_dao.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/data/repositories/therapy_schedule_repository.dart';

class TherapyScheduleRepositoryImpl implements TherapyScheduleRepository {
  const TherapyScheduleRepositoryImpl({required this.dao});

  final TherapyScheduleDao dao;

  @override
  Future<List<TherapySchedule>> getByDate(String childId, String date) =>
      dao.findByDate(childId, date);

  @override
  Future<List<TherapySchedule>> getByDateRange(
    String childId,
    String from,
    String to,
  ) =>
      dao.findByDateRange(childId, from, to);

  @override
  Future<TherapySchedule?> getById(String id) => dao.findById(id);

  @override
  Future<int> countByDate(String childId, String date) =>
      dao.countByDate(childId, date);

  @override
  Future<void> save(TherapySchedule schedule) => dao.insert(schedule);

  @override
  Future<void> update(TherapySchedule schedule) => dao.update(schedule);

  @override
  Future<void> delete(String id) => dao.delete(id);
}
