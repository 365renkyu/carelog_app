import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';

enum Mood {
  good(0, AppStrings.moodGood, AppColors.moodGood, Icons.sentiment_very_satisfied),
  normal(1, AppStrings.moodNormal, AppColors.moodNormal, Icons.sentiment_neutral),
  bad(2, AppStrings.moodBad, AppColors.moodBad, Icons.sentiment_very_dissatisfied);

  const Mood(this.value, this.label, this.color, this.icon);

  final int value;
  final String label;
  final Color color;
  final IconData icon;

  static Mood fromValue(int value) =>
      Mood.values.firstWhere((e) => e.value == value, orElse: () => Mood.normal);
}
