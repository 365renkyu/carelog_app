import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';

/// 24時間表示のドラムロール時間ピッカーをボトムシートで表示する。
///
/// [label]: ボトムシートのタイトル
/// [initialTime]: 初期値（null の場合は現在時刻）
/// 戻り値: 選択された TimeOfDay、キャンセルなら null
Future<TimeOfDay?> showTimePickerBottomSheet({
  required BuildContext context,
  required String label,
  TimeOfDay? initialTime,
}) async {
  return showModalBottomSheet<TimeOfDay>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _TimePickerBottomSheet(
      label: label,
      initialTime: initialTime ?? TimeOfDay.now(),
    ),
  );
}

class _TimePickerBottomSheet extends StatefulWidget {
  const _TimePickerBottomSheet({
    required this.label,
    required this.initialTime,
  });

  final String label;
  final TimeOfDay initialTime;

  @override
  State<_TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<_TimePickerBottomSheet> {
  late int _hour;
  late int _minute;

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialTime.hour;
    _minute = widget.initialTime.minute;
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.pop(context, TimeOfDay(hour: _hour, minute: _minute));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ハンドル
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // タイトル
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // ドラムロール
          SizedBox(
            height: 200,
            child: Row(
              children: [
                // 時 (0 〜 23)
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      CupertinoPicker(
                        scrollController: _hourController,
                        itemExtent: 44,
                        onSelectedItemChanged: (i) =>
                            setState(() => _hour = i),
                        children: List.generate(
                          24,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // コロン
                const Text(
                  ':',
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),

                // 分 (0 〜 59)
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      CupertinoPicker(
                        scrollController: _minuteController,
                        itemExtent: 44,
                        onSelectedItemChanged: (i) =>
                            setState(() => _minute = i),
                        children: List.generate(
                          60,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 決定 / キャンセル
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(AppStrings.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('決定'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
