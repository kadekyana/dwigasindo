// To parse this JSON data, do
//
//     final modelIsiData = modelIsiDataFromJson(jsonString);

import 'dart:convert';

ModelIsiData modelIsiDataFromJson(String str) =>
    ModelIsiData.fromJson(json.decode(str));

String modelIsiDataToJson(ModelIsiData data) => json.encode(data.toJson());

class ModelIsiData {
  Data? data;
  dynamic error;

  ModelIsiData({
    this.data,
    this.error,
  });

  ModelIsiData copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelIsiData(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelIsiData.fromJson(Map<String, dynamic> json) => ModelIsiData(
        data: json["data"] != null ? Data.fromJson(json["data"]) : Data.empty(),
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
  int? tubeId;
  int? mixGasShelfId;
  int? isRefill;
  DateTime? emptyDate;
  String? photoLevelStart;
  int? levelStart;
  String? photoPressureStart;
  int? pressureStart;
  String? photoLevelEnd;
  int? levelEnd;
  String? photoPressureEnd;
  int? pressureEnd;

  Data({
    this.id,
    this.idStr,
    this.tubeId,
    this.mixGasShelfId,
    this.isRefill,
    this.emptyDate,
    this.photoLevelStart,
    this.levelStart,
    this.photoPressureStart,
    this.pressureStart,
    this.photoLevelEnd,
    this.levelEnd,
    this.photoPressureEnd,
    this.pressureEnd,
  });

  Data copyWith({
    int? id,
    String? idStr,
    int? tubeId,
    int? mixGasShelfId,
    int? isRefill,
    DateTime? emptyDate,
    String? photoLevelStart,
    int? levelStart,
    String? photoPressureStart,
    int? pressureStart,
    String? photoLevelEnd,
    int? levelEnd,
    String? photoPressureEnd,
    int? pressureEnd,
  }) =>
      Data(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        tubeId: tubeId ?? this.tubeId,
        mixGasShelfId: mixGasShelfId ?? this.mixGasShelfId,
        isRefill: isRefill ?? this.isRefill,
        emptyDate: emptyDate ?? this.emptyDate,
        photoLevelStart: photoLevelStart ?? this.photoLevelStart,
        levelStart: levelStart ?? this.levelStart,
        photoPressureStart: photoPressureStart ?? this.photoPressureStart,
        pressureStart: pressureStart ?? this.pressureStart,
        photoLevelEnd: photoLevelEnd ?? this.photoLevelEnd,
        levelEnd: levelEnd ?? this.levelEnd,
        photoPressureEnd: photoPressureEnd ?? this.photoPressureEnd,
        pressureEnd: pressureEnd ?? this.pressureEnd,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        mixGasShelfId: json["mix_gas_shelf_id"],
        isRefill: json["is_refill"],
        emptyDate: json["empty_date"] != null && json["empty_date"] != "null"
            ? DateTime.parse(json["empty_date"])
            : null,
        photoLevelStart: json["photo_level_start"] ?? '',
        levelStart: json["level_start"] ?? 0,
        photoPressureStart: json["photo_pressure_start"] ?? '',
        pressureStart: json["pressure_start"] ?? 0,
        photoLevelEnd: json["photo_level_end"] ?? '',
        levelEnd: json["level_end"] ?? 0,
        photoPressureEnd: json["photo_pressure_end"] ?? '',
        pressureEnd: json["pressure_end"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "mix_gas_shelf_id": mixGasShelfId,
        "is_refill": isRefill,
        "empty_date": emptyDate?.toIso8601String(),
        "photo_level_start": photoLevelStart,
        "level_start": levelStart,
        "photo_pressure_start": photoPressureStart,
        "pressure_start": pressureStart,
        "photo_level_end": photoLevelEnd,
        "level_end": levelEnd,
        "photo_pressure_end": photoPressureEnd,
        "pressure_end": pressureEnd,
      };

  factory Data.empty() => Data(
        id: 0,
        idStr: '',
        tubeId: 0,
        mixGasShelfId: 0,
        isRefill: 0,
        emptyDate: null,
        photoLevelStart: '',
        levelStart: 0,
        photoPressureStart: '',
        pressureStart: 0,
        photoLevelEnd: '',
        levelEnd: 0,
        photoPressureEnd: '',
        pressureEnd: 0,
      );
}
