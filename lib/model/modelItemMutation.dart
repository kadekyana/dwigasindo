// To parse this JSON data, do
//
//     final modelItemMutation = modelItemMutationFromJson(jsonString);

import 'dart:convert';

ModelItemMutation modelItemMutationFromJson(String str) =>
    ModelItemMutation.fromJson(json.decode(str));

String modelItemMutationToJson(ModelItemMutation data) =>
    json.encode(data.toJson());

class ModelItemMutation {
  final List<Datum>? data;
  final dynamic error;

  ModelItemMutation({
    this.data,
    this.error,
  });

  ModelItemMutation copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelItemMutation(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelItemMutation.fromJson(Map<String, dynamic> json) =>
      ModelItemMutation(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  final int? id;
  final String? idStr;
  final int? itemId;
  final String? itemName;
  final int? warehouseId;
  final String? warehouseName;
  final String? datumOperator;
  final int? quantity;
  final DateTime? createdAt;

  Datum({
    this.id,
    this.idStr,
    this.itemId,
    this.itemName,
    this.warehouseId,
    this.warehouseName,
    this.datumOperator,
    this.quantity,
    this.createdAt,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    int? itemId,
    String? itemName,
    int? warehouseId,
    String? warehouseName,
    String? datumOperator,
    int? quantity,
    DateTime? createdAt,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        warehouseId: warehouseId ?? this.warehouseId,
        warehouseName: warehouseName ?? this.warehouseName,
        datumOperator: datumOperator ?? this.datumOperator,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        warehouseId: json["warehouse_id"],
        warehouseName: json["warehouse_name"],
        datumOperator: json["operator"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "item_id": itemId,
        "item_name": itemName,
        "warehouse_id": warehouseId,
        "warehouse_name": warehouseName,
        "operator": datumOperator,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
      };
}
