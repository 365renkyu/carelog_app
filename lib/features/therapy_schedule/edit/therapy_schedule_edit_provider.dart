import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

part 'therapy_schedule_edit_provider.freezed.dart';

/// スケジュール編集画面へのルート引数
class TherapyScheduleEditArgs {
  const TherapyScheduleEditArgs({this.scheduleId, required this.initialDate});

  final String? scheduleId;     // null = 新規
  final DateTime initialDate;
}

@freezed
class TherapyScheduleEditState with _$TherapyScheduleEditState {
  const factory TherapyScheduleEditState({
    required DateTime date,
    @Default('') String startTime,
    @Default('') String endTime,
    @Default('') String facilityName,
    String? memo,
    @Default('none') String repeatType,     // 'none' | 'weekly'
    int? repeatDayOfWeek,                   // 0=月〜6=日
    String? repeatUntil,                    // 'YYYY-MM-DD'
    @Default(false) bool isSaving,
    String? existingId,
  }) = _TherapyScheduleEditState;
}

class TherapyScheduleEditNotifier
    extends AutoDisposeFamilyNotifier<TherapyScheduleEditState, TherapyScheduleEditArgs?> {
  static const _uuid = Uuid();

  @override
  TherapyScheduleEditState build(TherapyScheduleEditArgs? arg) {
    final initialDate = arg?.initialDate ?? DateTime.now();
    if (arg?.scheduleId != null) _loadExisting(arg!.scheduleId!);
    return TherapyScheduleEditState(date: initialDate);
  }

  Future<void> _loadExisting(String id) async {
    final existing = await ref
        .read(therapyScheduleRepositoryProvider)
        .getById(id);
    if (existing != null) {
      state = state.copyWith(
        date: DateTime.parse(existing.date),
        startTime: existing.startTime,
        endTime: existing.endTime,
        facilityName: existing.facilityName,
        memo: existing.memo,
        repeatType: existing.repeatType,
        repeatDayOfWeek: existing.repeatDayOfWeek,
        repeatUntil: existing.repeatUntil,
        existingId: existing.id,
      );
    }
  }

  void setDate(DateTime d) => state = state.copyWith(date: d);
  void setStartTime(String t) => state = state.copyWith(startTime: t);
  void setEndTime(String t) => state = state.copyWith(endTime: t);
  void setFacilityName(String v) => state = state.copyWith(facilityName: v);
  void setMemo(String v) => state = state.copyWith(memo: v.isEmpty ? null : v);
  void setRepeatType(String v) {
    state = state.copyWith(
      repeatType: v,
      // weekly 以外では曜日をクリア
      repeatDayOfWeek: v == 'weekly' ? (state.repeatDayOfWeek ?? state.date.weekday - 1) : null,
    );
  }
  void setRepeatDayOfWeek(int? v) => state = state.copyWith(repeatDayOfWeek: v);
  void setRepeatUntil(String? v) => state = state.copyWith(repeatUntil: v);

  bool get isValid =>
      state.startTime.isNotEmpty &&
      state.endTime.isNotEmpty &&
      state.facilityName.isNotEmpty &&
      (state.repeatType != 'weekly' || state.repeatDayOfWeek != null);

  /// 保存前に同日の既存スケジュール件数を返す（警告ダイアログ制御用）
  Future<int> countExistingOnDate() async {
    final childId = ref.read(currentChildIdProvider);
    final count = await ref
        .read(therapyScheduleRepositoryProvider)
        .countByDate(childId, state.date.toDateKey());
    // 編集中は自分自身を除く
    return state.existingId != null ? count - 1 : count;
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    try {
      final childId = ref.read(currentChildIdProvider);
      final repo = ref.read(therapyScheduleRepositoryProvider);
      final now = DateTime.now().toIso8601();

      final schedule = TherapySchedule(
        id: state.existingId ?? _uuid.v4(),
        childId: childId,
        date: state.date.toDateKey(),
        startTime: state.startTime,
        endTime: state.endTime,
        facilityName: state.facilityName,
        memo: state.memo,
        repeatType: state.repeatType,
        repeatDayOfWeek: state.repeatDayOfWeek,
        repeatUntil: state.repeatUntil,
        createdAt: now,
        updatedAt: now,
      );

      if (state.existingId != null) {
        await repo.update(schedule);
      } else {
        await repo.save(schedule);
      }
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  Future<void> delete() async {
    if (state.existingId == null) return;
    await ref.read(therapyScheduleRepositoryProvider).delete(state.existingId!);
  }
}

final therapyScheduleEditProvider = AutoDisposeNotifierProviderFamily<
    TherapyScheduleEditNotifier,
    TherapyScheduleEditState,
    TherapyScheduleEditArgs?>(
  TherapyScheduleEditNotifier.new,
);
