// To parse this JSON data, do
//
//     final modelAllBptk = modelAllBptkFromJson(jsonString);

import 'dart:convert';

ModelAllBptk modelAllBptkFromJson(String str) =>
    ModelAllBptk.fromJson(json.decode(str));

String modelAllBptkToJson(ModelAllBptk data) => json.encode(data.toJson());

class ModelAllBptk {
  List<Datum>? data;
  dynamic error;

  ModelAllBptk({
    this.data,
    this.error,
  });

  ModelAllBptk copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllBptk(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllBptk.fromJson(Map<String, dynamic> json) => ModelAllBptk(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int? id;
  String? idStr;
  String? no;
  String? vehicleNumber;
  int? customerId;
  int? createdBy;
  String? customerName;
  DateTime? createdAt;
  String? createdByName;
  int? gasCount;
  String? gasType;

  Datum({
    this.id,
    this.idStr,
    this.no,
    this.vehicleNumber,
    this.customerId,
    this.createdBy,
    this.customerName,
    this.createdAt,
    this.createdByName,
    this.gasCount,
    this.gasType,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? no,
    String? vehicleNumber,
    int? customerId,
    int? createdBy,
    String? customerName,
    DateTime? createdAt,
    String? createdByName,
    int? gasCount,
    String? gasType,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        no: no ?? this.no,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        customerId: customerId ?? this.customerId,
        createdBy: createdBy ?? this.createdBy,
        customerName: customerName ?? this.customerName,
        createdAt: createdAt ?? this.createdAt,
        createdByName: createdByName ?? this.createdByName,
        gasCount: gasCount ?? this.gasCount,
        gasType: gasType ?? this.gasType,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        vehicleNumber: json["vehicle_number"],
        customerId: json["customer_id"],
        createdBy: json["created_by"],
        customerName: json["customer_name"],
        createdAt: DateTime.parse(json["created_at"]),
        createdByName: json["created_by_name"],
        gasCount: json["gas_count"],
        gasType: json["gas_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "vehicle_number": vehicleNumber,
        "customer_id": customerId,
        "created_by": createdBy,
        "customer_name": customerName,
        "created_at": createdAt?.toIso8601String(),
        "created_by_name": createdByName,
        "gas_count": gasCount,
        "gas_type": gasType,
      };
}
