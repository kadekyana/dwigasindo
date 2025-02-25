// To parse this JSON data, do
//
//     final modelDocumentationLead = modelDocumentationLeadFromJson(jsonString);

import 'dart:convert';

ModelDocumentationLead modelDocumentationLeadFromJson(String str) =>
    ModelDocumentationLead.fromJson(json.decode(str));

String modelDocumentationLeadToJson(ModelDocumentationLead data) =>
    json.encode(data.toJson());

class ModelDocumentationLead {
  List<Datum>? data;
  dynamic error;

  ModelDocumentationLead({
    this.data,
    this.error,
  });

  factory ModelDocumentationLead.fromJson(Map<String, dynamic> json) =>
      ModelDocumentationLead(
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
  int? leadsId;
  int? userId;
  String? path;

  Datum({
    this.id,
    this.leadsId,
    this.userId,
    this.path,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        leadsId: json["leads_id"],
        userId: json["user_id"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leads_id": leadsId,
        "user_id": userId,
        "path": path,
      };
}
