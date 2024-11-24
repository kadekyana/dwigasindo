// To parse this JSON data, do
//
//     final modelSupplier = modelSupplierFromJson(jsonString);

import 'dart:convert';

ModelSupplier modelSupplierFromJson(String str) =>
    ModelSupplier.fromJson(json.decode(str));

String modelSupplierToJson(ModelSupplier data) => json.encode(data.toJson());

class ModelSupplier {
  List<Datum> data;
  dynamic error;

  ModelSupplier({
    required this.data,
    required this.error,
  });

  ModelSupplier copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelSupplier(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelSupplier.fromJson(Map<String, dynamic> json) => ModelSupplier(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int id;
  String idStr;
  String name;
  String address;
  int vendorCategoryId;
  String vendorCategoryName;
  int type;
  int cityId;
  String cityName;

  Datum({
    required this.id,
    required this.idStr,
    required this.name,
    required this.address,
    required this.vendorCategoryId,
    required this.vendorCategoryName,
    required this.type,
    required this.cityId,
    required this.cityName,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    String? address,
    int? vendorCategoryId,
    String? vendorCategoryName,
    int? type,
    int? cityId,
    String? cityName,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        address: address ?? this.address,
        vendorCategoryId: vendorCategoryId ?? this.vendorCategoryId,
        vendorCategoryName: vendorCategoryName ?? this.vendorCategoryName,
        type: type ?? this.type,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
      );

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
