// To parse this JSON data, do
//
//     final modelAllRak = modelAllRakFromJson(jsonString);

import 'dart:convert';

ModelAllRak modelAllRakFromJson(String str) =>
    ModelAllRak.fromJson(json.decode(str));

String modelAllRakToJson(ModelAllRak data) => json.encode(data.toJson());

class ModelAllRak {
  List<Datum>? data;
  dynamic error;

  ModelAllRak({
    this.data,
    this.error,
  });

  ModelAllRak copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllRak(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllRak.fromJson(Map<String, dynamic> json) => ModelAllRak(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int? id;
  String? idStr;
  String? name;
  int? isActive;
  int? productionTypeId;

  Datum({
    this.id,
    this.idStr,
    this.name,
    this.isActive,
    this.productionTypeId,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    int? isActive,
    int? productionTypeId,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        productionTypeId: productionTypeId ?? this.productionTypeId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        isActive: json["is_active"],
        productionTypeId: json["production_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "is_active": isActive,
        "production_type_id": productionTypeId,
      };
}
