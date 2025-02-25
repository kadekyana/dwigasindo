// To parse this JSON data, do
//
//     final modelLihatSo = modelLihatSoFromJson(jsonString);

import 'dart:convert';

ModelLihatSo modelLihatSoFromJson(String str) =>
    ModelLihatSo.fromJson(json.decode(str));

String modelLihatSoToJson(ModelLihatSo data) => json.encode(data.toJson());

class ModelLihatSo {
  List<Datum>? data;
  dynamic error;

  ModelLihatSo({
    this.data,
    this.error,
  });

  factory ModelLihatSo.fromJson(Map<String, dynamic> json) => ModelLihatSo(
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
  String? warehouseName;
  String? categories;
  int? status;
  String? createdBy;
  bool? isProcessVerified;
  bool? isProcessApproval;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.code,
    this.warehouseName,
    this.categories,
    this.status,
    this.createdBy,
    this.isProcessVerified,
    this.isProcessApproval,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        warehouseName: json["warehouse_name"],
        categories: json["categories"],
        status: json["status"],
        createdBy: json["created_by"],
        isProcessVerified: json["is_process_verified"],
        isProcessApproval: json["is_process_approval"],
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
        "warehouse_name": warehouseName,
        "categories": categories,
        "status": status,
        "created_by": createdBy,
        "is_process_verified": isProcessVerified,
        "is_process_approval": isProcessApproval,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
