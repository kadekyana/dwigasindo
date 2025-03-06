// To parse this JSON data, do
//
//     final modelDetailSuratJalan = modelDetailSuratJalanFromJson(jsonString);

import 'dart:convert';

ModelDetailSuratJalan modelDetailSuratJalanFromJson(String str) =>
    ModelDetailSuratJalan.fromJson(json.decode(str));

String modelDetailSuratJalanToJson(ModelDetailSuratJalan data) =>
    json.encode(data.toJson());

class ModelDetailSuratJalan {
  Data? data;
  dynamic error;

  ModelDetailSuratJalan({
    this.data,
    this.error,
  });

  factory ModelDetailSuratJalan.fromJson(Map<String, dynamic> json) =>
      ModelDetailSuratJalan(
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
  String? sjNo;
  String? orderNo;
  String? driverName;
  String? driverVehicleNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Detail>? details;

  Data({
    this.id,
    this.idStr,
    this.sjNo,
    this.orderNo,
    this.driverName,
    this.driverVehicleNumber,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        sjNo: json["sj_no"],
        orderNo: json["order_no"],
        driverName: json["driver_name"],
        driverVehicleNumber: json["driver_vehicle_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "sj_no": sjNo,
        "order_no": orderNo,
        "driver_name": driverName,
        "driver_vehicle_number": driverVehicleNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? idStr;
  String? bptiNo;
  List<Item>? items;

  Detail({
    this.id,
    this.idStr,
    this.bptiNo,
    this.items,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        bptiNo: json["bpti_no"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "bpti_no": bptiNo,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  String? idStr;
  String? no;
  int? ownershipType;
  String? owner;
  bool? isHasTubeType;
  int? tubeTypeId;
  String? tubeTypeName;
  bool? isHasGrade;
  int? tubeGradeId;
  String? tubeGradeName;
  int? tubeGasId;
  String? tubeGasName;

  Item({
    this.id,
    this.idStr,
    this.no,
    this.ownershipType,
    this.owner,
    this.isHasTubeType,
    this.tubeTypeId,
    this.tubeTypeName,
    this.isHasGrade,
    this.tubeGradeId,
    this.tubeGradeName,
    this.tubeGasId,
    this.tubeGasName,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        ownershipType: json["ownership_type"],
        owner: json["owner"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeId: json["tube_type_id"],
        tubeTypeName: json["tube_type_name"],
        isHasGrade: json["is_has_grade"],
        tubeGradeId: json["tube_grade_id"],
        tubeGradeName: json["tube_grade_name"],
        tubeGasId: json["tube_gas_id"],
        tubeGasName: json["tube_gas_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "ownership_type": ownershipType,
        "owner": owner,
        "is_has_tube_type": isHasTubeType,
        "tube_type_id": tubeTypeId,
        "tube_type_name": tubeTypeName,
        "is_has_grade": isHasGrade,
        "tube_grade_id": tubeGradeId,
        "tube_grade_name": tubeGradeName,
        "tube_gas_id": tubeGasId,
        "tube_gas_name": tubeGasName,
      };
}
