// To parse this JSON data, do
//
//     final modelCradle = modelCradleFromJson(jsonString);

import 'dart:convert';

ModelCradle modelCradleFromJson(String str) =>
    ModelCradle.fromJson(json.decode(str));

String modelCradleToJson(ModelCradle data) => json.encode(data.toJson());

class ModelCradle {
  List<Datum>? data;
  dynamic error;

  ModelCradle({
    this.data,
    this.error,
  });

  factory ModelCradle.fromJson(Map<String, dynamic> json) => ModelCradle(
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
  Name? name;
  int? ownerShipType;
  int? customerId;
  dynamic vendorId;
  bool? isHasTubeType;
  int? tubeTypeId;
  bool? isHasGrade;
  dynamic tubeGradeId;
  String? location;
  int? tubeGasId;

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
    this.isHasGrade,
    this.tubeGradeId,
    this.location,
    this.tubeGasId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        name: nameValues.map[json["name"]]!,
        ownerShipType: json["owner_ship_type"],
        customerId: json["customer_id"],
        vendorId: json["vendor_id"],
        isHasTubeType: json["is_has_tube_type"],
        tubeTypeId: json["tube_type_id"],
        isHasGrade: json["is_has_grade"],
        tubeGradeId: json["tube_grade_id"],
        location: json["location"],
        tubeGasId: json["tube_gas_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "name": nameValues.reverse[name],
        "owner_ship_type": ownerShipType,
        "customer_id": customerId,
        "vendor_id": vendorId,
        "is_has_tube_type": isHasTubeType,
        "tube_type_id": tubeTypeId,
        "is_has_grade": isHasGrade,
        "tube_grade_id": tubeGradeId,
        "location": location,
        "tube_gas_id": tubeGasId,
      };
}

enum Name { CUSTOMER_PT_ABD }

final nameValues = EnumValues({"Customer PT ABD": Name.CUSTOMER_PT_ABD});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
