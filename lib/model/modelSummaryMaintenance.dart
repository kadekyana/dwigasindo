// To parse this JSON data, do
//
//     final modelSummaryMaintenance = modelSummaryMaintenanceFromJson(jsonString);

import 'dart:convert';

ModelSummaryMaintenance modelSummaryMaintenanceFromJson(String str) =>
    ModelSummaryMaintenance.fromJson(json.decode(str));

String modelSummaryMaintenanceToJson(ModelSummaryMaintenance data) =>
    json.encode(data.toJson());

class ModelSummaryMaintenance {
  Data? data;
  dynamic error;

  ModelSummaryMaintenance({
    this.data,
    this.error,
  });

  factory ModelSummaryMaintenance.fromJson(Map<String, dynamic> json) =>
      ModelSummaryMaintenance(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  int? totalMaintenance;
  int? totalDone;
  int? totalAfkir;

  Data({
    this.totalMaintenance,
    this.totalDone,
    this.totalAfkir,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalMaintenance: json["total_maintenance"],
        totalDone: json["total_done"],
        totalAfkir: json["total_afkir"],
      );

  Map<String, dynamic> toJson() => {
        "total_maintenance": totalMaintenance,
        "total_done": totalDone,
        "total_afkir": totalAfkir,
      };
}
