// To parse this JSON data, do
//
//     final modelListSales = modelListSalesFromJson(jsonString);

import 'dart:convert';

ModelListSales modelListSalesFromJson(String str) =>
    ModelListSales.fromJson(json.decode(str));

String modelListSalesToJson(ModelListSales data) => json.encode(data.toJson());

class ModelListSales {
  List<Datum>? data;
  dynamic error;

  ModelListSales({
    this.data,
    this.error,
  });

  factory ModelListSales.fromJson(Map<String, dynamic> json) => ModelListSales(
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
  String? name;
  String? nik;
  int? statusEmployee;
  DateTime? workSince;
  String? workSinceDesc;
  int? totalSales;
  int? totalRemaining;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.nik,
    this.statusEmployee,
    this.workSince,
    this.workSinceDesc,
    this.totalSales,
    this.totalRemaining,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        statusEmployee: json["status_employee"],
        workSince: json["work_since"] == null
            ? null
            : DateTime.parse(json["work_since"]),
        workSinceDesc: json["work_since_desc"],
        totalSales: json["total_sales"],
        totalRemaining: json["total_remaining"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "status_employee": statusEmployee,
        "work_since": workSince?.toIso8601String(),
        "work_since_desc": workSinceDesc,
        "total_sales": totalSales,
        "total_remaining": totalRemaining,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
