// To parse this JSON data, do
//
//     final modelCatatanCmd = modelCatatanCmdFromJson(jsonString);

import 'dart:convert';

ModelCatatanCmd modelCatatanCmdFromJson(String str) =>
    ModelCatatanCmd.fromJson(json.decode(str));

String modelCatatanCmdToJson(ModelCatatanCmd data) =>
    json.encode(data.toJson());

class ModelCatatanCmd {
  Data? data;
  dynamic error;

  ModelCatatanCmd({
    this.data,
    this.error,
  });

  factory ModelCatatanCmd.fromJson(Map<String, dynamic> json) =>
      ModelCatatanCmd(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "error": error,
      };
}

class Data {
  List<Detail>? details;

  Data({
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? role;
  List<Note>? notes;

  Detail({
    this.id,
    this.role,
    this.notes,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        role: json["role"],
        notes: json["notes"] == null
            ? []
            : List<Note>.from(json["notes"]!.map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "notes": notes == null
            ? []
            : List<dynamic>.from(notes!.map((x) => x.toJson())),
      };
}

class Note {
  int? id;
  String? note;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Note({
    this.id,
    this.note,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
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
        "note": note,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
