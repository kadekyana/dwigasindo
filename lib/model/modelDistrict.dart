// To parse this JSON data, do
//
//     final modelDistrict = modelDistrictFromJson(jsonString);

import 'dart:convert';

ModelDistrict modelDistrictFromJson(String str) =>
    ModelDistrict.fromJson(json.decode(str));

String modelDistrictToJson(ModelDistrict data) => json.encode(data.toJson());

class ModelDistrict {
  final List<Datum> data;
  final dynamic error;

  ModelDistrict({
    required this.data,
    required this.error,
  });

  ModelDistrict copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelDistrict(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelDistrict.fromJson(Map<String, dynamic> json) => ModelDistrict(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  final int id;
  final String name;

  Datum({
    required this.id,
    required this.name,
  });

  Datum copyWith({
    int? id,
    String? name,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
