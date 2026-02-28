import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/data/database/dao/absence_template_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/daily_record_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/meal_log_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/sleep_log_dao.dart';
import 'package:ikuji_kiroku_app/data/database/dao/therapy_schedule_dao.dart';
import 'package:ikuji_kiroku_app/data/repositories/absence_template_repository.dart';
import 'package:ikuji_kiroku_app/data/repositories/absence_template_repository_impl.dart';
import 'package:ikuji_kiroku_app/data/repositories/record_repository.dart';
import 'package:ikuji_kiroku_app/data/repositories/record_repository_impl.dart';
import 'package:ikuji_kiroku_app/data/repositories/therapy_schedule_repository.dart';
import 'package:ikuji_kiroku_app/data/repositories/therapy_schedule_repository_impl.dart';

// ─── DAOs ────────────────────────────────────────────────────────────────────

final dailyRecordDaoProvider = Provider<DailyRecordDao>(
  (_) => const DailyRecordDao(),
);

final sleepLogDaoProvider = Provider<SleepLogDao>(
  (_) => const SleepLogDao(),
);

final mealLogDaoProvider = Provider<MealLogDao>(
  (_) => const MealLogDao(),
);

final therapyScheduleDaoProvider = Provider<TherapyScheduleDao>(
  (_) => const TherapyScheduleDao(),
);

final absenceTemplateDaoProvider = Provider<AbsenceTemplateDao>(
  (_) => const AbsenceTemplateDao(),
);

// ─── Repositories ────────────────────────────────────────────────────────────

final recordRepositoryProvider = Provider<RecordRepository>((ref) {
  return RecordRepositoryImpl(
    dailyRecordDao: ref.read(dailyRecordDaoProvider),
    sleepLogDao: ref.read(sleepLogDaoProvider),
    mealLogDao: ref.read(mealLogDaoProvider),
  );
});

final therapyScheduleRepositoryProvider =
    Provider<TherapyScheduleRepository>((ref) {
  return TherapyScheduleRepositoryImpl(
    dao: ref.read(therapyScheduleDaoProvider),
  );
});

final absenceTemplateRepositoryProvider =
    Provider<AbsenceTemplateRepository>((ref) {
  return AbsenceTemplateRepositoryImpl(
    dao: ref.read(absenceTemplateDaoProvider),
  );
});

// 現在の操作対象の子供ID（将来の複数人対応に向けたシングルトン）
final currentChildIdProvider = Provider<String>((_) => 'default_child');
