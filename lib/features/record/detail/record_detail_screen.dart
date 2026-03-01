import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/core/router/app_router.dart';
import 'package:ikuji_kiroku_app/data/models/daily_record_detail.dart';
import 'package:ikuji_kiroku_app/data/models/mood.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';
import 'package:ikuji_kiroku_app/features/export/export_field.dart';
import 'package:ikuji_kiroku_app/features/export/export_settings_provider.dart';
import 'package:ikuji_kiroku_app/features/export/formatters/record_text_formatter.dart';
import 'package:ikuji_kiroku_app/features/record/detail/record_detail_provider.dart';
import 'package:ikuji_kiroku_app/shared/widgets/section_header.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

class RecordDetailScreen extends ConsumerWidget {
  const RecordDetailScreen({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(recordDetailProvider(date.toDateKey()));
    final childName = ref.watch(currentChildProvider).valueOrNull?.name ?? '';

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
        title: Text(date.toDisplayDate()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: '編集',
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.recordEdit,
                arguments: date,
              );
              ref.refreshRecordDetail(date);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: detail.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラー: $e')),
              data: (d) => d == null
                  ? _EmptyState(date: date)
                  : _DetailBody(detail: d, date: date),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends ConsumerWidget {
  const _EmptyState({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.note_add_outlined,
              size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          const Text('この日の記録はありません',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('記録を作成'),
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.recordEdit,
                arguments: date,
              );
              ref.refreshRecordDetail(date);
            },
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.detail, required this.date});

  final DailyRecordDetail detail;
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = detail.record;
    final mood = Mood.fromValue(record.mood);
    final exportFields = ref.watch(exportSettingsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 機嫌
        _InfoCard(
          icon: Icon(mood.icon, color: mood.color),
          label: AppStrings.fieldMood,
          value: mood.label,
          valueColor: mood.color,
        ),
        const SizedBox(height: 12),

        // 睡眠
        if (detail.sleepLogs.isNotEmpty) ...[
          const SectionHeader(title: AppStrings.fieldSleep),
          ...detail.sleepLogs.map((log) => _SleepLogTile(log: log)),
          const SizedBox(height: 12),
        ],

        // 食事
        if (detail.mealLogs.isNotEmpty) ...[
          const SectionHeader(title: AppStrings.fieldMeal),
          ...detail.mealLogs.map(
            (log) => _InfoCard(
              icon: const Icon(Icons.restaurant, color: AppColors.primary),
              label: DateTime.parse(log.mealTime).toDisplayTime(),
              value: log.content,
            ),
          ),
          const SizedBox(height: 12),
        ],

        // テキストフィールド群
        if (record.notes?.isNotEmpty == true)
          _TextFieldCard(label: AppStrings.fieldNotes, value: record.notes!),
        if (record.achievements?.isNotEmpty == true)
          _TextFieldCard(
              label: AppStrings.fieldAchievements, value: record.achievements!),
        if (record.cuteMoments?.isNotEmpty == true)
          _TextFieldCard(
              label: AppStrings.fieldCuteMoments, value: record.cuteMoments!),
        if (record.concerns?.isNotEmpty == true)
          _TextFieldCard(
              label: AppStrings.fieldConcerns, value: record.concerns!),
        if (record.therapyMemo?.isNotEmpty == true)
          _TextFieldCard(
              label: AppStrings.fieldTherapyMemo, value: record.therapyMemo!),

        const SizedBox(height: 24),

        // コピーボタン
        OutlinedButton.icon(
          icon: const Icon(Icons.copy_outlined),
          label: const Text(AppStrings.exportCopyDay),
          onPressed: () => _copyToClipboard(context, ref, exportFields),
        ),
      ],
    );
  }

  Future<void> _copyToClipboard(
    BuildContext context,
    WidgetRef ref,
    Set<ExportField> fields,
  ) async {
    final text = RecordTextFormatter.formatDay(
      date: date,
      detail: detail,
      fields: fields,
    );
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.exportCopied)),
      );
    }
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final Widget icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: AppColors.textSecondary)),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SleepLogTile extends StatelessWidget {
  const _SleepLogTile({required this.log});

  final SleepLog log;

  @override
  Widget build(BuildContext context) {
    final start = DateTime.parse(log.sleepStartTime).toDisplayTime();
    final end = log.sleepEndTime != null
        ? DateTime.parse(log.sleepEndTime!).toDisplayTime()
        : '就寝中';
    final bedtime = log.bedtimeStartTime != null
        ? '（寝かしつけ開始: ${DateTime.parse(log.bedtimeStartTime!).toDisplayTime()}）'
        : '';

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.bedtime_outlined, color: AppColors.sleepBlock),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$start 〜 $end',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (bedtime.isNotEmpty)
                    Text(bedtime,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFieldCard extends StatelessWidget {
  const _TextFieldCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
