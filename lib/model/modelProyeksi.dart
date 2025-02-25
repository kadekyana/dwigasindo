// To parse this JSON data, do
//
//     final modelProyeksi = modelProyeksiFromJson(jsonString);

import 'dart:convert';

ModelProyeksi modelProyeksiFromJson(String str) =>
    ModelProyeksi.fromJson(json.decode(str));

String modelProyeksiToJson(ModelProyeksi data) => json.encode(data.toJson());

class ModelProyeksi {
  List<Datum>? data;
  dynamic error;

  ModelProyeksi({
    this.data,
    this.error,
  });

  factory ModelProyeksi.fromJson(Map<String, dynamic> json) => ModelProyeksi(
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;

  Datum({
    this.id,
    this.productId,
    this.productName,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
      };
}
