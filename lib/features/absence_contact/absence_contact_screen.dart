import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/features/absence_contact/absence_contact_provider.dart';
import 'package:ikuji_kiroku_app/features/therapy_schedule/therapy_schedule_provider.dart';

class AbsenceContactScreen extends ConsumerWidget {
  const AbsenceContactScreen({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(absenceContactProvider);
    final notifier = ref.read(absenceContactProvider.notifier);
    final schedules = ref.watch(daySchedulesProvider(date.toDateKey()));
    final templates = ref.watch(absenceTemplatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${date.toDisplayDate()} 欠席連絡'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // スケジュール選択
          Text(
            AppStrings.absenceSelectSchedule,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          schedules.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('エラー: $e'),
            data: (list) => list.isEmpty
                ? const Text(
                    'この日のスケジュールがありません',
                    style: TextStyle(color: AppColors.textSecondary),
                  )
                : Column(
                    children: list
                        .map(
                          (s) => _ScheduleTile(
                            schedule: s,
                            isSelected: state.selectedSchedule?.id == s.id,
                            onTap: () => notifier.selectSchedule(s),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const Divider(height: 32),

          // 定型文選択
          Text(
            AppStrings.absenceSelectTemplate,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          templates.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('エラー: $e'),
            data: (list) => list.isEmpty
                ? const Text(
                    '定型文がありません。設定から追加してください。',
                    style: TextStyle(color: AppColors.textSecondary),
                  )
                : Column(
                    children: list
                        .map(
                          (t) => _TemplateTile(
                            template: t,
                            isSelected: state.selectedTemplate?.id == t.id,
                            onTap: () => notifier.selectTemplate(t),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const Divider(height: 32),

          // プレビュー
          if (state.previewText != null) ...[
            Text(
              AppStrings.absencePreview,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.divider),
              ),
              child: SelectableText(
                state.previewText!,
                style: const TextStyle(fontSize: 14, height: 1.7),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.copy_outlined),
              label: const Text(AppStrings.absenceCopy),
              onPressed: () => _copy(context, state.previewText!),
            ),
          ] else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'スケジュールと定型文を選択してください',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ),
        ],
      ),
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

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({
    required this.schedule,
    required this.isSelected,
    required this.onTap,
  });

  final TherapySchedule schedule;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(schedule.date).toDisplayDate();
    return Card(
      color: isSelected ? AppColors.primaryLight : null,
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(schedule.facilityName),
        subtitle: Text('$date  ${schedule.startTime}〜${schedule.endTime}'),
        onTap: onTap,
      ),
    );
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  final AbsenceTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.primaryLight : null,
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(template.title),
        subtitle: Text(
          template.template,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        onTap: onTap,
      ),
    );
  }
}
