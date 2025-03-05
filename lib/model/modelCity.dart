// To parse this JSON data, do
//
//     final modelCity = modelCityFromJson(jsonString);

import 'dart:convert';

ModelCity modelCityFromJson(String str) => ModelCity.fromJson(json.decode(str));

String modelCityToJson(ModelCity data) => json.encode(data.toJson());

class ModelCity {
  List<Datum>? data;
  dynamic error;

  ModelCity({
    this.data,
    this.error,
  });

  factory ModelCity.fromJson(Map<String, dynamic> json) => ModelCity(
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
  String? name;
  String? kemendagriCode;
  int? provinceId;

  Datum({
    this.id,
    this.idStr,
    this.name,
    this.kemendagriCode,
    this.provinceId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        kemendagriCode: json["kemendagri_code"],
        provinceId: json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "kemendagri_code": kemendagriCode,
        "province_id": provinceId,
      };
}
