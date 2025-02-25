// To parse this JSON data, do
//
//     final modelMixRak = modelMixRakFromJson(jsonString);

import 'dart:convert';

ModelMixRak modelMixRakFromJson(String str) =>
    ModelMixRak.fromJson(json.decode(str));

String modelMixRakToJson(ModelMixRak data) => json.encode(data.toJson());

class ModelMixRak {
  List<Datum>? data;
  dynamic error;

  ModelMixRak({
    this.data,
    this.error,
  });

  ModelMixRak copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelMixRak(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelMixRak.fromJson(Map<String, dynamic> json) => ModelMixRak(
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
  int? mixGasShelfGroupId;
  String? mixGasShelfGroupName;

  Datum({
    this.id,
    this.idStr,
    this.name,
    this.mixGasShelfGroupId,
    this.mixGasShelfGroupName,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    int? mixGasShelfGroupId,
    String? mixGasShelfGroupName,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        mixGasShelfGroupId: mixGasShelfGroupId ?? this.mixGasShelfGroupId,
        mixGasShelfGroupName: mixGasShelfGroupName ?? this.mixGasShelfGroupName,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        mixGasShelfGroupId: json["mix_gas_shelf_group_id"],
        mixGasShelfGroupName: json["mix_gas_shelf_group_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "mix_gas_shelf_group_id": mixGasShelfGroupId,
        "mix_gas_shelf_group_name": mixGasShelfGroupName,
      };
}
