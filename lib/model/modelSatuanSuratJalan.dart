// To parse this JSON data, do
//
//     final modelSatuanSuratJalan = modelSatuanSuratJalanFromJson(jsonString);

import 'dart:convert';

ModelSatuanSuratJalan modelSatuanSuratJalanFromJson(String str) =>
    ModelSatuanSuratJalan.fromJson(json.decode(str));

String modelSatuanSuratJalanToJson(ModelSatuanSuratJalan data) =>
    json.encode(data.toJson());

class ModelSatuanSuratJalan {
  Data? data;
  dynamic error;

  ModelSatuanSuratJalan({
    this.data,
    this.error,
  });

  factory ModelSatuanSuratJalan.fromJson(Map<String, dynamic> json) =>
      ModelSatuanSuratJalan(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
  int? type;
  int? driverId;
  String? name;
  String? vehicleNumber;
  dynamic deletedBy;
  dynamic deletedReason;
  int? createdBy;
  int? customerId;

  Data({
    this.id,
    this.idStr,
    this.no,
    this.type,
    this.driverId,
    this.name,
    this.vehicleNumber,
    this.deletedBy,
    this.deletedReason,
    this.createdBy,
    this.customerId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        type: json["type"],
        driverId: json["driver_id"],
        name: json["name"],
        vehicleNumber: json["vehicle_number"],
        deletedBy: json["deleted_by"],
        deletedReason: json["deleted_reason"],
        createdBy: json["created_by"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "type": type,
        "driver_id": driverId,
        "name": name,
        "vehicle_number": vehicleNumber,
        "deleted_by": deletedBy,
        "deleted_reason": deletedReason,
        "created_by": createdBy,
        "customer_id": customerId,
      };
}
