import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';
import 'package:ikuji_kiroku_app/features/absence_contact/absence_contact_provider.dart';

final absenceTemplateSettingsProvider =
    FutureProvider<List<AbsenceTemplate>>((ref) async {
  final childId = ref.read(currentChildIdProvider);
  return ref.read(absenceTemplateRepositoryProvider).getAll(childId);
});

class AbsenceTemplateEditorNotifier
    extends AutoDisposeFamilyNotifier<void, String?> {
  static const _uuid = Uuid();

  @override
  void build(String? arg) {}

  Future<void> save({
    required String title,
    required String template,
  }) async {
    final childId = ref.read(currentChildIdProvider);
    final repo = ref.read(absenceTemplateRepositoryProvider);
    final now = DateTime.now().toIso8601String();

    if (arg != null) {
      final existing = await repo.getById(arg!);
      if (existing != null) {
        await repo.update(
          existing.copyWith(title: title, template: template, updatedAt: now),
        );
      }
    } else {
      await repo.save(
        AbsenceTemplate(
          id: _uuid.v4(),
          childId: childId,
          title: title,
          template: template,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
    // 一覧を再取得
    ref.invalidate(absenceTemplatesProvider);
    ref.invalidate(absenceTemplateSettingsProvider);
  }

  Future<void> delete(String id) async {
    await ref.read(absenceTemplateRepositoryProvider).delete(id);
    ref.invalidate(absenceTemplatesProvider);
    ref.invalidate(absenceTemplateSettingsProvider);
  }
}

final absenceTemplateEditorProvider = AutoDisposeNotifierProviderFamily<
    AbsenceTemplateEditorNotifier, void, String?>(
  AbsenceTemplateEditorNotifier.new,
);
