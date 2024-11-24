// To parse this JSON data, do
//
//     final modelAllLocatModelAllLocation = modelAllLocatModelAllLocationFromJson(jsonString);

import 'dart:convert';

ModelAllLocation modelAllLocationFromJson(String str) =>
    ModelAllLocation.fromJson(json.decode(str));

String modelAllLocationToJson(ModelAllLocation data) =>
    json.encode(data.toJson());

class ModelAllLocation {
  List<Datum> data;
  dynamic error;

  ModelAllLocation({
    required this.data,
    required this.error,
  });

  ModelAllLocation copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllLocation(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllLocation.fromJson(Map<String, dynamic> json) =>
      ModelAllLocation(
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

  Datum({
    required this.id,
    required this.idStr,
    required this.name,
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
