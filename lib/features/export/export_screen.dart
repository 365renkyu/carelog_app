import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/features/export/export_field.dart';
import 'package:ikuji_kiroku_app/features/export/export_provider.dart';
import 'package:ikuji_kiroku_app/features/export/export_settings_provider.dart';
import 'package:ikuji_kiroku_app/features/export/formatters/record_text_formatter.dart';
import 'package:ikuji_kiroku_app/features/record/detail/record_detail_provider.dart';
import 'package:ikuji_kiroku_app/shared/widgets/export_field_toggle.dart';

enum _ExportMode { day, period }

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  _ExportMode _mode = _ExportMode.day;
  late DateTime _singleDay;
  late DateTime _from;
  late DateTime _to;

  @override
  void initState() {
    super.initState();
    final today = widget.initialDate ?? DateTime.now();
    _singleDay = today;
    _from = today;
    _to = today;
  }

  bool get _isOver3Months {
    final diff = _to.difference(_from).inDays;
    return diff > 91;
  }

  @override
  Widget build(BuildContext context) {
    final fields = ref.watch(exportSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.exportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 出力項目選択
          Text(
            AppStrings.exportFieldSettings,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          ExportFieldToggle(
            fields: ExportField.values,
            selected: fields,
            onToggle: ref.read(exportSettingsProvider.notifier).toggle,
          ),
          const Divider(height: 32),

          // 日単位 / 期間指定 切り替え
          SegmentedButton<_ExportMode>(
            segments: const [
              ButtonSegment(
                value: _ExportMode.day,
                label: Text('日単位'),
                icon: Icon(Icons.today, size: 16),
              ),
              ButtonSegment(
                value: _ExportMode.period,
                label: Text('期間指定'),
                icon: Icon(Icons.date_range, size: 16),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (s) => setState(() => _mode = s.first),
          ),
          const SizedBox(height: 16),

          // 日付選択
          if (_mode == _ExportMode.day) ...[
            _DatePickerButton(
              label: '日付',
              date: _singleDay,
              onChanged: (d) => setState(() => _singleDay = d),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _DatePickerButton(
                    label: '開始日',
                    date: _from,
                    onChanged: (d) => setState(() {
                      _from = d;
                      if (_to.isBefore(_from)) _to = _from;
                    }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('〜'),
                ),
                Expanded(
                  child: _DatePickerButton(
                    label: '終了日',
                    date: _to,
                    onChanged: (d) => setState(() => _to = d),
                  ),
                ),
              ],
            ),
            if (_isOver3Months) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.orange.shade700, size: 18),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        '期間が3ヶ月を超えています。テキストが非常に長くなる場合があります。',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
          const SizedBox(height: 24),

          // プレビュー & コピー
          if (_mode == _ExportMode.day)
            _DayExportBody(date: _singleDay, fields: fields)
          else
            _PeriodExportBody(from: _from, to: _to, fields: fields),
        ],
      ),
    );
  }
}

// ── 日単位 ──────────────────────────────────────────────────────────────────

class _DayExportBody extends ConsumerWidget {
  const _DayExportBody({required this.date, required this.fields});

  final DateTime date;
  final Set<ExportField> fields;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(recordDetailProvider(date.toDateKey()));
    return detail.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>
          Text('エラー: $e', style: const TextStyle(color: AppColors.error)),
      data: (d) {
        if (d == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                AppStrings.noData,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          );
        }
        final text = RecordTextFormatter.formatDay(
          date: date,
          detail: d,
          fields: fields,
        );
        return _PreviewAndCopy(text: text);
      },
    );
  }
}

// ── 期間指定 ─────────────────────────────────────────────────────────────────

class _PeriodExportBody extends ConsumerWidget {
  const _PeriodExportBody({
    required this.from,
    required this.to,
    required this.fields,
  });

  final DateTime from;
  final DateTime to;
  final Set<ExportField> fields;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rangeKey = (from: from.toDateKey(), to: to.toDateKey());
    final details = ref.watch(exportDetailsProvider(rangeKey));
    return details.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>
          Text('エラー: $e', style: const TextStyle(color: AppColors.error)),
      data: (list) {
        if (list.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                AppStrings.noData,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          );
        }
        final text = RecordTextFormatter.formatPeriod(
          from: from,
          to: to,
          details: list,
          fields: fields,
        );
        return _PreviewAndCopy(text: text);
      },
    );
  }
}

// ── 共通: プレビュー + コピーボタン ──────────────────────────────────────────

class _PreviewAndCopy extends StatelessWidget {
  const _PreviewAndCopy({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.divider),
          ),
          child: SelectableText(
            text,
            style: const TextStyle(fontSize: 13, height: 1.7),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.copy_outlined),
          label: const Text(AppStrings.exportCopyPeriod),
          onPressed: () => _copy(context, text),
        ),
      ],
    );
  }

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.exportCopied)),
      );
    }
  }
}

class _DatePickerButton extends StatelessWidget {
  const _DatePickerButton({
    required this.label,
    required this.date,
    required this.onChanged,
  });

  final String label;
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
        decoration: InputDecoration(labelText: label),
        child: Text(date.toDisplayDate()),
      ),
    );
  }
}
