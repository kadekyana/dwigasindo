// To parse this JSON data, do
//
//     final modelAllCostumer = modelAllCostumerFromJson(jsonString);

import 'dart:convert';

ModelAllCostumer modelAllCostumerFromJson(String str) =>
    ModelAllCostumer.fromJson(json.decode(str));

String modelAllCostumerToJson(ModelAllCostumer data) =>
    json.encode(data.toJson());

class ModelAllCostumer {
  List<Datum> data;
  dynamic error;

  ModelAllCostumer({
    required this.data,
    required this.error,
  });

  ModelAllCostumer copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllCostumer(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllCostumer.fromJson(Map<String, dynamic> json) =>
      ModelAllCostumer(
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
  String address;

  Datum({
    required this.id,
    required this.idStr,
    required this.name,
    required this.address,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    String? address,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        address: address ?? this.address,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "address": address,
      };
}
