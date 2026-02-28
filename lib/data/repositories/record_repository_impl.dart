import 'package:ikuji_kiroku_app/data/database/dao/daily_record_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/meal_log_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/sleep_log_dao.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';
import 'package:ikuji_kiroku_app/data/repositories/record_repository.dart';

class RecordRepositoryImpl implements RecordRepository {
  const RecordRepositoryImpl({
    required this.dailyRecordDao,
    required this.sleepLogDao,
    required this.mealLogDao,
  });

  final DailyRecordDao dailyRecordDao;
  final SleepLogDao sleepLogDao;
  final MealLogDao mealLogDao;

  @override
  Future<DailyRecordDetail?> getDetail(String childId, String date) async {
    final record = await dailyRecordDao.findByDate(childId, date);
    if (record == null) return null;
    final sleepLogs = await sleepLogDao.findByDailyRecordId(record.id);
    final mealLogs = await mealLogDao.findByDailyRecordId(record.id);
    return DailyRecordDetail(
      record: record,
      sleepLogs: sleepLogs,
      mealLogs: mealLogs,
    );
  }

  @override
  Future<List<DailyRecord>> getRecordsByDateRange(
    String childId,
    String from,
    String to,
  ) =>
      dailyRecordDao.findByDateRange(childId, from, to);

  @override
  Future<List<String>> getRecordedDates(String childId) =>
      dailyRecordDao.findRecordedDates(childId);

  @override
  Future<void> saveRecord(DailyRecord record) =>
      dailyRecordDao.upsert(record);

  @override
  Future<void> deleteRecord(String recordId) =>
      dailyRecordDao.delete(recordId);

  @override
  Future<void> saveSleepLog(SleepLog log) => sleepLogDao.insert(log);

  @override
  Future<void> updateSleepLog(SleepLog log) => sleepLogDao.update(log);

  @override
  Future<void> deleteSleepLog(String logId) => sleepLogDao.delete(logId);

  @override
  Future<void> saveMealLog(MealLog log) => mealLogDao.insert(log);

  @override
  Future<void> updateMealLog(MealLog log) => mealLogDao.update(log);

  @override
  Future<void> deleteMealLog(String logId) => mealLogDao.delete(logId);
}
