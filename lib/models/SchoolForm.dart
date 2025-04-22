class SchoolForm {
  final int? id;
  final int idannee;
  final int idetablissement;
  final Map<String, dynamic> formData;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SchoolForm({
    this.id,
    required this.idannee,
    required this.idetablissement,
    required this.formData,
    this.isSynced = false,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idannee': idannee,
      'idetablissement': idetablissement,
      'form_data': formData.toString(),
      'is_synced': isSynced ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory SchoolForm.fromMap(Map<String, dynamic> map) {
    return SchoolForm(
      id: map['id'],
      idannee: map['idannee'],
      idetablissement: map['idetablissement'],
      formData: Map<String, dynamic>.from(map['form_data']),
      isSynced: map['is_synced'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}