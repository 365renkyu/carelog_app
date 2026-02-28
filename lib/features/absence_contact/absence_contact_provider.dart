import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';
import 'package:ikuji_kiroku_app/data/models/therapy_schedule.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';
import 'package:ikuji_kiroku_app/features/absence_contact/template_formatter.dart';

part 'absence_contact_provider.freezed.dart';

@freezed
class AbsenceContactState with _$AbsenceContactState {
  const factory AbsenceContactState({
    TherapySchedule? selectedSchedule,
    AbsenceTemplate? selectedTemplate,
  }) = _AbsenceContactState;

  const AbsenceContactState._();

  /// プレースホルダーを置換した出力テキスト
  String? get previewText {
    if (selectedSchedule == null || selectedTemplate == null) return null;
    return TemplateFormatter.format(
      selectedTemplate!.template,
      selectedSchedule!,
    );
  }
}

class AbsenceContactNotifier extends AutoDisposeNotifier<AbsenceContactState> {
  @override
  AbsenceContactState build() => const AbsenceContactState();

  void selectSchedule(TherapySchedule s) =>
      state = state.copyWith(selectedSchedule: s);

  void selectTemplate(AbsenceTemplate t) =>
      state = state.copyWith(selectedTemplate: t);
}

final absenceContactProvider =
    AutoDisposeNotifierProvider<AbsenceContactNotifier, AbsenceContactState>(
  AbsenceContactNotifier.new,
);

/// 定型文一覧
final absenceTemplatesProvider =
    FutureProvider<List<AbsenceTemplate>>((ref) async {
  final childId = ref.read(currentChildIdProvider);
  return ref.read(absenceTemplateRepositoryProvider).getAll(childId);
});
