// To parse this JSON data, do
//
//     final modelSummary = modelSummaryFromJson(jsonString);

import 'dart:convert';

ModelSummary modelSummaryFromJson(String str) =>
    ModelSummary.fromJson(json.decode(str));

String modelSummaryToJson(ModelSummary data) => json.encode(data.toJson());

class ModelSummary {
  final Data data;
  final dynamic error;

  ModelSummary({
    required this.data,
    required this.error,
  });

  ModelSummary copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelSummary(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelSummary.fromJson(Map<String, dynamic> json) => ModelSummary(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  final int totalProduct;
  final int totalTypeGas;
  final int totalTypeService;

  Data({
    required this.totalProduct,
    required this.totalTypeGas,
    required this.totalTypeService,
  });

  Data copyWith({
    int? totalProduct,
    int? totalTypeGas,
    int? totalTypeService,
  }) =>
      Data(
        totalProduct: totalProduct ?? this.totalProduct,
        totalTypeGas: totalTypeGas ?? this.totalTypeGas,
        totalTypeService: totalTypeService ?? this.totalTypeService,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalProduct: json["total_product"],
        totalTypeGas: json["total_type_gas"],
        totalTypeService: json["total_type_service"],
      );

  Map<String, dynamic> toJson() => {
        "total_product": totalProduct,
        "total_type_gas": totalTypeGas,
        "total_type_service": totalTypeService,
      };
}
