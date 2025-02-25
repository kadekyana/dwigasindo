// To parse this JSON data, do
//
//     final modelAllTubeGas = modelAllTubeGasFromJson(jsonString);

import 'dart:convert';

ModelAllTubeGas modelAllTubeGasFromJson(String str) =>
    ModelAllTubeGas.fromJson(json.decode(str));

String modelAllTubeGasToJson(ModelAllTubeGas data) =>
    json.encode(data.toJson());

class ModelAllTubeGas {
  List<Datum> data;
  dynamic error;

  ModelAllTubeGas({
    required this.data,
    required this.error,
  });

  ModelAllTubeGas copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllTubeGas(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllTubeGas.fromJson(Map<String, dynamic> json) =>
      ModelAllTubeGas(
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
  String code;
  String name;

  Datum({
    required this.id,
    required this.idStr,
    required this.code,
    required this.name,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? code,
    String? name,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        code: code ?? this.code,
        name: name ?? this.name,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "code": code,
        "name": name,
      };
}
