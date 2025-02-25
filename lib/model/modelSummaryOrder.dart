// To parse this JSON data, do
//
//     final modelSummaryOrder = modelSummaryOrderFromJson(jsonString);

import 'dart:convert';

ModelSummaryOrder modelSummaryOrderFromJson(String str) =>
    ModelSummaryOrder.fromJson(json.decode(str));

String modelSummaryOrderToJson(ModelSummaryOrder data) =>
    json.encode(data.toJson());

class ModelSummaryOrder {
  Data? data;
  dynamic error;

  ModelSummaryOrder({
    this.data,
    this.error,
  });

  factory ModelSummaryOrder.fromJson(Map<String, dynamic> json) =>
      ModelSummaryOrder(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  int? totalOrder;
  int? totalTransaction;
  int? totalCustomer;

  Data({
    this.totalOrder,
    this.totalTransaction,
    this.totalCustomer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrder: json["total_order"],
        totalTransaction: json["total_transaction"],
        totalCustomer: json["total_customer"],
      );

  Map<String, dynamic> toJson() => {
        "total_order": totalOrder,
        "total_transaction": totalTransaction,
        "total_customer": totalCustomer,
      };
}
