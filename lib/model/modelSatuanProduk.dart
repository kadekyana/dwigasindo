// To parse this JSON data, do
//
//     final modelMasterProdukSatuan = modelMasterProdukSatuanFromJson(jsonString);

import 'dart:convert';

ModelMasterProdukSatuan modelMasterProdukSatuanFromJson(String str) =>
    ModelMasterProdukSatuan.fromJson(json.decode(str));

String modelMasterProdukSatuanToJson(ModelMasterProdukSatuan data) =>
    json.encode(data.toJson());

class ModelMasterProdukSatuan {
  final Data data;
  final dynamic error;

  ModelMasterProdukSatuan({
    required this.data,
    required this.error,
  });

  ModelMasterProdukSatuan copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelMasterProdukSatuan(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelMasterProdukSatuan.fromJson(Map<String, dynamic> json) =>
      ModelMasterProdukSatuan(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  final int id;
  final String code;
  final String name;
  final int hpp;
  final int price;
  final dynamic note;
  final int type;
  final bool isGrade;
  final dynamic tubeGradeId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.code,
    required this.name,
    required this.hpp,
    required this.price,
    required this.note,
    required this.type,
    required this.isGrade,
    required this.tubeGradeId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    String? code,
    String? name,
    int? hpp,
    int? price,
    dynamic note,
    int? type,
    bool? isGrade,
    dynamic tubeGradeId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        hpp: hpp ?? this.hpp,
        price: price ?? this.price,
        note: note ?? this.note,
        type: type ?? this.type,
        isGrade: isGrade ?? this.isGrade,
        tubeGradeId: tubeGradeId ?? this.tubeGradeId,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        hpp: json["hpp"],
        price: json["price"],
        note: json["note"],
        type: json["type"],
        isGrade: json["is_grade"],
        tubeGradeId: json["tube_grade_id"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
