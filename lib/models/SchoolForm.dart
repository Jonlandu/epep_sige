import 'dart:convert';

class SchoolForm {
  final int? id;
  final int? idannee;
  final int? idetablissement;
  final Map<String, dynamic> data;
  final bool isSynced;
  final int syncAttempts;
  final DateTime createdAt;
  final DateTime updatedAt;

  SchoolForm({
    this.id,
    this.idannee,
    this.idetablissement,
    required this.data,
    this.isSynced = false,
    this.syncAttempts = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) :
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idannee': idannee,
      'idetablissement': idetablissement,
      'form_data': jsonEncode(data),
      'is_synced': isSynced ? 1 : 0,
      'sync_attempts': syncAttempts,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SchoolForm.fromMap(Map<String, dynamic> map) {
    return SchoolForm(
      id: map['id'],
      idannee: map['idannee'],
      idetablissement: map['idetablissement'],
      data: jsonDecode(map['form_data']),
      isSynced: map['is_synced'] == 1,
      syncAttempts: map['sync_attempts'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}