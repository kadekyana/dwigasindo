// To parse this JSON data, do
//
//     final modelSummarySales = modelSummarySalesFromJson(jsonString);

import 'dart:convert';

ModelSummarySales modelSummarySalesFromJson(String str) =>
    ModelSummarySales.fromJson(json.decode(str));

String modelSummarySalesToJson(ModelSummarySales data) =>
    json.encode(data.toJson());

class ModelSummarySales {
  Data? data;
  dynamic error;

  ModelSummarySales({
    this.data,
    this.error,
  });

  factory ModelSummarySales.fromJson(Map<String, dynamic> json) =>
      ModelSummarySales(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  int? target;
  int? revenue;
  int? customer;

  Data({
    this.target,
    this.revenue,
    this.customer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        target: json["target"],
        revenue: json["revenue"],
        customer: json["customer"],
      );

  Map<String, dynamic> toJson() => {
        "target": target,
        "revenue": revenue,
        "customer": customer,
      };
}
