import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/data/models/sleep_log.dart';

class SleepTimeRangeTile extends StatelessWidget {
  const SleepTimeRangeTile({
    super.key,
    required this.log,
    required this.onEdit,
    required this.onDelete,
  });

  final SleepLog log;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final start = DateTime.parse(log.sleepStartTime).toDisplayTime();
    final end = log.sleepEndTime != null
        ? DateTime.parse(log.sleepEndTime!).toDisplayTime()
        : '就寝中';
    final bedtime = log.bedtimeStartTime != null
        ? DateTime.parse(log.bedtimeStartTime!).toDisplayTime()
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.bedtime_outlined, color: AppColors.sleepBlock),
        title: Text('$start 〜 $end',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: bedtime != null
            ? Text('寝かしつけ開始: $bedtime',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary))
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  size: 18, color: AppColors.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
