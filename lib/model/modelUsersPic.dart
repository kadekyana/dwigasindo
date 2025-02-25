// To parse this JSON data, do
//
//     final modelUsersPic = modelUsersPicFromJson(jsonString);

import 'dart:convert';

ModelUsersPic modelUsersPicFromJson(String str) =>
    ModelUsersPic.fromJson(json.decode(str));

String modelUsersPicToJson(ModelUsersPic data) => json.encode(data.toJson());

class ModelUsersPic {
  List<Datum>? data;
  dynamic error;

  ModelUsersPic({
    this.data,
    this.error,
  });

  factory ModelUsersPic.fromJson(Map<String, dynamic> json) => ModelUsersPic(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int? id;
  String? name;
  int? role;

  Datum({
    this.id,
    this.name,
    this.role,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
      };
}
