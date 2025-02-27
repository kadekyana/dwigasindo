// To parse this JSON data, do
//
//     final modelMaintenance = modelMaintenanceFromJson(jsonString);

import 'dart:convert';

ModelMaintenance modelMaintenanceFromJson(String str) =>
    ModelMaintenance.fromJson(json.decode(str));

String modelMaintenanceToJson(ModelMaintenance data) =>
    json.encode(data.toJson());

class ModelMaintenance {
  List<Datum>? data;
  dynamic error;

  ModelMaintenance({
    this.data,
    this.error,
  });

  factory ModelMaintenance.fromJson(Map<String, dynamic> json) =>
      ModelMaintenance(
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
  int? ownerShipType;
  int? typeMaintenance;
  bool? isHasTubeType;
  String? tubeTypeName;
  bool? isHasGrade;
  String? tubeGradeName;
  String? tubeGasName;
  String? maintenanceNo;
  int? lastStatus;
  String? tubeCode;
  DateTime? createdAt;
  int? createdBy;
  String? createdByName;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.ownerShipType,
    this.typeMaintenance,
    this.isHasTubeType,
    this.tubeTypeName,
    this.isHasGrade,
    this.tubeGradeName,
    this.tubeGasName,
    this.maintenanceNo,
    this.lastStatus,
    this.tubeCode,
    this.createdAt,
    this.createdBy,
    this.createdByName,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        ownerShipType: json["owner_ship_type"],
        typeMaintenance: json["type_maintenance"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeName: json["tube_type_name"],
        isHasGrade: json["is_has_grade"],
        tubeGradeName: json["tube_grade_name"],
        tubeGasName: json["tube_gas_name"],
        maintenanceNo: json["maintenance_no"],
        lastStatus: json["last_status"],
        tubeCode: json["tube_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_ship_type": ownerShipType,
        "type_maintenance": typeMaintenance,
        "is_has_tube_type": isHasTubeType,
        "tube_type_name": tubeTypeName,
        "is_has_grade": isHasGrade,
        "tube_grade_name": tubeGradeName,
        "tube_gas_name": tubeGasName,
        "maintenance_no": maintenanceNo,
        "last_status": lastStatus,
        "tube_code": tubeCode,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "created_by_name": createdByName,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
