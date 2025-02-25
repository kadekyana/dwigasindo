// To parse this JSON data, do
//
//     final modelTube = modelTubeFromJson(jsonString);

import 'dart:convert';

ModelTube modelTubeFromJson(String str) => ModelTube.fromJson(json.decode(str));

String modelTubeToJson(ModelTube data) => json.encode(data.toJson());

class ModelTube {
  List<Datum>? data;

  ModelTube({
    this.data,
  });

  factory ModelTube.fromJson(Map<String, dynamic> json) => ModelTube(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? idStr;
  String? code;
  String? photo;
  int? ownerShipType;
  bool? isHasTubeType;
  int? tubeTypeId;
  bool? isHasGrade;
  int? tubeGradeId;
  int? tubeYear;
  String? serialNumber;
  dynamic customerId;
  String? customerName;
  dynamic vendorId;
  String? vendorName;
  String? lastLocation;
  int? tubeGasId;

  Datum({
    this.id,
    this.idStr,
    this.code,
    this.photo,
    this.ownerShipType,
    this.isHasTubeType,
    this.tubeTypeId,
    this.isHasGrade,
    this.tubeGradeId,
    this.tubeYear,
    this.serialNumber,
    this.customerId,
    this.customerName,
    this.vendorId,
    this.vendorName,
    this.lastLocation,
    this.tubeGasId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        code: json["code"],
        photo: json["photo"],
        ownerShipType: json["owner_ship_type"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeId: json["tube_type_id"],
        isHasGrade: json["is_has_grade"],
        tubeGradeId: json["tube_grade_id"],
        tubeYear: json["tube_year"],
        serialNumber: json["serial_number"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        lastLocation: json["last_location"],
        tubeGasId: json["tube_gas_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "code": code,
        "photo": photo,
        "owner_ship_type": ownerShipType,
        "is_has_tube_type": isHasTubeType,
        "tube_type_id": tubeTypeId,
        "is_has_grade": isHasGrade,
        "tube_grade_id": tubeGradeId,
        "tube_year": tubeYear,
        "serial_number": serialNumber,
        "customer_id": customerId,
        "customer_name": customerName,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "last_location": lastLocation,
        "tube_gas_id": tubeGasId,
      };
}
