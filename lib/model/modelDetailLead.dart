// To parse this JSON data, do
//
//     final modelDetailLead = modelDetailLeadFromJson(jsonString);

import 'dart:convert';

ModelDetailLead modelDetailLeadFromJson(String str) =>
    ModelDetailLead.fromJson(json.decode(str));

String modelDetailLeadToJson(ModelDetailLead data) =>
    json.encode(data.toJson());

class ModelDetailLead {
  Data? data;
  dynamic error;

  ModelDetailLead({
    this.data,
    this.error,
  });

  factory ModelDetailLead.fromJson(Map<String, dynamic> json) =>
      ModelDetailLead(
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
  String? name;
  String? pic;
  String? phone;
  int? type;
  int? typeCoorporation;
  int? lastStatus;
  String? username;
  String? districtComplete;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Detail>? details;

  Data({
    this.id,
    this.name,
    this.pic,
    this.phone,
    this.type,
    this.typeCoorporation,
    this.lastStatus,
    this.username,
    this.districtComplete,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        pic: json["pic"],
        phone: json["phone"],
        type: json["type"],
        typeCoorporation: json["type_coorporation"],
        lastStatus: json["last_status"],
        username: json["username"],
        districtComplete: json["district_complete"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pic": pic,
        "phone": phone,
        "type": type,
        "type_coorporation": typeCoorporation,
        "last_status": lastStatus,
        "username": username,
        "district_complete": districtComplete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  int? leadsId;
  int? userId;
  int? status;
  String? note;
  String? username;
  List<Product>? products;
  List<Item>? items;

  Detail({
    this.id,
    this.leadsId,
    this.userId,
    this.status,
    this.note,
    this.username,
    this.products,
    this.items,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        leadsId: json["leads_id"],
        userId: json["user_id"],
        status: json["status"],
        note: json["note"],
        username: json["username"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leads_id": leadsId,
        "user_id": userId,
        "status": status,
        "note": note,
        "username": username,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  String? name;
  int? itemId;
  int? hpp;

  Item({
    this.id,
    this.name,
    this.itemId,
    this.hpp,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        itemId: json["item_id"],
        hpp: json["hpp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "item_id": itemId,
        "hpp": hpp,
      };
}

class Product {
  int? id;
  int? productId;
  String? productName;
  int? gasPurify;
  int? cylinderVolume;
  int? fillingPressure;
  int? fillingPressureType;
  int? unitId;
  int? hpp;

  Product({
    this.id,
    this.productId,
    this.productName,
    this.gasPurify,
    this.cylinderVolume,
    this.fillingPressure,
    this.fillingPressureType,
    this.unitId,
    this.hpp,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        gasPurify: json["gas_purify"],
        cylinderVolume: json["cylinder_volume"],
        fillingPressure: json["filling_pressure"],
        fillingPressureType: json["filling_pressure_type"],
        unitId: json["unit_id"],
        hpp: json["hpp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "gas_purify": gasPurify,
        "cylinder_volume": cylinderVolume,
        "filling_pressure": fillingPressure,
        "filling_pressure_type": fillingPressureType,
        "unit_id": unitId,
        "hpp": hpp,
      };
}
