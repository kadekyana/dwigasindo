// To parse this JSON data, do
//
//     final modelDetailStock = modelDetailStockFromJson(jsonString);

import 'dart:convert';

ModelDetailStock modelDetailStockFromJson(String str) =>
    ModelDetailStock.fromJson(json.decode(str));

String modelDetailStockToJson(ModelDetailStock data) =>
    json.encode(data.toJson());

class ModelDetailStock {
  Data? data;
  dynamic error;

  ModelDetailStock({
    this.data,
    this.error,
  });

  factory ModelDetailStock.fromJson(Map<String, dynamic> json) =>
      ModelDetailStock(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  String? warehouseName;
  String? categories;
  List<int>? categoriesIds;
  int? warehouseId;
  List<Detail>? details;

  Data({
    this.warehouseName,
    this.categories,
    this.categoriesIds,
    this.warehouseId,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        warehouseName: json["warehouse_name"],
        categories: json["categories"],
        categoriesIds: json["categories_ids"] == null
            ? []
            : List<int>.from(json["categories_ids"]!.map((x) => x)),
        warehouseId: json["warehouse_id"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "warehouse_name": warehouseName,
        "categories": categories,
        "categories_ids": categoriesIds == null
            ? []
            : List<dynamic>.from(categoriesIds!.map((x) => x)),
        "warehouse_id": warehouseId,
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? code;
  String? name;
  int? totalQty;
  String? categoryName;

  Detail({
    this.id,
    this.code,
    this.name,
    this.totalQty,
    this.categoryName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        totalQty: json["total_qty"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "total_qty": totalQty,
        "category_name": categoryName,
      };
}
