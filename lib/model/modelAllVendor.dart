// To parse this JSON data, do
//
//     final modelAllVendor = modelAllVendorFromJson(jsonString);

import 'dart:convert';

ModelAllVendor modelAllVendorFromJson(String str) =>
    ModelAllVendor.fromJson(json.decode(str));

String modelAllVendorToJson(ModelAllVendor data) => json.encode(data.toJson());

class ModelAllVendor {
  List<Datum>? data;
  dynamic error;

  ModelAllVendor({
    this.data,
    this.error,
  });

  factory ModelAllVendor.fromJson(Map<String, dynamic> json) => ModelAllVendor(
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
  String? address;
  int? vendorCategoryId;
  String? vendorCategoryName;
  int? type;
  int? cityId;
  String? cityName;

  Datum({
    this.id,
    this.idStr,
    this.name,
    this.address,
    this.vendorCategoryId,
    this.vendorCategoryName,
    this.type,
    this.cityId,
    this.cityName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        address: json["address"],
        vendorCategoryId: json["vendor_category_id"],
        vendorCategoryName: json["vendor_category_name"],
        type: json["type"],
        cityId: json["city_id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "address": address,
        "vendor_category_id": vendorCategoryId,
        "vendor_category_name": vendorCategoryName,
        "type": type,
        "city_id": cityId,
        "city_name": cityName,
      };
}
