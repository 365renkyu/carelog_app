import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';

/// 24時間表示のドラムロール+手入力時間ピッカーをボトムシートで表示する。
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

  // 手入力テキストフィールド
  final _textController = TextEditingController();
  bool _textMode = false; // true = 手入力モード
  String? _textError;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialTime.hour;
    _minute = widget.initialTime.minute;
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
    _textController.text = _formatTime(_hour, _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _textController.dispose();
    super.dispose();
  }

  String _formatTime(int h, int m) =>
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

  void _onTextChanged(String value) {
    setState(() => _textError = null);
    final parts = value.split(':');
    if (parts.length == 2) {
      final h = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      if (h != null && m != null && h >= 0 && h <= 23 && m >= 0 && m <= 59) {
        _hour = h;
        _minute = m;
        _hourController.jumpToItem(h);
        _minuteController.jumpToItem(m);
      }
    }
  }

  void _validateAndSubmit() {
    if (_textMode) {
      final value = _textController.text;
      final parts = value.split(':');
      if (parts.length != 2) {
        setState(() => _textError = '例: 09:30');
        return;
      }
      final h = int.tryParse(parts[0]);
      final m = int.tryParse(parts[1]);
      if (h == null || m == null || h < 0 || h > 23 || m < 0 || m > 59) {
        setState(() => _textError = '0〜23時、0〜59分で入力してください');
        return;
      }
      _hour = h;
      _minute = m;
    }
    Navigator.pop(context, TimeOfDay(hour: _hour, minute: _minute));
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
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

          // タイトル + 手入力切り替えボタン
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _textMode = !_textMode;
                      if (_textMode) {
                        _textController.text =
                            _formatTime(_hour, _minute);
                        _textError = null;
                      }
                    });
                  },
                  child: Text(_textMode ? 'ドラムロール' : '手入力'),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // ── ドラムロールモード ──────────────────────────────────
          if (!_textMode) ...[
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  // 時 (0 〜 23)
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 選択ハイライト
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
          ],

          // ── 手入力モード ────────────────────────────────────────
          if (_textMode)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 24),
              child: TextFormField(
                controller: _textController,
                keyboardType: TextInputType.datetime,
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, letterSpacing: 4),
                decoration: InputDecoration(
                  hintText: '09:30',
                  errorText: _textError,
                  hintStyle: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 32),
                ),
                onChanged: _onTextChanged,
                onFieldSubmitted: (_) => _validateAndSubmit(),
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
                    onPressed: _validateAndSubmit,
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
