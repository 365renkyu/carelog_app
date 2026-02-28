import 'package:flutter/material.dart';

// TODO: 将来実装予定 — 療育タイマー
//
// 概要:
//   セッション時間のカウントダウンタイマー
//
// 実装方針:
//   - Stream.periodic + AsyncNotifier (@riverpod) でカウントダウンを管理
//   - 残り時間・開始/一時停止/リセット操作を提供
//   - セッション終了時に通知（local_notifications パッケージ）
//
// 必要パッケージ（将来追加）:
//   - flutter_local_notifications

class TherapyTimerScreen extends StatelessWidget {
  const TherapyTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '療育タイマーは今後実装予定です',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
