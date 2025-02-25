// To parse this JSON data, do
//
//     final modelAuth = modelAuthFromJson(jsonString);

import 'dart:convert';

ModelAuth modelAuthFromJson(String str) => ModelAuth.fromJson(json.decode(str));

String modelAuthToJson(ModelAuth data) => json.encode(data.toJson());

class ModelAuth {
  Data data;
  dynamic error;

  ModelAuth({
    required this.data,
    required this.error,
  });

  ModelAuth copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelAuth(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAuth.fromJson(Map<String, dynamic> json) => ModelAuth(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  int id;
  String name;
  String username;
  String email;
  String phone;
  dynamic photo;
  List<dynamic> roles;
  String accessToken;
  int exp;

  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.photo,
    required this.roles,
    required this.accessToken,
    required this.exp,
  });

  Data copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? phone,
    dynamic photo,
    List<dynamic>? roles,
    String? accessToken,
    int? exp,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        photo: photo ?? this.photo,
        roles: roles ?? this.roles,
        accessToken: accessToken ?? this.accessToken,
        exp: exp ?? this.exp,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"],
        roles: List<dynamic>.from(json["roles"].map((x) => x)),
        accessToken: json["access_token"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "photo": photo,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "access_token": accessToken,
        "exp": exp,
      };
}
