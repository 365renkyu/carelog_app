import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/data/models/absence_template.dart';
import 'package:ikuji_kiroku_app/features/settings/absence_templates/absence_template_settings_provider.dart';

class AbsenceTemplateSettingsScreen extends ConsumerWidget {
  const AbsenceTemplateSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(absenceTemplateSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTemplates)),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.settingsTemplateAdd),
        onPressed: () => _openEditor(context, ref, null),
      ),
      body: templates.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (list) => list.isEmpty
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.article_outlined,
                        size: 64, color: AppColors.textSecondary),
                    SizedBox(height: 16),
                    Text(
                      '定型文がありません',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppStrings.placeholderHint,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: list.length,
                itemBuilder: (_, i) => _TemplateTile(
                  template: list[i],
                  onEdit: () => _openEditor(context, ref, list[i]),
                  onDelete: () => _confirmDelete(context, ref, list[i].id),
                ),
              ),
      ),
    );
  }

  void _openEditor(
    BuildContext context,
    WidgetRef ref,
    AbsenceTemplate? template,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _TemplateEditor(template: template),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(absenceTemplateEditorProvider(null).notifier)
          .delete(id);
    }
  }
}

class _TemplateTile extends StatelessWidget {
  const _TemplateTile({
    required this.template,
    required this.onEdit,
    required this.onDelete,
  });

  final AbsenceTemplate template;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(template.title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          template.template,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _TemplateEditor extends ConsumerStatefulWidget {
  const _TemplateEditor({this.template});

  final AbsenceTemplate? template;

  @override
  ConsumerState<_TemplateEditor> createState() => _TemplateEditorState();
}

class _TemplateEditorState extends ConsumerState<_TemplateEditor> {
  late final TextEditingController _titleController;
  late final TextEditingController _templateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.template?.title);
    _templateController =
        TextEditingController(text: widget.template?.template);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _templateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.template == null;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isNew ? AppStrings.settingsTemplateAdd : '定型文を編集',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'タイトル'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _templateController,
            decoration: const InputDecoration(
              labelText: '定型文',
            ),
            maxLines: 6,
          ),
          const SizedBox(height: 8),
          // プレースホルダーボタン
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: ['{date}', '{startTime}', '{endTime}', '{facilityName}']
                .map(
                  (ph) => ActionChip(
                    label: Text(ph, style: const TextStyle(fontSize: 12)),
                    onPressed: () => _insertPlaceholder(ph),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _save,
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  void _insertPlaceholder(String placeholder) {
    final controller = _templateController;
    final text = controller.text;
    final sel = controller.selection;
    // カーソル位置（選択がない場合は末尾）
    final pos = sel.isValid ? sel.baseOffset : text.length;
    final safePos = pos.clamp(0, text.length);
    final newText =
        text.substring(0, safePos) + placeholder + text.substring(safePos);
    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
          offset: safePos + placeholder.length),
    );
  }

  Future<void> _save() async {
    if (_titleController.text.isEmpty || _templateController.text.isEmpty) {
      return;
    }
    await ref
        .read(absenceTemplateEditorProvider(widget.template?.id).notifier)
        .save(
          title: _titleController.text,
          template: _templateController.text,
        );
    if (mounted) Navigator.pop(context);
  }
}
