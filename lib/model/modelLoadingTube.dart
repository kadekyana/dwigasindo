// To parse this JSON data, do
//
//     final modelLoadingTube = modelLoadingTubeFromJson(jsonString);

import 'dart:convert';

ModelLoadingTube modelLoadingTubeFromJson(String str) =>
    ModelLoadingTube.fromJson(json.decode(str));

String modelLoadingTubeToJson(ModelLoadingTube data) =>
    json.encode(data.toJson());

class ModelLoadingTube {
  Data data;
  dynamic error;

  ModelLoadingTube({
    required this.data,
    this.error,
  });

  ModelLoadingTube copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelLoadingTube(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelLoadingTube.fromJson(Map<String, dynamic> json) =>
      ModelLoadingTube(
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  int? tubeOkCount;
  int? tubeNoCount;
  List<TubeLoadingDetail>? tubeLoadingDetail;

  Data({
    this.tubeOkCount,
    this.tubeNoCount,
    this.tubeLoadingDetail,
  });

  Data copyWith({
    int? tubeOkCount,
    int? tubeNoCount,
    List<TubeLoadingDetail>? tubeLoadingDetail,
  }) =>
      Data(
        tubeOkCount: tubeOkCount ?? this.tubeOkCount,
        tubeNoCount: tubeNoCount ?? this.tubeNoCount,
        tubeLoadingDetail: tubeLoadingDetail ?? this.tubeLoadingDetail,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tubeOkCount: json["tube_ok_count"],
        tubeNoCount: json["tube_no_count"],
        tubeLoadingDetail: List<TubeLoadingDetail>.from(
            json["tube_loading_detail"]
                .map((x) => TubeLoadingDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tube_ok_count": tubeOkCount,
        "tube_no_count": tubeNoCount,
        "tube_loading_detail":
            List<dynamic>.from(tubeLoadingDetail!.map((x) => x.toJson())),
      };
}

class TubeLoadingDetail {
  int? id;
  String? idStr;
  int? tubeId;
  String? tubeNo;
  String? tubePhoto;
  int? tubeStatus;
  dynamic tubeShelfName;
  int? tareWeight;
  int? emptyWeight;
  int? filledWeight;

  TubeLoadingDetail({
    this.id,
    this.idStr,
    this.tubeId,
    this.tubeNo,
    this.tubePhoto,
    this.tubeStatus,
    this.tubeShelfName,
    this.tareWeight,
    this.emptyWeight,
    this.filledWeight,
  });

  TubeLoadingDetail copyWith({
    int? id,
    String? idStr,
    int? tubeId,
    String? tubeNo,
    String? tubePhoto,
    int? tubeStatus,
    dynamic tubeShelfName,
    int? tareWeight,
    int? emptyWeight,
    int? filledWeight,
  }) =>
      TubeLoadingDetail(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        tubeId: tubeId ?? this.tubeId,
        tubeNo: tubeNo ?? this.tubeNo,
        tubePhoto: tubePhoto ?? this.tubePhoto,
        tubeStatus: tubeStatus ?? this.tubeStatus,
        tubeShelfName: tubeShelfName ?? this.tubeShelfName,
        tareWeight: tareWeight ?? this.tareWeight,
        emptyWeight: emptyWeight ?? this.emptyWeight,
        filledWeight: filledWeight ?? this.filledWeight,
      );

  factory TubeLoadingDetail.fromJson(Map<String, dynamic> json) =>
      TubeLoadingDetail(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        tubeNo: json["tube_no"],
        tubePhoto: json["tube_photo"],
        tubeStatus: json["tube_status"],
        tubeShelfName: json["tube_shelf_name"],
        tareWeight: json["tare_weight"],
        emptyWeight: json["empty_weight"],
        filledWeight: json["filled_weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "tube_no": tubeNo,
        "tube_photo": tubePhoto,
        "tube_status": tubeStatus,
        "tube_shelf_name": tubeShelfName,
        "tare_weight": tareWeight,
        "empty_weight": emptyWeight,
        "filled_weight": filledWeight,
      };
}
