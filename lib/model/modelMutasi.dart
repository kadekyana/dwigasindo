// To parse this JSON data, do
//
//     final modelMutasi = modelMutasiFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ModelMutasi modelMutasiFromJson(String str) =>
    ModelMutasi.fromJson(json.decode(str));

String modelMutasiToJson(ModelMutasi data) => json.encode(data.toJson());

class ModelMutasi {
  List<Datum> data;
  dynamic error;

  ModelMutasi({
    required this.data,
    required this.error,
  });

  ModelMutasi copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelMutasi(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelMutasi.fromJson(Map<String, dynamic> json) => ModelMutasi(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int id;
  String idStr;
  int itemId;
  String itemName;
  int warehouseId;
  String warehouseName;
  String datumOperator;
  int quantity;
  DateTime createdAt;

  Datum({
    required this.id,
    required this.idStr,
    required this.itemId,
    required this.itemName,
    required this.warehouseId,
    required this.warehouseName,
    required this.datumOperator,
    required this.quantity,
    required this.createdAt,
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
        "created_at": createdAt.toIso8601String(),
      };
}
