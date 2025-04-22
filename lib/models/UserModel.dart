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

  UserModel({
    required this.id,
    required this.nom,
    required this.telephone,
    required this.role,
    required this.photo,
    required this.email,
    required this.dateEnregistrement,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nom: json['nom'] ?? 'Non spécifié',
      telephone: json['telephone'] ?? '',
      role: json['role'] ?? 'Utilisateur',
      photo: json['photo'] ?? '',
      email: json['email'] ?? '',
      dateEnregistrement: DateTime.parse(json['date_enregistrement']),
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
    };
  }
}