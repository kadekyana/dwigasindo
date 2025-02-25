// To parse this JSON data, do
//
//     final modelTank = modelTankFromJson(jsonString);

import 'dart:convert';

ModelTank modelTankFromJson(String str) => ModelTank.fromJson(json.decode(str));

String modelTankToJson(ModelTank data) => json.encode(data.toJson());

class ModelTank {
  List<Datum>? data;
  dynamic error;

  ModelTank({
    this.data,
    this.error,
  });

  factory ModelTank.fromJson(Map<String, dynamic> json) => ModelTank(
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
  int? tankId;
  int? vendorId;
  String? vendorName;
  int? itemId;
  String? itemName;
  int? qty;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.idStr,
    this.tankId,
    this.vendorId,
    this.vendorName,
    this.itemId,
    this.itemName,
    this.qty,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        tankId: json["tank_id"],
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        qty: json["qty"],
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
        "tank_id": tankId,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "item_id": itemId,
        "item_name": itemName,
        "qty": qty,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
