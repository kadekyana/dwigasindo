// To parse this JSON data, do
//
//     final modelAlokasi = modelAlokasiFromJson(jsonString);

import 'dart:convert';

ModelAlokasi modelAlokasiFromJson(String str) =>
    ModelAlokasi.fromJson(json.decode(str));

String modelAlokasiToJson(ModelAlokasi data) => json.encode(data.toJson());

class ModelAlokasi {
  List<Datum>? data;
  dynamic error;

  ModelAlokasi({
    this.data,
    this.error,
  });

  factory ModelAlokasi.fromJson(Map<String, dynamic> json) => ModelAlokasi(
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
  int? productId;
  String? productName;
  int? salesPerMonth;
  int? toTubeCraddle;
  int? availableTube;
  double? allocationTube;
  double? tubeAddition;

  Datum({
    this.id,
    this.productId,
    this.productName,
    this.salesPerMonth,
    this.toTubeCraddle,
    this.availableTube,
    this.allocationTube,
    this.tubeAddition,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        salesPerMonth: json["sales_per_month"],
        toTubeCraddle: json["to_tube_craddle"],
        availableTube: json["available_tube"],
        allocationTube: json["allocation_tube"]?.toDouble(),
        tubeAddition: json["tube_addition"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "sales_per_month": salesPerMonth,
        "to_tube_craddle": toTubeCraddle,
        "available_tube": availableTube,
        "allocation_tube": allocationTube,
        "tube_addition": tubeAddition,
      };
}
