import 'package:freezed_annotation/freezed_annotation.dart';

part 'child.freezed.dart';
part 'child.g.dart';

/// 子供情報
@freezed
class Child with _$Child {
  const factory Child({
    required String id,
    required String name,      // ニックネーム
    required String birthDate, // 'YYYY-MM-DD' or ''
    required String createdAt,
  }) = _Child;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
}
