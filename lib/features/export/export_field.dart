import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';

enum ExportField {
  mood(AppStrings.fieldMood),
  sleepLogs(AppStrings.fieldSleep),
  mealLogs(AppStrings.fieldMeal),
  notes(AppStrings.fieldNotes),
  achievements(AppStrings.fieldAchievements),
  cuteMoments(AppStrings.fieldCuteMoments),
  concerns(AppStrings.fieldConcerns),
  therapyMemo(AppStrings.fieldTherapyMemo);

  const ExportField(this.label);

  final String label;

  static Set<ExportField> get defaults => ExportField.values.toSet();
}
