// To parse this JSON data, do
//
//     final modelMasterProduk = modelMasterProdukFromJson(jsonString);

import 'dart:convert';

ModelMasterProduk modelMasterProdukFromJson(String str) =>
    ModelMasterProduk.fromJson(json.decode(str));

String modelMasterProdukToJson(ModelMasterProduk data) =>
    json.encode(data.toJson());

class ModelMasterProduk {
  List<Datum>? data;
  dynamic error;

  ModelMasterProduk({
    this.data,
    this.error,
  });

  factory ModelMasterProduk.fromJson(Map<String, dynamic> json) =>
      ModelMasterProduk(
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
  String? code;
  String? name;
  double? hpp;
  double? price;
  String? note;
  int? type;
  bool? isGrade;
  int? tubeGradeId;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.code,
    this.name,
    this.hpp,
    this.price,
    this.note,
    this.type,
    this.isGrade,
    this.tubeGradeId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        hpp: json["hpp"]?.toDouble(),
        price: json["price"]?.toDouble(),
        note: json["note"],
        type: json["type"],
        isGrade: json["is_grade"],
        tubeGradeId: json["tube_grade_id"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "hpp": hpp,
        "price": price,
        "note": note,
        "type": type,
        "is_grade": isGrade,
        "tube_grade_id": tubeGradeId,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
