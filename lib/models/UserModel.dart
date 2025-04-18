import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Profile? profile;
  String? id;
  String? roles;
  String? fullName;
  String? gender;
  String? email;
  String? address;
  String? phone;
  String? image;
  String? countryCode;
  String? password;
  bool? verified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? refreshToken;

  UserModel({
    this.profile,
    this.id,
    this.roles,
    this.fullName,
    this.gender,
    this.email,
    this.address,
    this.phone,
    this.image,
    this.countryCode,
    this.password,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map json) => UserModel(
    profile: Profile.fromJson(json["profile"]),
    id: json["id"],
    roles: json["roles"],
    fullName: json["fullName"],
    gender: json["gender"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    image: json["image"],
    countryCode: json["countryCode"],
    password: json["password"],
    verified: json["verified"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["v"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
    "id": id,
    "roles": roles,
    "fullName": fullName,
    "gender": gender,
    "email": email,
    "address": address,
    "phone": phone,
    "image": image,
    "countryCode": countryCode,
    "password": password,
    "verified": verified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "v": v,
    "refreshToken": refreshToken,
  };
}

class Profile {
  String? appName;
  String? appKey;

  Profile({
    this.appName,
    this.appKey,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    appName: json["appName"],
    appKey: json["appKey"],
  );

  Map<String, dynamic> toJson() => {
    "appName": appName,
    "appKey": appKey,
  };
}
