// To parse this JSON data, do
//
//     final modelVendorCategory = modelVendorCategoryFromJson(jsonString);

import 'dart:convert';

ModelVendorCategory modelVendorCategoryFromJson(String str) =>
    ModelVendorCategory.fromJson(json.decode(str));

String modelVendorCategoryToJson(ModelVendorCategory data) =>
    json.encode(data.toJson());

class ModelVendorCategory {
  List<Datum>? data;
  dynamic error;

  ModelVendorCategory({
    this.data,
    this.error,
  });

  factory ModelVendorCategory.fromJson(Map<String, dynamic> json) =>
      ModelVendorCategory(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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
