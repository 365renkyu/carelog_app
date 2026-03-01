import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/meal_log.dart';
import 'package:ikuji_kiroku_app/data/models/mood.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';
import 'package:ikuji_kiroku_app/features/record/edit/record_edit_provider.dart';
import 'package:ikuji_kiroku_app/shared/widgets/mood_selector.dart';
import 'package:ikuji_kiroku_app/shared/widgets/section_header.dart';
import 'package:ikuji_kiroku_app/shared/widgets/sleep_time_range_tile.dart';
import 'package:ikuji_kiroku_app/shared/widgets/time_picker_bottom_sheet.dart';

class RecordEditScreen extends ConsumerStatefulWidget {
  const RecordEditScreen({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<RecordEditScreen> createState() => _RecordEditScreenState();
}

class _RecordEditScreenState extends ConsumerState<RecordEditScreen> {
  final _notesController = TextEditingController();
  final _achievementsController = TextEditingController();
  final _cuteMomentsController = TextEditingController();
  final _concernsController = TextEditingController();
  final _therapyMemoController = TextEditingController();

  bool _initialized = false;

  @override
  void dispose() {
    _notesController.dispose();
    _achievementsController.dispose();
    _cuteMomentsController.dispose();
    _concernsController.dispose();
    _therapyMemoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(recordEditProvider(widget.date).notifier);
    final state = ref.watch(recordEditProvider(widget.date));
    final childName = ref.watch(currentChildProvider).valueOrNull?.name ?? '';

    // 既存データをControllerに反映（初回のみ）
    if (!_initialized && state.existingRecordId != null) {
      _notesController.text = state.notes ?? '';
      _achievementsController.text = state.achievements ?? '';
      _cuteMomentsController.text = state.cuteMoments ?? '';
      _concernsController.text = state.concerns ?? '';
      _therapyMemoController.text = state.therapyMemo ?? '';
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
        title: Text(widget.date.toDisplayDate()),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: state.isSaving ? null : () => _save(notifier),
            child: const Text(AppStrings.save),
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
                      const SectionHeader(title: AppStrings.fieldMood),
                      MoodSelector(
                        selected: Mood.fromValue(state.mood),
                        onChanged: (mood) => notifier.setMood(mood.value),
                      ),
                      const SizedBox(height: 20),

                      // ── 睡眠 ─────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SectionHeader(title: AppStrings.fieldSleep),
                          TextButton.icon(
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('追加'),
                            onPressed: () =>
                                _showSleepLogDialog(context, notifier, state),
                          ),
                        ],
                      ),
                      ...state.sleepLogs.map(
                        (log) => SleepTimeRangeTile(
                          log: log,
                          onEdit: () => _showSleepLogDialog(
                              context, notifier, state,
                              log: log),
                          onDelete: () => notifier.removeSleepLog(log.id),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── 食事 ─────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SectionHeader(title: AppStrings.fieldMeal),
                          TextButton.icon(
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('追加'),
                            onPressed: () =>
                                _showMealLogDialog(context, notifier, state),
                          ),
                        ],
                      ),
                      ...state.mealLogs.map(
                        (log) => ListTile(
                          leading: const Icon(Icons.restaurant,
                              color: AppColors.primary),
                          title: Text(log.content),
                          subtitle: Text(
                              DateTime.parse(log.mealTime).toDisplayTime()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 20),
                                onPressed: () => _showMealLogDialog(
                                    context, notifier, state,
                                    log: log),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: AppColors.error),
                                onPressed: () => notifier.removeMealLog(log.id),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── テキストフィールド群 ──────────────────
                      _buildTextArea(
                        label: AppStrings.fieldNotes,
                        controller: _notesController,
                        onChanged: notifier.setNotes,
                      ),
                      const SizedBox(height: 16),
                      _buildTextArea(
                        label: AppStrings.fieldAchievements,
                        controller: _achievementsController,
                        onChanged: notifier.setAchievements,
                      ),
                      const SizedBox(height: 16),
                      _buildTextArea(
                        label: AppStrings.fieldCuteMoments,
                        controller: _cuteMomentsController,
                        onChanged: notifier.setCuteMoments,
                      ),
                      const SizedBox(height: 16),
                      _buildTextArea(
                        label: AppStrings.fieldConcerns,
                        controller: _concernsController,
                        onChanged: notifier.setConcerns,
                      ),
                      const SizedBox(height: 16),
                      _buildTextArea(
                        label: AppStrings.fieldTherapyMemo,
                        controller: _therapyMemoController,
                        onChanged: notifier.setTherapyMemo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTextArea({
    required String label,
    required TextEditingController controller,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          maxLines: 4,
          decoration: InputDecoration(hintText: '$label を入力'),
        ),
      ],
    );
  }

  Future<void> _save(RecordEditNotifier notifier) async {
    // テキストフィールドの最新値を反映
    notifier.setNotes(_notesController.text.trimRight());
    notifier.setAchievements(_achievementsController.text.trimRight());
    notifier.setCuteMoments(_cuteMomentsController.text.trimRight());
    notifier.setConcerns(_concernsController.text.trimRight());
    notifier.setTherapyMemo(_therapyMemoController.text.trimRight());

    await notifier.save();
    if (mounted) Navigator.pop(context);
  }

  void _showSleepLogDialog(
    BuildContext context,
    RecordEditNotifier notifier,
    RecordEditState state, {
    SleepLog? log,
  }) {
    final childId = ref.read(currentChildIdProvider);
    final recordId = state.existingRecordId ?? const Uuid().v4();
    showDialog<void>(
      context: context,
      builder: (_) => _SleepLogDialog(
        existingLog: log,
        childId: childId,
        dailyRecordId: recordId,
        notifier: notifier,
      ),
    );
  }

  void _showMealLogDialog(
    BuildContext context,
    RecordEditNotifier notifier,
    RecordEditState state, {
    MealLog? log,
  }) {
    final childId = ref.read(currentChildIdProvider);
    final recordId = state.existingRecordId ?? const Uuid().v4();
    showDialog<void>(
      context: context,
      builder: (_) => _MealLogDialog(
        existingLog: log,
        childId: childId,
        dailyRecordId: recordId,
        notifier: notifier,
      ),
    );
  }
}

// ── 睡眠ログ入力ダイアログ ─────────────────────────────────────────────────────

class _SleepLogDialog extends StatefulWidget {
  const _SleepLogDialog({
    this.existingLog,
    required this.childId,
    required this.dailyRecordId,
    required this.notifier,
  });

  final SleepLog? existingLog;
  final String childId;
  final String dailyRecordId;
  final RecordEditNotifier notifier;

  @override
  State<_SleepLogDialog> createState() => _SleepLogDialogState();
}

class _SleepLogDialogState extends State<_SleepLogDialog> {
  TimeOfDay? _bedtimeStart;
  TimeOfDay? _sleepStart;
  TimeOfDay? _sleepEnd;

  @override
  void initState() {
    super.initState();
    final log = widget.existingLog;
    if (log != null) {
      if (log.bedtimeStartTime != null) {
        final dt = DateTime.parse(log.bedtimeStartTime!);
        _bedtimeStart = TimeOfDay(hour: dt.hour, minute: dt.minute);
      }
      final start = DateTime.parse(log.sleepStartTime);
      _sleepStart = TimeOfDay(hour: start.hour, minute: start.minute);
      if (log.sleepEndTime != null) {
        final end = DateTime.parse(log.sleepEndTime!);
        _sleepEnd = TimeOfDay(hour: end.hour, minute: end.minute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingLog == null ? '睡眠を追加' : '睡眠を編集'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TimePicker(
            label: AppStrings.bedtimeStartTime,
            value: _bedtimeStart,
            onChanged: (t) => setState(() => _bedtimeStart = t),
            isRequired: false,
          ),
          _TimePicker(
            label: AppStrings.sleepStartTime,
            value: _sleepStart,
            onChanged: (t) => setState(() => _sleepStart = t),
          ),
          _TimePicker(
            label: AppStrings.sleepEndTime,
            value: _sleepEnd,
            onChanged: (t) => setState(() => _sleepEnd = t),
            isRequired: false,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: _sleepStart == null ? null : _submit,
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }

  void _submit() {
    // 開始〜終了バリデーション（両方設定されている場合のみ）
    if (_sleepStart != null && _sleepEnd != null) {
      final startMin = _sleepStart!.hour * 60 + _sleepStart!.minute;
      final endMin = _sleepEnd!.hour * 60 + _sleepEnd!.minute;
      if (startMin >= endMin) {
        showDialog<void>(
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
        return;
      }
    }

    final now = DateTime.now();
    String toIso(TimeOfDay t) =>
        DateTime(now.year, now.month, now.day, t.hour, t.minute).toIso8601();

    final log = widget.existingLog;
    if (log == null) {
      widget.notifier.addSleepLog(
        widget.notifier.buildNewSleepLog(
          dailyRecordId: widget.dailyRecordId,
          childId: widget.childId,
          bedtimeStartTime:
              _bedtimeStart != null ? toIso(_bedtimeStart!) : null,
          sleepStartTime: toIso(_sleepStart!),
          sleepEndTime: _sleepEnd != null ? toIso(_sleepEnd!) : null,
        ),
      );
    } else {
      widget.notifier.updateSleepLog(
        log.copyWith(
          bedtimeStartTime:
              _bedtimeStart != null ? toIso(_bedtimeStart!) : null,
          sleepStartTime: toIso(_sleepStart!),
          sleepEndTime: _sleepEnd != null ? toIso(_sleepEnd!) : null,
        ),
      );
    }
    Navigator.pop(context);
  }
}

class _TimePicker extends StatelessWidget {
  const _TimePicker({
    required this.label,
    required this.value,
    required this.onChanged,
    this.isRequired = true,
  });

  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?> onChanged;
  final bool isRequired;

  String _format(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        isRequired ? label : '$label（任意）',
        style: const TextStyle(fontSize: 14),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value != null ? _format(value!) : '--:--',
            style: TextStyle(
              fontSize: 16,
              fontWeight: value != null ? FontWeight.w600 : FontWeight.normal,
              color: value != null
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          if (!isRequired && value != null)
            IconButton(
              icon: const Icon(Icons.clear, size: 16),
              onPressed: () => onChanged(null),
            ),
        ],
      ),
      onTap: () async {
        final picked = await showTimePickerBottomSheet(
          context: context,
          label: isRequired ? label : '$label（任意）',
          initialTime: value,
        );
        if (picked != null) onChanged(picked);
      },
    );
  }
}

// ── 食事ログ入力ダイアログ ─────────────────────────────────────────────────────

class _MealLogDialog extends StatefulWidget {
  const _MealLogDialog({
    this.existingLog,
    required this.childId,
    required this.dailyRecordId,
    required this.notifier,
  });

  final MealLog? existingLog;
  final String childId;
  final String dailyRecordId;
  final RecordEditNotifier notifier;

  @override
  State<_MealLogDialog> createState() => _MealLogDialogState();
}

class _MealLogDialogState extends State<_MealLogDialog> {
  late TimeOfDay _mealTime;
  late final TextEditingController _contentController;
  bool _hasContent = false;

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    final log = widget.existingLog;
    if (log != null) {
      final dt = DateTime.parse(log.mealTime);
      _mealTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      _contentController = TextEditingController(text: log.content);
      _hasContent = log.content.isNotEmpty;
    } else {
      _mealTime = TimeOfDay.now();
      _contentController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingLog == null ? '食事を追加' : '食事を編集'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('時刻', style: TextStyle(fontSize: 14)),
            trailing: Text(
              _formatTime(_mealTime),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            onTap: () async {
              final picked = await showTimePickerBottomSheet(
                context: context,
                label: '食事時刻',
                initialTime: _mealTime,
              );
              if (picked != null) setState(() => _mealTime = picked);
            },
          ),
          TextFormField(
            controller: _contentController,
            decoration: const InputDecoration(hintText: '食事内容を入力'),
            maxLines: 3,
            onChanged: (v) => setState(() => _hasContent = v.isNotEmpty),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: _hasContent ? _submit : null,
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }

  void _submit() {
    final now = DateTime.now();
    final mealTime = DateTime(
      now.year,
      now.month,
      now.day,
      _mealTime.hour,
      _mealTime.minute,
    ).toIso8601();

    final log = widget.existingLog;
    if (log == null) {
      widget.notifier.addMealLog(
        widget.notifier.buildNewMealLog(
          dailyRecordId: widget.dailyRecordId,
          childId: widget.childId,
          mealTime: mealTime,
          content: _contentController.text.trimRight(),
        ),
      );
    } else {
      widget.notifier.updateMealLog(
        log.copyWith(
          mealTime: mealTime,
          content: _contentController.text.trimRight(),
        ),
      );
    }
    Navigator.pop(context);
  }
}
