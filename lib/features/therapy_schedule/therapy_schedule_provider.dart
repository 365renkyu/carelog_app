import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

/// 指定日のスケジュール一覧
final daySchedulesProvider =
    FutureProvider.family<List<TherapySchedule>, String>((ref, dateKey) async {
  final childId = ref.read(currentChildIdProvider);
  return ref.read(therapyScheduleRepositoryProvider).getByDate(childId, dateKey);
});

/// 全スケジュール一覧（欠席連絡の選択用）
final upcomingSchedulesProvider =
    FutureProvider<List<TherapySchedule>>((ref) async {
  final childId = ref.read(currentChildIdProvider);
  final today = DateTime.now();
  final from = today.toIso8601String().substring(0, 10);
  // 3ヶ月先まで取得
  final to = DateTime(today.year, today.month + 3, today.day)
      .toIso8601String()
      .substring(0, 10);
  return ref
      .read(therapyScheduleRepositoryProvider)
      .getByDateRange(childId, from, to);
});
