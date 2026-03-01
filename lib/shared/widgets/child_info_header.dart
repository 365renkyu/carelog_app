import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

/// 全画面上部に表示する「ニックネーム　月齢」バナー
class ChildInfoHeader extends ConsumerWidget {
  const ChildInfoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childAsync = ref.watch(currentChildProvider);

    return childAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (child) {
        if (child == null) return const SizedBox.shrink();

        final name = child.name.isNotEmpty ? child.name : null;
        final ageText = _calcAgeText(child.birthDate);

        if (name == null && ageText == null) return const SizedBox.shrink();

        final label = [
          if (name != null) name,
          if (ageText != null) ageText,
        ].join('\u3000'); // 全角スペース区切り

        return Container(
          width: double.infinity,
          color: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SafeArea(
            bottom: false,
            left: false,
            right: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 月齢テキストを返す（生年月日未設定の場合は null）
  String? _calcAgeText(String birthDate) {
    if (birthDate.isEmpty) return null;
    try {
      final birth = DateTime.parse(birthDate);
      final now = DateTime.now();
      final totalMonths =
          (now.year - birth.year) * 12 + (now.month - birth.month);

      final years = totalMonths ~/ 12; //整数除算
      final months = totalMonths % 12; //余り

      if (years == 0) return '0歳$monthsヶ月';

      return '$years歳$monthsヶ月';
    } catch (_) {
      return null;
    }
  }
}
