import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int id;
  final String nom;
  final String telephone;
  final String role;
  final String photo;
  final String email;
  final DateTime dateEnregistrement;
  final String? province; // Ajout de la province
  final String? proved; // Ajout de proved
  final String? sousDivision; // Ajout de sousDivision

  UserModel({
    required this.id,
    required this.nom,
    required this.telephone,
    required this.role,
    required this.photo,
    required this.email,
    required this.dateEnregistrement,
    this.province, // Initialisation de province
    this.proved, // Initialisation de proved
    this.sousDivision, // Initialisation de sousDivision
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 1,
      nom: json['nom'] ?? 'Non spécifié',
      telephone: json['telephone'] ?? '',
      role: json['role'] ?? 'Utilisateur',
      photo: json['photo'] ?? '',
      email: json['email'] ?? '',
      dateEnregistrement:
          DateTime.parse(json['date_enregistrement'] ?? "2025-04-03"),
      province: json['province'] ?? "", // Ajout de la province
      proved: json['proved'] ?? "", // Ajout de proved
      sousDivision: json['sousDivision'] ?? "", // Ajout de sousDivision
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'telephone': telephone,
      'role': role,
      'photo': photo,
      'email': email,
      'date_enregistrement': dateEnregistrement.toIso8601String(),
      'province': province, // Ajout de la province
      'proved': proved, // Ajout de proved
      'sousDivision': sousDivision, // Ajout de sousDivision
    };
  }
}
