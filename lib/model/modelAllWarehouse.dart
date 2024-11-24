// To parse this JSON data, do
//
//     final modelAllWarehouse = modelAllWarehouseFromJson(jsonString);

import 'dart:convert';

ModelAllWarehouse modelAllWarehouseFromJson(String str) =>
    ModelAllWarehouse.fromJson(json.decode(str));

String modelAllWarehouseToJson(ModelAllWarehouse data) =>
    json.encode(data.toJson());

class ModelAllWarehouse {
  List<Datum> data;
  dynamic error;

  ModelAllWarehouse({
    required this.data,
    required this.error,
  });

  ModelAllWarehouse copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllWarehouse(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllWarehouse.fromJson(Map<String, dynamic> json) =>
      ModelAllWarehouse(
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
  String name;
  String code;

  Datum({
    required this.id,
    required this.idStr,
    required this.name,
    required this.code,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    String? code,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "code": code,
      };
}
