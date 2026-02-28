import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';

abstract class TherapyScheduleRepository {
  Future<List<TherapySchedule>> getByDate(String childId, String date);
  Future<List<TherapySchedule>> getByDateRange(
    String childId,
    String from,
    String to,
  );
  Future<TherapySchedule?> getById(String id);

  /// 同日の登録件数（保存前の重複チェック用）
  Future<int> countByDate(String childId, String date);

  Future<void> save(TherapySchedule schedule);
  Future<void> update(TherapySchedule schedule);
  Future<void> delete(String id);
}
