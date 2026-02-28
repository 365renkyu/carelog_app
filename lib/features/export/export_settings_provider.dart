import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ikuji_kiroku_app/features/export/export_field.dart';

const _prefKey = 'export_fields';

class ExportSettingsNotifier extends Notifier<Set<ExportField>> {
  @override
  Set<ExportField> build() {
    _load();
    return ExportField.defaults;
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_prefKey);
    if (saved != null) {
      final fields = saved
          .map((name) => ExportField.values.where((f) => f.name == name).firstOrNull)
          .whereType<ExportField>()
          .toSet();
      if (fields.isNotEmpty) state = fields;
    }
  }

  Future<void> toggle(ExportField field) async {
    final updated = Set<ExportField>.from(state);
    if (updated.contains(field)) {
      updated.remove(field);
    } else {
      updated.add(field);
    }
    state = updated;
    await _persist(updated);
  }

  Future<void> _persist(Set<ExportField> fields) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefKey, fields.map((f) => f.name).toList());
  }
}

final exportSettingsProvider =
    NotifierProvider<ExportSettingsNotifier, Set<ExportField>>(
  ExportSettingsNotifier.new,
);
