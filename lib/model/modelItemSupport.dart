// To parse this JSON data, do
//
//     final modelItemSupport = modelItemSupportFromJson(jsonString);

import 'dart:convert';

ModelItemSupport modelItemSupportFromJson(String str) =>
    ModelItemSupport.fromJson(json.decode(str));

String modelItemSupportToJson(ModelItemSupport data) =>
    json.encode(data.toJson());

class ModelItemSupport {
  List<Datum>? data;
  dynamic error;

  ModelItemSupport({
    this.data,
    this.error,
  });

  factory ModelItemSupport.fromJson(Map<String, dynamic> json) =>
      ModelItemSupport(
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
  String? itemName;
  String? categoryName;
  int? availableStock;
  String? vendorName;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.code,
    this.itemName,
    this.categoryName,
    this.availableStock,
    this.vendorName,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        itemName: json["item_name"],
        categoryName: json["category_name"],
        availableStock: json["available_stock"],
        vendorName: json["vendor_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "item_name": itemName,
        "category_name": categoryName,
        "available_stock": availableStock,
        "vendor_name": vendorName,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
