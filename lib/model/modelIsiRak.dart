// To parse this JSON data, do
//
//     final modelIsiRak = modelIsiRakFromJson(jsonString);

import 'dart:convert';

ModelIsiRak modelIsiRakFromJson(String str) =>
    ModelIsiRak.fromJson(json.decode(str));

String modelIsiRakToJson(ModelIsiRak data) => json.encode(data.toJson());

class ModelIsiRak {
  List<Datum>? data;
  dynamic error;

  ModelIsiRak({
    this.data,
    this.error,
  });

  ModelIsiRak copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelIsiRak(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelIsiRak.fromJson(Map<String, dynamic> json) => ModelIsiRak(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  int? id;
  String? idStr;
  int? tubeId;
  String? tubeNo;
  int? shelfId;
  int? isRefill;
  int? remainingGas;
  DateTime? emptyDate;

  Datum({
    this.id,
    this.idStr,
    this.tubeId,
    this.tubeNo,
    this.shelfId,
    this.isRefill,
    this.remainingGas,
    this.emptyDate,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    int? tubeId,
    String? tubeNo,
    int? shelfId,
    int? isRefill,
    int? remainingGas,
    DateTime? emptyDate,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        tubeId: tubeId ?? this.tubeId,
        tubeNo: tubeNo ?? this.tubeNo,
        shelfId: shelfId ?? this.shelfId,
        isRefill: isRefill ?? this.isRefill,
        remainingGas: remainingGas ?? this.remainingGas,
        emptyDate: emptyDate ?? this.emptyDate,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        tubeNo: json["tube_no"],
        shelfId: json["shelf_id"],
        isRefill: json["is_refill"],
        remainingGas: json["remaining_gas"],
        emptyDate: DateTime.parse(json["empty_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "tube_no": tubeNo,
        "shelf_id": shelfId,
        "is_refill": isRefill,
        "remaining_gas": remainingGas,
        "empty_date": emptyDate!.toIso8601String(),
      };
}
