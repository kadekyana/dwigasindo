// To parse this JSON data, do
//
//     final modelAllTank = modelAllTankFromJson(jsonString);

import 'dart:convert';

ModelAllTank modelAllTankFromJson(String str) =>
    ModelAllTank.fromJson(json.decode(str));

String modelAllTankToJson(ModelAllTank data) => json.encode(data.toJson());

class ModelAllTank {
  List<Datum>? data;
  dynamic error;

  ModelAllTank({
    this.data,
    this.error,
  });

  ModelAllTank copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllTank(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllTank.fromJson(Map<String, dynamic> json) => ModelAllTank(
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

  Datum({
    this.id,
    this.idStr,
    this.name,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
      };
}
