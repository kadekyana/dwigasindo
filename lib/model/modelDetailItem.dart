// To parse this JSON data, do
//
//     final modelDetailBpti = modelDetailBptiFromJson(jsonString);

import 'dart:convert';

ModelDetailBpti modelDetailBptiFromJson(String str) =>
    ModelDetailBpti.fromJson(json.decode(str));

String modelDetailBptiToJson(ModelDetailBpti data) =>
    json.encode(data.toJson());

class ModelDetailBpti {
  Data? data;
  dynamic error;

  ModelDetailBpti({
    this.data,
    this.error,
  });

  factory ModelDetailBpti.fromJson(Map<String, dynamic> json) =>
      ModelDetailBpti(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
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
  int? isItemSell;
  dynamic sellPrice;

  Data({
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
    this.isItemSell,
    this.sellPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        isItemSell: json["is_item_sell"],
        sellPrice: json["sell_price"],
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
        "is_item_sell": isItemSell,
        "sell_price": sellPrice,
      };
}
