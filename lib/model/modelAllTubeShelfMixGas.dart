// To parse this JSON data, do
//
//     final modelAllTubeShelfMixGas = modelAllTubeShelfMixGasFromJson(jsonString);

import 'dart:convert';

ModelAllTubeShelfMixGas modelAllTubeShelfMixGasFromJson(String str) =>
    ModelAllTubeShelfMixGas.fromJson(json.decode(str));

String modelAllTubeShelfMixGasToJson(ModelAllTubeShelfMixGas data) =>
    json.encode(data.toJson());

class ModelAllTubeShelfMixGas {
  List<Datum>? data;
  dynamic error;

  ModelAllTubeShelfMixGas({
    this.data,
    this.error,
  });

  ModelAllTubeShelfMixGas copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllTubeShelfMixGas(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllTubeShelfMixGas.fromJson(Map<String, dynamic> json) =>
      ModelAllTubeShelfMixGas(
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
  int? mixGasShelfId;
  int? isRefill;
  DateTime? emptyDate;
  int? tubeId;
  String? tubeNo;

  Datum({
    this.id,
    this.idStr,
    this.mixGasShelfId,
    this.isRefill,
    this.emptyDate,
    this.tubeId,
    this.tubeNo,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    int? mixGasShelfId,
    int? isRefill,
    DateTime? emptyDate,
    int? tubeId,
    String? tubeNo,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        mixGasShelfId: mixGasShelfId ?? this.mixGasShelfId,
        isRefill: isRefill ?? this.isRefill,
        emptyDate: emptyDate ?? this.emptyDate,
        tubeId: tubeId ?? this.tubeId,
        tubeNo: tubeNo ?? this.tubeNo,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        mixGasShelfId: json["mix_gas_shelf_id"],
        isRefill: json["is_refill"],
        emptyDate: DateTime.parse(json["empty_date"]),
        tubeId: json["tube_id"],
        tubeNo: json["tube_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "mix_gas_shelf_id": mixGasShelfId,
        "is_refill": isRefill,
        "empty_date": emptyDate?.toIso8601String(),
        "tube_id": tubeId,
        "tube_no": tubeNo,
      };
}
