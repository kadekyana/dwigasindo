// To parse this JSON data, do
//
//     final modelDetailKunjungan = modelDetailKunjunganFromJson(jsonString);

import 'dart:convert';

ModelDetailKunjungan modelDetailKunjunganFromJson(String str) =>
    ModelDetailKunjungan.fromJson(json.decode(str));

String modelDetailKunjunganToJson(ModelDetailKunjungan data) =>
    json.encode(data.toJson());

class ModelDetailKunjungan {
  Data? data;
  dynamic error;

  ModelDetailKunjungan({
    this.data,
    this.error,
  });

  factory ModelDetailKunjungan.fromJson(Map<String, dynamic> json) =>
      ModelDetailKunjungan(
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
  int? typeVisiting;
  int? type;
  String? name;
  String? customer;
  String? location;
  dynamic note;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<History>? histories;

  Data({
    this.id,
    this.typeVisiting,
    this.type,
    this.name,
    this.customer,
    this.location,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.histories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        typeVisiting: json["type_visiting"],
        type: json["type"],
        name: json["name"],
        customer: json["customer"],
        location: json["location"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        histories: json["histories"] == null
            ? []
            : List<History>.from(
                json["histories"]!.map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_visiting": typeVisiting,
        "type": type,
        "name": name,
        "customer": customer,
        "location": location,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "histories": histories == null
            ? []
            : List<dynamic>.from(histories!.map((x) => x.toJson())),
      };
}

class History {
  int? id;
  int? type;
  double? long;
  double? lat;
  dynamic note;
  int? visitingId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  String? userName;

  History({
    this.id,
    this.type,
    this.long,
    this.lat,
    this.note,
    this.visitingId,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.userName,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        type: json["type"],
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        note: json["note"],
        visitingId: json["visiting_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "long": long,
        "lat": lat,
        "note": note,
        "visiting_id": visitingId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "user_name": userName,
      };
}
