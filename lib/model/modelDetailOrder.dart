// To parse this JSON data, do
//
//     final modelDetailOrder = modelDetailOrderFromJson(jsonString);

import 'dart:convert';

ModelDetailOrder modelDetailOrderFromJson(String str) =>
    ModelDetailOrder.fromJson(json.decode(str));

String modelDetailOrderToJson(ModelDetailOrder data) =>
    json.encode(data.toJson());

class ModelDetailOrder {
  Data? data;
  dynamic error;

  ModelDetailOrder({
    this.data,
    this.error,
  });

  factory ModelDetailOrder.fromJson(Map<String, dynamic> json) =>
      ModelDetailOrder(
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
  String? code;
  String? customerName;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Item>? items;
  List<Product>? products;

  Data({
    this.id,
    this.code,
    this.customerName,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        customerName: json["customer_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "customer_name": customerName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  int? itemId;
  String? itemName;
  int? qty;
  int? remainigQty;
  dynamic note;

  Item({
    this.id,
    this.itemId,
    this.itemName,
    this.qty,
    this.remainigQty,
    this.note,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        qty: json["qty"],
        remainigQty: json["remainig_qty"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_name": itemName,
        "qty": qty,
        "remainig_qty": remainigQty,
        "note": note,
      };
}

class Product {
  int? id;
  int? productId;
  String? productName;
  int? type;
  bool? isGrade;
  int? gradeId;
  String? gradeName;
  int? remainigQty;
  int? qty;
  dynamic note;

  Product({
    this.id,
    this.productId,
    this.productName,
    this.type,
    this.isGrade,
    this.gradeId,
    this.gradeName,
    this.remainigQty,
    this.qty,
    this.note,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        type: json["type"],
        isGrade: json["is_grade"],
        gradeId: json["grade_id"],
        gradeName: json["grade_name"],
        remainigQty: json["remainig_qty"],
        qty: json["qty"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "type": type,
        "is_grade": isGrade,
        "grade_id": gradeId,
        "grade_name": gradeName,
        "remainig_qty": remainigQty,
        "qty": qty,
        "note": note,
      };
}
