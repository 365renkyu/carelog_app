import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

/// 期間指定エクスポート用の記録詳細リスト
final exportDetailsProvider =
    FutureProvider.family<List<DailyRecordDetail>, ({String from, String to})>(
  (ref, range) async {
    final childId = ref.read(currentChildIdProvider);
    final repo = ref.read(recordRepositoryProvider);
    final records =
        await repo.getRecordsByDateRange(childId, range.from, range.to);

    final details = <DailyRecordDetail>[];
    for (final record in records) {
      final detail = await repo.getDetail(childId, record.date);
      if (detail != null) details.add(detail);
    }
    return details;
  },
);
