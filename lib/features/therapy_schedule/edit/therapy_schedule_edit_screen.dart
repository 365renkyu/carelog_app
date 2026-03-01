import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';
import 'package:ikuji_kiroku_app/features/calendar/calendar_provider.dart';
import 'package:ikuji_kiroku_app/features/therapy_schedule/edit/therapy_schedule_edit_provider.dart';
import 'package:ikuji_kiroku_app/shared/widgets/time_picker_bottom_sheet.dart';

class TherapyScheduleEditScreen extends ConsumerStatefulWidget {
  const TherapyScheduleEditScreen({super.key, this.args});

  final TherapyScheduleEditArgs? args;

  @override
  ConsumerState<TherapyScheduleEditScreen> createState() =>
      _TherapyScheduleEditScreenState();
}

class _TherapyScheduleEditScreenState
    extends ConsumerState<TherapyScheduleEditScreen> {
  late final TextEditingController _facilityNameController;
  late final TextEditingController _memoController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _facilityNameController = TextEditingController();
    _memoController = TextEditingController();
  }

  @override
  void dispose() {
    _facilityNameController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(therapyScheduleEditProvider(widget.args));
    final notifier =
        ref.read(therapyScheduleEditProvider(widget.args).notifier);
    final isNew = widget.args?.scheduleId == null;
    final childName =
        ref.watch(currentChildProvider).valueOrNull?.name ?? '';

    // 既存データをコントローラに反映（初回のみ）
    if (!_initialized && state.existingId != null) {
      _facilityNameController.text = state.facilityName;
      _memoController.text = state.memo ?? '';
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 120,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BackButton(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                childName,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
        title: Text(isNew ? 'スケジュール追加' : 'スケジュール編集'),
        centerTitle: true,
        actions: [
          if (!isNew)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              tooltip: AppStrings.delete,
              onPressed: () => _confirmDelete(context, notifier),
            ),
        ],
      ),
      body: state.isSaving
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // 日付
                      _DateField(
                        date: state.date,
                        onChanged: notifier.setDate,
                      ),
                      const SizedBox(height: 16),

                      // 施設名
                      TextFormField(
                        controller: _facilityNameController,
                        decoration: const InputDecoration(
                          labelText: AppStrings.facilityName,
                        ),
                        onChanged: notifier.setFacilityName,
                      ),
                      const SizedBox(height: 16),

                      // 開始・終了時刻
                      Row(
                        children: [
                          Expanded(
                            child: _TimeField(
                              label: '開始時刻',
                              value: state.startTime,
                              onChanged: notifier.setStartTime,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _TimeField(
                              label: '終了時刻',
                              value: state.endTime,
                              onChanged: notifier.setEndTime,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // メモ
                      TextFormField(
                        controller: _memoController,
                        decoration: const InputDecoration(
                          labelText: '${AppStrings.scheduleMemo}（任意）',
                        ),
                        onChanged: notifier.setMemo,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // ── 繰り返し設定 ────────────────────────────────────
                      const Divider(),
                      const SizedBox(height: 8),
                      Text('繰り返し',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: state.repeatType,
                        decoration: const InputDecoration(labelText: '繰り返しの種類'),
                        items: const [
                          DropdownMenuItem(
                              value: 'none', child: Text('繰り返さない')),
                          DropdownMenuItem(value: 'daily', child: Text('毎日')),
                          DropdownMenuItem(value: 'weekly', child: Text('毎週')),
                          DropdownMenuItem(value: 'monthly', child: Text('毎月')),
                        ],
                        onChanged: (v) {
                          if (v != null) notifier.setRepeatType(v);
                        },
                      ),
                      if (state.repeatType == 'weekly') ...[
                        const SizedBox(height: 12),
                        DropdownButtonFormField<int>(
                          value: state.repeatDayOfWeek,
                          decoration: const InputDecoration(labelText: '曜日'),
                          items: const [
                            DropdownMenuItem(value: 0, child: Text('月曜日')),
                            DropdownMenuItem(value: 1, child: Text('火曜日')),
                            DropdownMenuItem(value: 2, child: Text('水曜日')),
                            DropdownMenuItem(value: 3, child: Text('木曜日')),
                            DropdownMenuItem(value: 4, child: Text('金曜日')),
                            DropdownMenuItem(value: 5, child: Text('土曜日')),
                            DropdownMenuItem(value: 6, child: Text('日曜日')),
                          ],
                          onChanged: (v) => notifier.setRepeatDayOfWeek(v),
                        ),
                      ],
                      if (state.repeatType != 'none') ...[
                        const SizedBox(height: 12),
                        _RepeatUntilField(
                          value: state.repeatUntil,
                          onChanged: notifier.setRepeatUntil,
                        ),
                      ],
                      const SizedBox(height: 32),

                      ElevatedButton(
                        onPressed: notifier.isValid
                            ? () => _save(context, notifier)
                            : null,
                        child: const Text(AppStrings.save),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _save(
    BuildContext context,
    TherapyScheduleEditNotifier notifier,
  ) async {
    // 開始〜終了時刻バリデーション
    final state = ref.read(therapyScheduleEditProvider(widget.args));
    if (state.startTime.isNotEmpty && state.endTime.isNotEmpty) {
      final startParts = state.startTime.split(':');
      final endParts = state.endTime.split(':');
      final startMin = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
      final endMin = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
      if (startMin >= endMin) {
        if (context.mounted) {
          await showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text('開始時刻が終了時刻より後になっています'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
        return;
      }
    }

    // 同日スケジュールの重複チェック
    final existingCount = await notifier.countExistingOnDate();
    if (existingCount > 0 && context.mounted) {
      final confirmed = await _showDuplicateWarning(context);
      if (!confirmed) return;
    }

    await notifier.save();
    if (context.mounted) {
      // カレンダーの表示を更新
      ref.invalidate(monthSchedulesProvider);
      Navigator.pop(context, true);
    }
  }

  Future<bool> _showDuplicateWarning(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.scheduleWarningTitle),
        content: const Text(AppStrings.scheduleWarningBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.scheduleWarningCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppStrings.scheduleWarningConfirm),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _confirmDelete(
    BuildContext context,
    TherapyScheduleEditNotifier notifier,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await notifier.delete();
      if (context.mounted) {
        ref.invalidate(monthSchedulesProvider);
        Navigator.pop(context, true);
      }
    }
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(labelText: '日付'),
        child: Text(date.toDisplayDate()),
      ),
    );
  }
}

class _RepeatUntilField extends StatelessWidget {
  const _RepeatUntilField({required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final initial = value != null
            ? DateTime.parse(value!)
            : DateTime.now().add(const Duration(days: 90));
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onChanged(picked.toIso8601String().substring(0, 10));
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: '繰り返し終了日（任意）',
          suffixIcon: value != null
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => onChanged(null),
                )
              : null,
        ),
        child: Text(
          value ?? '設定なし（無期限）',
          style: TextStyle(
            color: value != null ? null : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final display = value.isNotEmpty ? value : '--:--';
    return InkWell(
      onTap: () async {
        final initial = value.isNotEmpty
            ? TimeOfDay(
                hour: int.parse(value.split(':')[0]),
                minute: int.parse(value.split(':')[1]),
              )
            : null;
        final picked = await showTimePickerBottomSheet(
          context: context,
          label: label,
          initialTime: initial,
        );
        if (picked != null) {
          onChanged(
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}',
          );
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(
          display,
          style: TextStyle(
            color: value.isEmpty ? AppColors.textSecondary : null,
          ),
        ),
      ),
    );
  }
}
