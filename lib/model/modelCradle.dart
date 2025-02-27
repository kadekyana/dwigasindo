// To parse this JSON data, do
//
//     final modelCradle = modelCradleFromJson(jsonString);

import 'dart:convert';

ModelCradle modelCradleFromJson(String str) =>
    ModelCradle.fromJson(json.decode(str));

String modelCradleToJson(ModelCradle data) => json.encode(data.toJson());

class ModelCradle {
  List<Datum>? data;

  ModelCradle({
    this.data,
  });

  factory ModelCradle.fromJson(Map<String, dynamic> json) => ModelCradle(
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
  String? no;
  String? name;
  int? ownerShipType;
  int? customerId;
  dynamic vendorId;
  bool? isHasTubeType;
  dynamic tubeTypeId;
  dynamic tubeTypeName;
  bool? isHasGrade;
  dynamic tubeGradeId;
  dynamic tubeGradeName;
  dynamic location;
  int? tubeGasId;
  String? tubeGasName;

  Datum({
    this.id,
    this.idStr,
    this.no,
    this.name,
    this.ownerShipType,
    this.customerId,
    this.vendorId,
    this.isHasTubeType,
    this.tubeTypeId,
    this.tubeTypeName,
    this.isHasGrade,
    this.tubeGradeId,
    this.tubeGradeName,
    this.location,
    this.tubeGasId,
    this.tubeGasName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        name: json["name"],
        ownerShipType: json["owner_ship_type"],
        customerId: json["customer_id"],
        vendorId: json["vendor_id"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeId: json["tube_type_id"],
        tubeTypeName: json["tube_type_name"],
        isHasGrade: json["is_has_grade"],
        tubeGradeId: json["tube_grade_id"],
        tubeGradeName: json["tube_grade_name"],
        location: json["location"],
        tubeGasId: json["tube_gas_id"],
        tubeGasName: json["tube_gas_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "name": name,
        "owner_ship_type": ownerShipType,
        "customer_id": customerId,
        "vendor_id": vendorId,
        "is_has_tube_type": isHasTubeType,
        "tube_type_id": tubeTypeId,
        "tube_type_name": tubeTypeName,
        "is_has_grade": isHasGrade,
        "tube_grade_id": tubeGradeId,
        "tube_grade_name": tubeGradeName,
        "location": location,
        "tube_gas_id": tubeGasId,
        "tube_gas_name": tubeGasName,
      };
}
