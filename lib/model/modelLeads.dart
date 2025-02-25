// To parse this JSON data, do
//
//     final modelLeads = modelLeadsFromJson(jsonString);

import 'dart:convert';

ModelLeads modelLeadsFromJson(String str) =>
    ModelLeads.fromJson(json.decode(str));

String modelLeadsToJson(ModelLeads data) => json.encode(data.toJson());

class ModelLeads {
  final List<Datum> data;
  final dynamic error;

  ModelLeads({
    required this.data,
    required this.error,
  });

  ModelLeads copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelLeads(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelLeads.fromJson(Map<String, dynamic> json) => ModelLeads(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  final int id;
  final String name;
  final String pic;
  final String phone;
  final int type;
  final int status;
  final int lastStatus;
  final String salesName;
  final String districtComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.name,
    required this.pic,
    required this.phone,
    required this.type,
    required this.status,
    required this.lastStatus,
    required this.salesName,
    required this.districtComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? pic,
    String? phone,
    int? type,
    int? status,
    int? lastStatus,
    String? salesName,
    String? districtComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        pic: pic ?? this.pic,
        phone: phone ?? this.phone,
        type: type ?? this.type,
        status: status ?? this.status,
        lastStatus: lastStatus ?? this.lastStatus,
        salesName: salesName ?? this.salesName,
        districtComplete: districtComplete ?? this.districtComplete,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        pic: json["pic"],
        phone: json["phone"],
        type: json["type"],
        status: json["status"],
        lastStatus: json["last_status"],
        salesName: json["sales_name"],
        districtComplete: json["district_complete"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pic": pic,
        "phone": phone,
        "type": type,
        "status": status,
        "last_status": lastStatus,
        "sales_name": salesName,
        "district_complete": districtComplete,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
