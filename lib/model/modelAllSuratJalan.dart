// To parse this JSON data, do
//
//     final modelAllSuratJalan = modelAllSuratJalanFromJson(jsonString);

import 'dart:convert';

ModelAllSuratJalan modelAllSuratJalanFromJson(String str) =>
    ModelAllSuratJalan.fromJson(json.decode(str));

String modelAllSuratJalanToJson(ModelAllSuratJalan data) =>
    json.encode(data.toJson());

class ModelAllSuratJalan {
  List<Datum>? data;
  dynamic error;

  ModelAllSuratJalan({
    this.data,
    this.error,
  });

  ModelAllSuratJalan copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllSuratJalan(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllSuratJalan.fromJson(Map<String, dynamic> json) =>
      ModelAllSuratJalan(
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
  int? type;
  int? driverId;
  String? name;
  String? vehicleNumber;
  int? deletedBy;
  String? deletedReason;
  int? createdBy;
  int? customerId;

  Datum({
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

  Datum copyWith({
    int? id,
    String? idStr,
    String? no,
    int? type,
    int? driverId,
    String? name,
    String? vehicleNumber,
    int? deletedBy,
    String? deletedReason,
    int? createdBy,
    int? customerId,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        no: no ?? this.no,
        type: type ?? this.type,
        driverId: driverId ?? this.driverId,
        name: name ?? this.name,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        deletedBy: deletedBy ?? this.deletedBy,
        deletedReason: deletedReason ?? this.deletedReason,
        createdBy: createdBy ?? this.createdBy,
        customerId: customerId ?? this.customerId,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
