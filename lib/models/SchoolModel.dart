import 'dart:convert';

SchoolModel schoolModelFromJson(String str) => SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  final String id;
  final String name;
  final String abbreviation;
  final String logoUrl;
  final String description;
  final String address;
  final String phone;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SchoolImage> images;
  final int? studentCount;
  final int? teacherCount;
  final String? website;
  final String? directorName;
  final double? rating;
  final int? studentsCount;

  SchoolModel({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.logoUrl,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    this.createdAt,
    this.updatedAt,
    this.images = const [],
    this.studentCount,
    this.teacherCount,
    this.website,
    this.directorName,
    this.rating,
    this.studentsCount,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    id: json["id"]?.toString() ?? '',
    name: json["name"] ?? '',
    abbreviation: json["abbreviation"] ?? json["short_name"] ?? '',
    logoUrl: json["logo_url"] ?? json["logo"] ?? 'https://via.placeholder.com/150?text=${(json["name"] ?? 'ECO').substring(0, 3)}',
    description: json["description"] ?? json["about"] ?? '',
    address: json["address"] ?? json["location"] ?? '',
    phone: json["phone"] ?? json["telephone"] ?? '',
    email: json["email"] ?? json["contact_email"] ?? '',
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null
        ? []
        : List<SchoolImage>.from(json["images"].map((x) => SchoolImage.fromJson(x))),
    studentCount: json["student_count"] ?? json["students"],
    teacherCount: json["teacher_count"] ?? json["teachers"],
    website: json["website"],
    directorName: json["director_name"] ?? json["director"],
    rating: json["rating"]?.toDouble(),
    studentsCount: json["student_count"] ?? json["students"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abbreviation": abbreviation,
    "logo_url": logoUrl,
    "description": description,
    "address": address,
    "phone": phone,
    "email": email,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "student_count": studentCount,
    "teacher_count": teacherCount,
    "website": website,
    "director_name": directorName,
    "rating": rating,
    "student_count": studentsCount,
  };

  SchoolModel copyWith({
    String? id,
    String? name,
    String? abbreviation,
    String? logoUrl,
    String? description,
    String? address,
    String? phone,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SchoolImage>? images,
    int? studentCount,
    int? teacherCount,
    String? website,
    String? directorName,
    double? rating,
    int? studentsCount,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      logoUrl: logoUrl ?? this.logoUrl,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      studentCount: studentCount ?? this.studentCount,
      teacherCount: teacherCount ?? this.teacherCount,
      website: website ?? this.website,
      directorName: directorName ?? this.directorName,
      rating: rating ?? this.rating,
      studentsCount: studentsCount ?? this.studentsCount,
    );
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