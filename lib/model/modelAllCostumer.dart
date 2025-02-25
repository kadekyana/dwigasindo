// To parse this JSON data, do
//
//     final modelAllCostumer = modelAllCostumerFromJson(jsonString);

import 'dart:convert';

ModelAllCostumer modelAllCostumerFromJson(String str) =>
    ModelAllCostumer.fromJson(json.decode(str));

String modelAllCostumerToJson(ModelAllCostumer data) =>
    json.encode(data.toJson());

class ModelAllCostumer {
  List<Datum>? data;
  dynamic error;

  ModelAllCostumer({
    this.data,
    this.error,
  });

  factory ModelAllCostumer.fromJson(Map<String, dynamic> json) =>
      ModelAllCostumer(
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
  String? code;
  String? name;
  DateTime? cooperationSince;
  String? cooperationSinceToIdn;
  String? districtComplete;
  bool? isLimitPlatform;
  int? limitPlatform;
  int? totalOrder;
  int? remaining;

  Datum({
    this.id,
    this.code,
    this.name,
    this.cooperationSince,
    this.cooperationSinceToIdn,
    this.districtComplete,
    this.isLimitPlatform,
    this.limitPlatform,
    this.totalOrder,
    this.remaining,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        cooperationSince: json["cooperation_since"] == null
            ? null
            : DateTime.parse(json["cooperation_since"]),
        cooperationSinceToIdn: json["cooperation_since_to_idn"],
        districtComplete: json["district_complete"],
        isLimitPlatform: json["is_limit_platform"],
        limitPlatform: json["limit_platform"],
        totalOrder: json["total_order"],
        remaining: json["remaining"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "cooperation_since": cooperationSince?.toIso8601String(),
        "cooperation_since_to_idn": cooperationSinceToIdn,
        "district_complete": districtComplete,
        "is_limit_platform": isLimitPlatform,
        "limit_platform": limitPlatform,
        "total_order": totalOrder,
        "remaining": remaining,
      };
}
