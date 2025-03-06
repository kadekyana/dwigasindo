// To parse this JSON data, do
//
//     final modelDetailSuratJalanItem = modelDetailSuratJalanItemFromJson(jsonString);

import 'dart:convert';

ModelDetailSuratJalanItem modelDetailSuratJalanItemFromJson(String str) =>
    ModelDetailSuratJalanItem.fromJson(json.decode(str));

String modelDetailSuratJalanItemToJson(ModelDetailSuratJalanItem data) =>
    json.encode(data.toJson());

class ModelDetailSuratJalanItem {
  List<Datum>? data;
  dynamic error;

  ModelDetailSuratJalanItem({
    this.data,
    this.error,
  });

  factory ModelDetailSuratJalanItem.fromJson(Map<String, dynamic> json) =>
      ModelDetailSuratJalanItem(
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
  String? idStr;
  String? no;
  int? status;
  int? type;
  dynamic driverId;
  dynamic driverName;
  String? nonUserName;
  String? vehicleNumber;
  dynamic deletedBy;
  dynamic deletedByName;
  dynamic deletedReason;
  int? createdBy;
  String? createdByName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.idStr,
    this.no,
    this.status,
    this.type,
    this.driverId,
    this.driverName,
    this.nonUserName,
    this.vehicleNumber,
    this.deletedBy,
    this.deletedByName,
    this.deletedReason,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        status: json["status"],
        type: json["type"],
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        nonUserName: json["non_user_name"],
        vehicleNumber: json["vehicle_number"],
        deletedBy: json["deleted_by"],
        deletedByName: json["deleted_by_name"],
        deletedReason: json["deleted_reason"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "status": status,
        "type": type,
        "driver_id": driverId,
        "driver_name": driverName,
        "non_user_name": nonUserName,
        "vehicle_number": vehicleNumber,
        "deleted_by": deletedBy,
        "deleted_by_name": deletedByName,
        "deleted_reason": deletedReason,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
