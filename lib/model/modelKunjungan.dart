// To parse this JSON data, do
//
//     final modelKunjungan = modelKunjunganFromJson(jsonString);

import 'dart:convert';

ModelKunjungan modelKunjunganFromJson(String str) =>
    ModelKunjungan.fromJson(json.decode(str));

String modelKunjunganToJson(ModelKunjungan data) => json.encode(data.toJson());

class ModelKunjungan {
  List<Datum>? data;
  dynamic error;

  ModelKunjungan({
    this.data,
    this.error,
  });

  factory ModelKunjungan.fromJson(Map<String, dynamic> json) => ModelKunjungan(
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
  int? typeVisiting;
  int? type;
  String? location;
  dynamic note;
  String? nik;
  int? statusEmployee;
  int? customerId;
  String? customerName;
  dynamic leadId;
  dynamic leadName;
  DateTime? workSince;
  String? workSinceDesc;
  int? totalSales;
  int? totalRemaining;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.typeVisiting,
    this.type,
    this.location,
    this.note,
    this.nik,
    this.statusEmployee,
    this.customerId,
    this.customerName,
    this.leadId,
    this.leadName,
    this.workSince,
    this.workSinceDesc,
    this.totalSales,
    this.totalRemaining,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        typeVisiting: json["type_visiting"],
        type: json["type"],
        location: json["location"],
        note: json["note"],
        nik: json["nik"],
        statusEmployee: json["status_employee"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        leadId: json["lead_id"],
        leadName: json["lead_name"],
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
        "type_visiting": typeVisiting,
        "type": type,
        "location": location,
        "note": note,
        "nik": nik,
        "status_employee": statusEmployee,
        "customer_id": customerId,
        "customer_name": customerName,
        "lead_id": leadId,
        "lead_name": leadName,
        "work_since": workSince?.toIso8601String(),
        "work_since_desc": workSinceDesc,
        "total_sales": totalSales,
        "total_remaining": totalRemaining,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
