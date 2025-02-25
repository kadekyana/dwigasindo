// To parse this JSON data, do
//
//     final modelProdukCmd = modelProdukCmdFromJson(jsonString);

import 'dart:convert';

ModelProdukCmd modelProdukCmdFromJson(String str) =>
    ModelProdukCmd.fromJson(json.decode(str));

String modelProdukCmdToJson(ModelProdukCmd data) => json.encode(data.toJson());

class ModelProdukCmd {
  final List<Datum>? data;
  final dynamic error;

  ModelProdukCmd({
    this.data,
    this.error,
  });

  factory ModelProdukCmd.fromJson(Map<String, dynamic> json) => ModelProdukCmd(
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
  final int? id;
  final int? type;
  final String? code;
  final String? name;
  final bool? isGrade;
  final int? gradeId;
  final String? gradeName;
  final double? hpp;
  final double? price;
  final String? note;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.id,
    this.type,
    this.code,
    this.name,
    this.isGrade,
    this.gradeId,
    this.gradeName,
    this.hpp,
    this.price,
    this.note,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        code: json["code"],
        name: json["name"],
        isGrade: json["is_grade"],
        gradeId: json["grade_id"],
        gradeName: json["grade_name"],
        hpp: json["hpp"]?.toDouble(),
        price: json["price"]?.toDouble(),
        note: json["note"],
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
        "type": type,
        "code": code,
        "name": name,
        "is_grade": isGrade,
        "grade_id": gradeId,
        "grade_name": gradeName,
        "hpp": hpp,
        "price": price,
        "note": note,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
