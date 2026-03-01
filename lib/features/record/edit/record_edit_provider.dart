import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

part 'record_edit_provider.freezed.dart';

@freezed
class RecordEditState with _$RecordEditState {
  const factory RecordEditState({
    @Default(0) int mood,
    @Default([]) List<SleepLog> sleepLogs,
    @Default([]) List<MealLog> mealLogs,
    String? notes,
    String? achievements,
    String? cuteMoments,
    String? concerns,
    String? therapyMemo,
    @Default(false) bool isSaving,
    String? existingRecordId,
  }) = _RecordEditState;
}

class RecordEditNotifier extends AutoDisposeFamilyNotifier<RecordEditState, DateTime> {
  static const _uuid = Uuid();

  @override
  RecordEditState build(DateTime arg) {
    _loadExisting();
    return const RecordEditState();
  }

  Future<void> _loadExisting() async {
    final childId = ref.read(currentChildIdProvider);
    final detail = await ref
        .read(recordRepositoryProvider)
        .getDetail(childId, arg.toDateKey()); // arg = 編集対象の DateTime
    if (detail != null) {
      state = RecordEditState(
        mood: detail.record.mood,
        sleepLogs: detail.sleepLogs,
        mealLogs: detail.mealLogs,
        notes: detail.record.notes,
        achievements: detail.record.achievements,
        cuteMoments: detail.record.cuteMoments,
        concerns: detail.record.concerns,
        therapyMemo: detail.record.therapyMemo,
        existingRecordId: detail.record.id,
      );
    }
  }

  void setMood(int mood) => state = state.copyWith(mood: mood);
  void setNotes(String v) => state = state.copyWith(notes: v.isEmpty ? null : v);
  void setAchievements(String v) =>
      state = state.copyWith(achievements: v.isEmpty ? null : v);
  void setCuteMoments(String v) =>
      state = state.copyWith(cuteMoments: v.isEmpty ? null : v);
  void setConcerns(String v) =>
      state = state.copyWith(concerns: v.isEmpty ? null : v);
  void setTherapyMemo(String v) =>
      state = state.copyWith(therapyMemo: v.isEmpty ? null : v);

  // ── 睡眠ログ操作 ──────────────────────────────────
  void addSleepLog(SleepLog log) {
    final logs = [...state.sleepLogs, log]
      ..sort((a, b) => a.sleepStartTime.compareTo(b.sleepStartTime));
    state = state.copyWith(sleepLogs: logs);
  }

  void updateSleepLog(SleepLog log) {
    final logs = state.sleepLogs.map((l) => l.id == log.id ? log : l).toList()
      ..sort((a, b) => a.sleepStartTime.compareTo(b.sleepStartTime));
    state = state.copyWith(sleepLogs: logs);
  }

  void removeSleepLog(String id) {
    state = state.copyWith(
      sleepLogs: state.sleepLogs.where((l) => l.id != id).toList(),
    );
  }

  // ── 食事ログ操作 ──────────────────────────────────
  void addMealLog(MealLog log) {
    final logs = [...state.mealLogs, log]
      ..sort((a, b) => a.mealTime.compareTo(b.mealTime));
    state = state.copyWith(mealLogs: logs);
  }

  void updateMealLog(MealLog log) {
    state = state.copyWith(
      mealLogs: state.mealLogs.map((l) => l.id == log.id ? log : l).toList(),
    );
  }

  void removeMealLog(String id) {
    state = state.copyWith(
      mealLogs: state.mealLogs.where((l) => l.id != id).toList(),
    );
  }

  /// 新規SleepLogのID付きインスタンスを生成する
  SleepLog buildNewSleepLog({
    required String dailyRecordId,
    required String childId,
    String? bedtimeStartTime,
    required String sleepStartTime,
    String? sleepEndTime,
  }) {
    return SleepLog(
      id: _uuid.v4(),
      dailyRecordId: dailyRecordId,
      childId: childId,
      bedtimeStartTime: bedtimeStartTime,
      sleepStartTime: sleepStartTime,
      sleepEndTime: sleepEndTime,
    );
  }

  /// 新規MealLogのID付きインスタンスを生成する
  MealLog buildNewMealLog({
    required String dailyRecordId,
    required String childId,
    required String mealTime,
    required String content,
  }) {
    return MealLog(
      id: _uuid.v4(),
      dailyRecordId: dailyRecordId,
      childId: childId,
      mealTime: mealTime,
      content: content,
    );
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    try {
      final childId = ref.read(currentChildIdProvider);
      final repo = ref.read(recordRepositoryProvider);
      final now = DateTime.now().toIso8601();
      final recordId = state.existingRecordId ?? _uuid.v4();

      final record = DailyRecord(
        id: recordId,
        childId: childId,
        date: arg.toDateKey(), // arg = 編集対象の DateTime
        mood: state.mood,
        notes: state.notes,
        achievements: state.achievements,
        cuteMoments: state.cuteMoments,
        concerns: state.concerns,
        therapyMemo: state.therapyMemo,
        createdAt: now,
        updatedAt: now,
      );

      await repo.saveRecord(record);

      // 既存レコードのログを全削除して再挿入（新規追加/編集/削除を一括反映）
      if (state.existingRecordId != null) {
        await repo.deleteAllSleepLogs(recordId);
        await repo.deleteAllMealLogs(recordId);
      }

      for (final log in state.sleepLogs) {
        await repo.saveSleepLog(log.copyWith(
          dailyRecordId: recordId,
          childId: childId,
        ));
      }

      for (final log in state.mealLogs) {
        await repo.saveMealLog(log.copyWith(
          dailyRecordId: recordId,
          childId: childId,
        ));
      }
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

final recordEditProvider = AutoDisposeNotifierProviderFamily<
    RecordEditNotifier, RecordEditState, DateTime>(
  RecordEditNotifier.new,
);
