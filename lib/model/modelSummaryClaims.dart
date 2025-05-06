// To parse this JSON data, do
//
//     final modelSummaryClaims = modelSummaryClaimsFromJson(jsonString);

import 'dart:convert';

ModelSummaryClaims modelSummaryClaimsFromJson(String str) =>
    ModelSummaryClaims.fromJson(json.decode(str));

String modelSummaryClaimsToJson(ModelSummaryClaims data) =>
    json.encode(data.toJson());

class ModelSummaryClaims {
  Data? data;
  dynamic error;

  ModelSummaryClaims({
    this.data,
    this.error,
  });

  factory ModelSummaryClaims.fromJson(Map<String, dynamic> json) =>
      ModelSummaryClaims(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  int? totalClaim;
  int? totalReturnCustomer;

  Data({
    this.totalClaim,
    this.totalReturnCustomer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalClaim: json["total_claim"],
        totalReturnCustomer: json["total_return_customer"],
      );

  Map<String, dynamic> toJson() => {
        "total_claim": totalClaim,
        "total_return_customer": totalReturnCustomer,
      };
}
