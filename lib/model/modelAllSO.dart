// To parse this JSON data, do
//
//     final modelAllSo = modelAllSoFromJson(jsonString);

import 'dart:convert';

ModelAllSo modelAllSoFromJson(String str) =>
    ModelAllSo.fromJson(json.decode(str));

String modelAllSoToJson(ModelAllSo data) => json.encode(data.toJson());

class ModelAllSo {
  List<Datum>? data;
  dynamic error;

  ModelAllSo({
    this.data,
    this.error,
  });

  factory ModelAllSo.fromJson(Map<String, dynamic> json) => ModelAllSo(
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
  dynamic stockOpnameReportNo;
  String? no;
  int? status;
  String? note;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.idStr,
    this.stockOpnameReportNo,
    this.no,
    this.status,
    this.note,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        stockOpnameReportNo: json["stock_opname_report_no"],
        no: json["no"],
        status: json["status"],
        note: json["note"],
        createdBy: json["created_by"],
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
        "stock_opname_report_no": stockOpnameReportNo,
        "no": no,
        "status": status,
        "note": note,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
