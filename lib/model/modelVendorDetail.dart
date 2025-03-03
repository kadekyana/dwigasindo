// To parse this JSON data, do
//
//     final modelVendorDetail = modelVendorDetailFromJson(jsonString);

import 'dart:convert';

ModelVendorDetail modelVendorDetailFromJson(String str) =>
    ModelVendorDetail.fromJson(json.decode(str));

String modelVendorDetailToJson(ModelVendorDetail data) =>
    json.encode(data.toJson());

class ModelVendorDetail {
  Data? data;
  dynamic error;

  ModelVendorDetail({
    this.data,
    this.error,
  });

  factory ModelVendorDetail.fromJson(Map<String, dynamic> json) =>
      ModelVendorDetail(
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
  String? name;
  String? address;
  int? vendorCategoryId;
  String? vendorCategoryName;
  int? type;
  int? cityId;
  String? cityName;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
