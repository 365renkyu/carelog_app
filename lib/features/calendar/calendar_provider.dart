import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

/// カレンダーに表示する月の記録済み日付セット
final recordedDatesProvider = FutureProvider<Set<String>>((ref) async {
  final childId = ref.watch(currentChildIdProvider);
  final repo = ref.read(recordRepositoryProvider);
  final dates = await repo.getRecordedDates(childId);
  return dates.toSet();
});

/// 月単位のスケジュール一覧（カレンダーマーキング用）
final monthSchedulesProvider =
    FutureProvider.family<List<TherapySchedule>, DateTime>((ref, month) async {
  final childId = ref.watch(currentChildIdProvider);
  final repo = ref.read(therapyScheduleRepositoryProvider);
  final from =
      DateTime(month.year, month.month, 1).toIso8601String().substring(0, 10);
  final to = DateTime(month.year, month.month + 1, 0)
      .toIso8601String()
      .substring(0, 10);
  return repo.getByDateRange(childId, from, to);
});
