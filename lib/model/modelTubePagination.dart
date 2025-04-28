// To parse this JSON data, do
//
//     final modelTubePagination = modelTubePaginationFromJson(jsonString);

import 'dart:convert';

ModelTubePagination modelTubePaginationFromJson(String str) =>
    ModelTubePagination.fromJson(json.decode(str));

String modelTubePaginationToJson(ModelTubePagination data) =>
    json.encode(data.toJson());

class ModelTubePagination {
  Data? data;
  dynamic error;

  ModelTubePagination({
    this.data,
    this.error,
  });

  factory ModelTubePagination.fromJson(Map<String, dynamic> json) =>
      ModelTubePagination(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  List<Tube>? items;
  Paginator? paginator;

  Data({
    this.items,
    this.paginator,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<Tube>.from(json["items"]!.map((x) => Tube.fromJson(x))),
        paginator: json["paginator"] == null
            ? null
            : Paginator.fromJson(json["paginator"]),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "paginator": paginator?.toJson(),
      };
}

class Tube {
  int? id;
  String? idStr;
  String? code;
  String? photo;
  String? oldTubeNumber;
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
  int? tubeGasId;
  String? tubeGasName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tube({
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
    this.tubeGasId,
    this.tubeGasName,
    this.createdAt,
    this.updatedAt,
  });

  factory Tube.fromJson(Map<String, dynamic> json) => Tube(
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
        tubeGasId: json["tube_gas_id"],
        tubeGasName: json["tube_gas_name"],
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
        "tube_gas_id": tubeGasId,
        "tube_gas_name": tubeGasName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Paginator {
  int? currentPage;
  int? perPage;
  int? lastPage;
  int? totalItem;

  Paginator({
    this.currentPage,
    this.perPage,
    this.lastPage,
    this.totalItem,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) => Paginator(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
        totalItem: json["total_item"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "last_page": lastPage,
        "total_item": totalItem,
      };
}
