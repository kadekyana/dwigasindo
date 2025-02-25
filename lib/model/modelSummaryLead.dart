// To parse this JSON data, do
//
//     final modelSummaryLeads = modelSummaryLeadsFromJson(jsonString);

import 'dart:convert';

ModelSummaryLeads modelSummaryLeadsFromJson(String str) =>
    ModelSummaryLeads.fromJson(json.decode(str));

String modelSummaryLeadsToJson(ModelSummaryLeads data) =>
    json.encode(data.toJson());

class ModelSummaryLeads {
  final Data data;
  final dynamic error;

  ModelSummaryLeads({
    required this.data,
    required this.error,
  });

  ModelSummaryLeads copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelSummaryLeads(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelSummaryLeads.fromJson(Map<String, dynamic> json) =>
      ModelSummaryLeads(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  final int totalLead;
  final int totalDeal;

  Data({
    required this.totalLead,
    required this.totalDeal,
  });

  Data copyWith({
    int? totalLead,
    int? totalDeal,
  }) =>
      Data(
        totalLead: totalLead ?? this.totalLead,
        totalDeal: totalDeal ?? this.totalDeal,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalLead: json["total_lead"],
        totalDeal: json["total_deal"],
      );

  Map<String, dynamic> toJson() => {
        "total_lead": totalLead,
        "total_deal": totalDeal,
      };
}
