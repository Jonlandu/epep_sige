import 'dart:convert';
import 'dart:convert';

SchoolModel schoolModelFromJson(String str) =>
    SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  int id;
  String nom;
  String? logoUrl;
  String? province;
  String? territoireCommuneVille;
  String? proved;
  String? sousproved;
  String? qCiteChefferieVillage;
  String matriculeCecope;
  String arreteMinisteriel;
  String? adresse;
  DateTime createdAt;

  SchoolModel({
    required this.id,
    required this.nom,
    this.logoUrl,
    this.province,
    this.territoireCommuneVille,
    this.proved,
    this.sousproved,
    this.adresse,
    this.qCiteChefferieVillage,
    required this.matriculeCecope,
    required this.arreteMinisteriel,
  }) : createdAt = DateTime.now();

  // Méthode pour sérialiser un objet Etablissement en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'logoUrl': logoUrl,
      'adresse': adresse,
      'province': province,
      'territoire_commune_ville': territoireCommuneVille,
      'proved': proved,
      'sousproved': sousproved,
      'q_cite_chefferie_village': qCiteChefferieVillage,
      'matricule_cecope': matriculeCecope,
      'arrete_ministeriel': arreteMinisteriel,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Méthode pour désérialiser un JSON en objet Etablissement
  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'] ?? "",
      nom: json['nomEtab'] ?? "",
      logoUrl: json['logoUrl'] ?? "",
      adresse: json['adresse'] ?? "",
      province: json['province'] ?? "",
      territoireCommuneVille: json['territoire_commune_ville'] ?? "",
      proved: json['proved'] ?? "",
      sousproved: json['sousproved'] ?? "",
      qCiteChefferieVillage: json['q_cite_chefferie_village'] ?? "",
      matriculeCecope: json['matricule_cecope'] ?? "",
      arreteMinisteriel: json['arrete_ministeriel'] ?? "",
    );
  }

  @override
  String toString() {
    return '$nom ($arreteMinisteriel)';
  }
}

class SchoolImage {
  final String id;
  final String url;
  final bool isPrimary;
  final String? description;

  SchoolImage({
    required this.id,
    required this.url,
    this.isPrimary = false,
    this.description,
  });

  factory SchoolImage.fromJson(Map<String, dynamic> json) => SchoolImage(
        id: json["id"]?.toString() ?? '',
        url: json["url"] ?? json["image_url"] ?? '',
        isPrimary: json["is_primary"] ?? false,
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "is_primary": isPrimary,
        "description": description,
      };

  SchoolImage copyWith({
    String? id,
    String? url,
    bool? isPrimary,
    String? description,
  }) {
    return SchoolImage(
      id: id ?? this.id,
      url: url ?? this.url,
      isPrimary: isPrimary ?? this.isPrimary,
      description: description ?? this.description,
    );
  }
}
