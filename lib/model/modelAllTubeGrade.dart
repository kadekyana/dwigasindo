// To parse this JSON data, do
//
//     final modelAllTubeGrades = modelAllTubeGradesFromJson(jsonString);

import 'dart:convert';

ModelAllTubeGrades modelAllTubeGradesFromJson(String str) =>
    ModelAllTubeGrades.fromJson(json.decode(str));

String modelAllTubeGradesToJson(ModelAllTubeGrades data) =>
    json.encode(data.toJson());

class ModelAllTubeGrades {
  List<Datum> data;
  dynamic error;

  ModelAllTubeGrades({
    required this.data,
    required this.error,
  });

  ModelAllTubeGrades copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllTubeGrades(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllTubeGrades.fromJson(Map<String, dynamic> json) =>
      ModelAllTubeGrades(
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
