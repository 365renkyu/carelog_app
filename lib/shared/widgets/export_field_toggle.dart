import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/core/constants/app_colors.dart';
import 'package:ikuji_kiroku_app/features/export/export_field.dart';

class ExportFieldToggle extends StatelessWidget {
  const ExportFieldToggle({
    super.key,
    required this.fields,
    required this.selected,
    required this.onToggle,
  });

  final List<ExportField> fields;
  final Set<ExportField> selected;
  final ValueChanged<ExportField> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: fields.map((field) {
        final isSelected = selected.contains(field);
        return FilterChip(
          label: Text(field.label),
          selected: isSelected,
          selectedColor: AppColors.primaryLight,
          checkmarkColor: AppColors.primary,
          onSelected: (_) => onToggle(field),
        );
      }).toList(),
    );
  }
}
