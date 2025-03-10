// To parse this JSON data, do
//
//     final modelCard = modelCardFromJson(jsonString);

import 'dart:convert';

ModelCard modelCardFromJson(String str) => ModelCard.fromJson(json.decode(str));

String modelCardToJson(ModelCard data) => json.encode(data.toJson());

class ModelCard {
  Data? data;
  dynamic error;

  ModelCard({
    this.data,
    this.error,
  });

  factory ModelCard.fromJson(Map<String, dynamic> json) => ModelCard(
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
  String? code;
  String? photo;
  dynamic oldTubeNumber;
  int? ownerShipType;
  bool? isHasTubeType;
  int? tubeTypeId;
  String? tubeTypeName;
  bool? isHasGrade;
  int? tubeGradeId;
  String? tubeGradeName;
  int? tubeYear;
  String? serialNumber;
  int? customerId;
  String? customerName;
  int? vendorId;
  String? vendorName;
  String? lastLocation;
  int? tubeGasId;
  String? tubeGasName;

  Data({
    this.id,
    this.idStr,
    this.code,
    this.photo,
    this.oldTubeNumber,
    this.ownerShipType,
    this.isHasTubeType,
    this.tubeTypeId,
    this.tubeTypeName,
    this.isHasGrade,
    this.tubeGradeId,
    this.tubeGradeName,
    this.tubeYear,
    this.serialNumber,
    this.customerId,
    this.customerName,
    this.vendorId,
    this.vendorName,
    this.lastLocation,
    this.tubeGasId,
    this.tubeGasName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        code: json["code"],
        photo: json["photo"],
        oldTubeNumber: json["old_tube_number"],
        ownerShipType: json["owner_ship_type"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeId: json["tube_type_id"],
        tubeTypeName: json["tube_type_name"],
        isHasGrade: json["is_has_grade"],
        tubeGradeId: json["tube_grade_id"],
        tubeGradeName: json["tube_grade_name"],
        tubeYear: json["tube_year"],
        serialNumber: json["serial_number"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        lastLocation: json["last_location"],
        tubeGasId: json["tube_gas_id"],
        tubeGasName: json["tube_gas_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "code": code,
        "photo": photo,
        "old_tube_number": oldTubeNumber,
        "owner_ship_type": ownerShipType,
        "is_has_tube_type": isHasTubeType,
        "tube_type_id": tubeTypeId,
        "tube_type_name": tubeTypeName,
        "is_has_grade": isHasGrade,
        "tube_grade_id": tubeGradeId,
        "tube_grade_name": tubeGradeName,
        "tube_year": tubeYear,
        "serial_number": serialNumber,
        "customer_id": customerId,
        "customer_name": customerName,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "last_location": lastLocation,
        "tube_gas_id": tubeGasId,
        "tube_gas_name": tubeGasName,
      };
}
