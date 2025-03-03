// To parse this JSON data, do
//
//     final modelPenerimaanBarang = modelPenerimaanBarangFromJson(jsonString);

import 'dart:convert';

ModelPenerimaanBarang modelPenerimaanBarangFromJson(String str) =>
    ModelPenerimaanBarang.fromJson(json.decode(str));

String modelPenerimaanBarangToJson(ModelPenerimaanBarang data) =>
    json.encode(data.toJson());

class ModelPenerimaanBarang {
  List<Datum>? data;
  dynamic error;

  ModelPenerimaanBarang({
    this.data,
    this.error,
  });

  factory ModelPenerimaanBarang.fromJson(Map<String, dynamic> json) =>
      ModelPenerimaanBarang(
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
  int? divisionId;
  String? divisionName;
  int? picVerified;
  String? picVerifiedName;
  int? picAcknowledged;
  String? picAcknowledgedName;
  int? picApproved;
  String? picApprovedName;
  int? createdBy;
  String? createdByName;
  DateTime? createdAt;

  Datum({
    this.id,
    this.idStr,
    this.no,
    this.divisionId,
    this.divisionName,
    this.picVerified,
    this.picVerifiedName,
    this.picAcknowledged,
    this.picAcknowledgedName,
    this.picApproved,
    this.picApprovedName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        divisionId: json["division_id"],
        divisionName: json["division_name"],
        picVerified: json["pic_verified"],
        picVerifiedName: json["pic_verified_name"],
        picAcknowledged: json["pic_acknowledged"],
        picAcknowledgedName: json["pic_acknowledged_name"],
        picApproved: json["pic_approved"],
        picApprovedName: json["pic_approved_name"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "division_id": divisionId,
        "division_name": divisionName,
        "pic_verified": picVerified,
        "pic_verified_name": picVerifiedName,
        "pic_acknowledged": picAcknowledged,
        "pic_acknowledged_name": picAcknowledgedName,
        "pic_approved": picApproved,
        "pic_approved_name": picApprovedName,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "created_at": createdAt?.toIso8601String(),
      };
}
