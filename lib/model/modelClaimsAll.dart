// To parse this JSON data, do
//
//     final modelClaimsAll = modelClaimsAllFromJson(jsonString);

import 'dart:convert';

ModelClaimsAll modelClaimsAllFromJson(String str) =>
    ModelClaimsAll.fromJson(json.decode(str));

String modelClaimsAllToJson(ModelClaimsAll data) => json.encode(data.toJson());

class ModelClaimsAll {
  List<Datum>? data;
  dynamic error;

  ModelClaimsAll({
    this.data,
    this.error,
  });

  factory ModelClaimsAll.fromJson(Map<String, dynamic> json) => ModelClaimsAll(
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
  String? idStr;
  String? claimNo;
  String? tubeCode;
  String? tubeGasName;
  dynamic tubeGradeName;
  bool? isHasGrade;
  int? ownerShipType;
  dynamic customerName;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.idStr,
    this.claimNo,
    this.tubeCode,
    this.tubeGasName,
    this.tubeGradeName,
    this.isHasGrade,
    this.ownerShipType,
    this.customerName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        claimNo: json["claim_no"],
        tubeCode: json["tube_code"],
        tubeGasName: json["tube_gas_name"],
        tubeGradeName: json["tube_grade_name"],
        isHasGrade: json["is_has_grade"],
        ownerShipType: json["owner_ship_type"],
        customerName: json["customer_name"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "claim_no": claimNo,
        "tube_code": tubeCode,
        "tube_gas_name": tubeGasName,
        "tube_grade_name": tubeGradeName,
        "is_has_grade": isHasGrade,
        "owner_ship_type": ownerShipType,
        "customer_name": customerName,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
