// To parse this JSON data, do
//
//     final modelAllOrder = modelAllOrderFromJson(jsonString);

import 'dart:convert';

ModelAllOrder modelAllOrderFromJson(String str) =>
    ModelAllOrder.fromJson(json.decode(str));

String modelAllOrderToJson(ModelAllOrder data) => json.encode(data.toJson());

class ModelAllOrder {
  List<Datum>? data;
  dynamic error;

  ModelAllOrder({
    this.data,
    this.error,
  });

  factory ModelAllOrder.fromJson(Map<String, dynamic> json) => ModelAllOrder(
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
  int? type;
  String? createdBy;
  String? customerName;
  int? totalTransaction;
  String? remarks;
  String? approvalStatus;
  String? districtName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.code,
    this.type,
    this.createdBy,
    this.customerName,
    this.totalTransaction,
    this.remarks,
    this.approvalStatus,
    this.districtName,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        createdBy: json["created_by"],
        customerName: json["customer_name"],
        totalTransaction: json["total_transaction"],
        remarks: json["remarks"],
        approvalStatus: json["approval_status"],
        districtName: json["district_name"],
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
        "type": type,
        "created_by": createdBy,
        "customer_name": customerName,
        "total_transaction": totalTransaction,
        "remarks": remarks,
        "approval_status": approvalStatus,
        "district_name": districtName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
