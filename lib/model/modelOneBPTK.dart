// To parse this JSON data, do
//
//     final modelOneBptk = modelOneBptkFromJson(jsonString);

import 'dart:convert';

ModelOneBptk modelOneBptkFromJson(String str) =>
    ModelOneBptk.fromJson(json.decode(str));

String modelOneBptkToJson(ModelOneBptk data) => json.encode(data.toJson());

class ModelOneBptk {
  Data? data;
  dynamic error;

  ModelOneBptk({
    this.data,
    this.error,
  });

  ModelOneBptk copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelOneBptk(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelOneBptk.fromJson(Map<String, dynamic> json) => ModelOneBptk(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
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

  Data({
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

  Data copyWith({
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
      Data(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
