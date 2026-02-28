import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/extensions/datetime_extension.dart';
import 'package:ikuji_kiroku_app/core/router/app_router.dart';
import 'package:ikuji_kiroku_app/features/calendar/calendar_provider.dart';
import 'package:ikuji_kiroku_app/features/therapy_schedule/edit/therapy_schedule_edit_provider.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final recordedDates = ref.watch(recordedDatesProvider);
    final schedules = ref.watch(monthSchedulesProvider(_focusedDay));

    // スケジュールがある日付のセット
    final scheduleDates = schedules.valueOrNull
            ?.map((s) => s.date)
            .toSet() ??
        {};

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.navCalendar),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: '今日',
            onPressed: () => setState(() {
              _focusedDay = DateTime.now();
              _selectedDay = DateTime.now();
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              todayTextStyle:
                  TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                final dateKey = day.toDateKey();
                final hasRecord =
                    recordedDates.valueOrNull?.contains(dateKey) ?? false;
                final hasSchedule = scheduleDates.contains(dateKey);
                if (!hasRecord && !hasSchedule) return const SizedBox.shrink();

                return Positioned(
                  bottom: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasRecord)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (hasSchedule)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() => _focusedDay = focusedDay);
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: _selectedDay == null
                ? const Center(
                    child: Text(
                      '日付を選択してください',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : _DayPanel(selectedDay: _selectedDay!),
          ),
        ],
      ),
    );
  }
}

/// 選択された日のサマリーパネル
class _DayPanel extends ConsumerWidget {
  const _DayPanel({required this.selectedDay});

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateKey = selectedDay.toDateKey();
    final schedules =
        ref.watch(monthSchedulesProvider(selectedDay)).valueOrNull ?? [];
    final daySchedules =
        schedules.where((s) => s.date == dateKey).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          selectedDay.toDisplayDate(),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        // スケジュール一覧
        if (daySchedules.isNotEmpty) ...[
          ...daySchedules.map(
            (s) => Card(
              child: ListTile(
                leading: const Icon(Icons.schedule, color: AppColors.secondary),
                title: Row(
                  children: [
                    Text(s.facilityName),
                    if (s.repeatType == 'weekly') ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.repeat, size: 14,
                          color: AppColors.textSecondary),
                    ],
                  ],
                ),
                subtitle: Text('${s.startTime} 〜 ${s.endTime}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRoutes.therapyScheduleEdit,
                    arguments: TherapyScheduleEditArgs(
                      scheduleId: s.id,
                      initialDate: selectedDay,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        // 操作ボタン
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('スケジュール追加'),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.therapyScheduleEdit,
                  arguments: TherapyScheduleEditArgs(initialDate: selectedDay),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit_note, size: 18),
                label: const Text('記録を開く'),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.recordDetail,
                  arguments: selectedDay,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.mail_outline, size: 18),
            label: const Text('欠席連絡'),
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.absenceContact,
              arguments: selectedDay,
            ),
          ),
        ),
      ],
    );
  }
}
