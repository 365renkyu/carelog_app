import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

/// 特定日の記録詳細（日付キーで管理）
final recordDetailProvider =
    FutureProvider.family<DailyRecordDetail?, String>((ref, dateKey) async {
  final childId = ref.read(currentChildIdProvider);
  return ref.read(recordRepositoryProvider).getDetail(childId, dateKey);
});

/// 記録詳細を再読み込みするためのヘルパー
extension RecordDetailRefresh on WidgetRef {
  void refreshRecordDetail(DateTime date) {
    invalidate(recordDetailProvider(date.toDateKey()));
  }
}
