// To parse this JSON data, do
//
//     final modelAllItem = modelAllItemFromJson(jsonString);

import 'dart:convert';

ModelAllItem modelAllItemFromJson(String str) =>
    ModelAllItem.fromJson(json.decode(str));

String modelAllItemToJson(ModelAllItem data) => json.encode(data.toJson());

class ModelAllItem {
  List<Datum>? data;
  dynamic error;

  ModelAllItem({
    this.data,
    this.error,
  });

  factory ModelAllItem.fromJson(Map<String, dynamic> json) => ModelAllItem(
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
  String? code;
  String? name;
  int? categoryId;
  int? locationId;
  int? unitId;
  int? stock;
  int? price;
  int? limitStock;
  int? vendorId;
  dynamic photo;
  DateTime? createdAt;
  String? vendorName;
  String? createdByName;
  int? isRawMaterial;
  int? isComposition;

  Datum({
    this.id,
    this.idStr,
    this.code,
    this.name,
    this.categoryId,
    this.locationId,
    this.unitId,
    this.stock,
    this.price,
    this.limitStock,
    this.vendorId,
    this.photo,
    this.createdAt,
    this.vendorName,
    this.createdByName,
    this.isRawMaterial,
    this.isComposition,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        code: json["code"],
        name: json["name"],
        categoryId: json["category_id"],
        locationId: json["location_id"],
        unitId: json["unit_id"],
        stock: json["stock"],
        price: json["price"],
        limitStock: json["limit_stock"],
        vendorId: json["vendor_id"],
        photo: json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        vendorName: json["vendor_name"],
        createdByName: json["created_by_name"],
        isRawMaterial: json["is_raw_material"],
        isComposition: json["is_composition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "code": code,
        "name": name,
        "category_id": categoryId,
        "location_id": locationId,
        "unit_id": unitId,
        "stock": stock,
        "price": price,
        "limit_stock": limitStock,
        "vendor_id": vendorId,
        "photo": photo,
        "created_at": createdAt?.toIso8601String(),
        "vendor_name": vendorName,
        "created_by_name": createdByName,
        "is_raw_material": isRawMaterial,
        "is_composition": isComposition,
      };
}
