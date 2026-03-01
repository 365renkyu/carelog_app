import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ikuji_kiroku_app/core/constants/app_strings.dart';
import 'package:ikuji_kiroku_app/core/router/app_router.dart';
import 'package:ikuji_kiroku_app/data/models/child.dart';
import 'package:ikuji_kiroku_app/data/providers/repository_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childAsync = ref.watch(currentChildProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: ListView(
        children: [
          // ── 子供の情報 ──────────────────────────────────
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              '子供の情報',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          childAsync.when(
            loading: () => const ListTile(title: Text('読み込み中...')),
            error: (e, _) => ListTile(title: Text('エラー: $e')),
            data: (child) => ListTile(
              leading: const Icon(Icons.child_care),
              title: Text(
                child?.name.isNotEmpty == true ? child!.name : 'お子さん',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                child?.birthDate.isNotEmpty == true
                    ? '生年月日: ${child!.birthDate}'
                    : '生年月日未設定',
              ),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () => _openChildEditor(context, ref, child),
            ),
          ),
          const Divider(),

          // ── 定型文管理 ──────────────────────────────────
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text(AppStrings.settingsTemplates),
            subtitle: const Text('欠席連絡の定型文を管理'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.absenceTemplateSettings,
            ),
          ),
        ],
      ),
    );
  }

  void _openChildEditor(
    BuildContext context,
    WidgetRef ref,
    Child? child,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ChildEditor(child: child),
    );
  }
}

class _ChildEditor extends ConsumerStatefulWidget {
  const _ChildEditor({this.child});

  final Child? child;

  @override
  ConsumerState<_ChildEditor> createState() => _ChildEditorState();
}

class _ChildEditorState extends ConsumerState<_ChildEditor> {
  late final TextEditingController _nameController;
  String? _birthDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.child?.name ?? '');
    _nameController.addListener(() => setState(() {}));
    _birthDate = widget.child?.birthDate.isNotEmpty == true
        ? widget.child!.birthDate
        : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            '子供の情報を編集',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'ニックネーム'),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _pickBirthDate,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: '生年月日（任意）',
                suffixIcon: _birthDate != null
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => _birthDate = null),
                      )
                    : null,
              ),
              child: Text(
                _birthDate ?? '未設定',
                style: TextStyle(
                  color: _birthDate != null ? null : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _nameController.text.trim().isEmpty ? null : _save,
            child: const Text(AppStrings.save),
          ),
        ],
      ),
    );
  }

  Future<void> _pickBirthDate() async {
    final initial = _birthDate != null
        ? DateTime.parse(_birthDate!)
        : DateTime(DateTime.now().year - 2);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  Future<void> _save() async {
    final childId = ref.read(currentChildIdProvider);
    final dao = ref.read(childDaoProvider);
    final now = DateTime.now().toIso8601String();
    final existing = widget.child;

    final updated = Child(
      id: childId,
      name: _nameController.text,
      birthDate: _birthDate ?? '',
      createdAt: existing?.createdAt ?? now,
    );

    if (existing != null) {
      await dao.update(updated);
    } else {
      await dao.insert(updated);
    }

    ref.invalidate(currentChildProvider);
    if (mounted) Navigator.pop(context);
  }
}
