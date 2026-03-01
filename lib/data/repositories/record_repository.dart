import 'package:ikuji_kiroku_app/data/models/daily_record.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';

abstract class RecordRepository {
  Future<DailyRecordDetail?> getDetail(String childId, String date);
  Future<List<DailyRecord>> getRecordsByDateRange(
    String childId,
    String from,
    String to,
  );
  Future<List<String>> getRecordedDates(String childId);
  Future<void> saveRecord(DailyRecord record);
  Future<void> deleteRecord(String recordId);

  Future<void> saveSleepLog(SleepLog log);
  Future<void> updateSleepLog(SleepLog log);
  Future<void> deleteSleepLog(String logId);
  Future<void> deleteAllSleepLogs(String dailyRecordId);

  Future<void> saveMealLog(MealLog log);
  Future<void> updateMealLog(MealLog log);
  Future<void> deleteMealLog(String logId);
  Future<void> deleteAllMealLogs(String dailyRecordId);
}
