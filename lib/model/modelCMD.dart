// To parse this JSON data, do
//
//     final modelCmd = modelCmdFromJson(jsonString);

import 'dart:convert';

ModelCmd modelCmdFromJson(String str) => ModelCmd.fromJson(json.decode(str));

String modelCmdToJson(ModelCmd data) => json.encode(data.toJson());

class ModelCmd {
  final List<Datum> data;
  final dynamic error;

  ModelCmd({
    required this.data,
    required this.error,
  });

  factory ModelCmd.fromJson(Map<String, dynamic> json) => ModelCmd(
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
  final String code;
  final String name;
  final DateTime? cooperationSince;
  final String? cooperationSinceToIdn;
  final String districtComplete;
  final bool isLimitPlatform;
  final int limitPlatform;
  final int totalOrder;
  final int remaining;

  Datum({
    required this.id,
    required this.code,
    required this.name,
    required this.cooperationSince,
    required this.cooperationSinceToIdn,
    required this.districtComplete,
    required this.isLimitPlatform,
    required this.limitPlatform,
    required this.totalOrder,
    required this.remaining,
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
