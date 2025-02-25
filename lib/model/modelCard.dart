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

  ModelCard copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelCard(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelCard.fromJson(Map<String, dynamic> json) => ModelCard(
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
  String? code;
  String? photo;
  int? ownerShipType;
  bool? isHasTubeType;
  dynamic tubeTypeId;
  bool? isHasGrade;
  dynamic tubeGradeId;
  int? tubeYear;
  String? serialNumber;
  dynamic customerId;
  String? customerName;
  dynamic vendorId;
  String? vendorName;
  String? lastLocation;
  int? tubeGasId;

  Data({
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

  Data copyWith({
    int? id,
    String? idStr,
    String? code,
    String? photo,
    int? ownerShipType,
    bool? isHasTubeType,
    dynamic tubeTypeId,
    bool? isHasGrade,
    dynamic tubeGradeId,
    int? tubeYear,
    String? serialNumber,
    dynamic customerId,
    String? customerName,
    dynamic vendorId,
    String? vendorName,
    String? lastLocation,
    int? tubeGasId,
  }) =>
      Data(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        code: code ?? this.code,
        photo: photo ?? this.photo,
        ownerShipType: ownerShipType ?? this.ownerShipType,
        isHasTubeType: isHasTubeType ?? this.isHasTubeType,
        tubeTypeId: tubeTypeId ?? this.tubeTypeId,
        isHasGrade: isHasGrade ?? this.isHasGrade,
        tubeGradeId: tubeGradeId ?? this.tubeGradeId,
        tubeYear: tubeYear ?? this.tubeYear,
        serialNumber: serialNumber ?? this.serialNumber,
        customerId: customerId ?? this.customerId,
        customerName: customerName ?? this.customerName,
        vendorId: vendorId ?? this.vendorId,
        vendorName: vendorName ?? this.vendorName,
        lastLocation: lastLocation ?? this.lastLocation,
        tubeGasId: tubeGasId ?? this.tubeGasId,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
