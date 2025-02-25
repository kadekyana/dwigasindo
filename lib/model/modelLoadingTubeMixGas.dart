// To parse this JSON data, do
//
//     final modelLoadingTubeMixGas = modelLoadingTubeMixGasFromJson(jsonString);

import 'dart:convert';

ModelLoadingTubeMixGas modelLoadingTubeMixGasFromJson(String str) =>
    ModelLoadingTubeMixGas.fromJson(json.decode(str));

String modelLoadingTubeMixGasToJson(ModelLoadingTubeMixGas data) =>
    json.encode(data.toJson());

class ModelLoadingTubeMixGas {
  Data? data;
  dynamic error;

  ModelLoadingTubeMixGas({
    this.data,
    this.error,
  });

  factory ModelLoadingTubeMixGas.fromJson(Map<String, dynamic> json) =>
      ModelLoadingTubeMixGas(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tubeOkCount: json["tube_ok_count"],
        tubeNoCount: json["tube_no_count"],
        tubeLoadingDetail: json["tube_loading_detail"] == null
            ? []
            : List<TubeLoadingDetail>.from(json["tube_loading_detail"]!
                .map((x) => TubeLoadingDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tube_ok_count": tubeOkCount,
        "tube_no_count": tubeNoCount,
        "tube_loading_detail": tubeLoadingDetail == null
            ? []
            : List<dynamic>.from(tubeLoadingDetail!.map((x) => x.toJson())),
      };
}

class TubeLoadingDetail {
  int? id;
  String? idStr;
  int? tubeId;
  String? tubeNo;
  String? tubePhoto;
  int? tubeStatus;
  String? tubeShelfName;
  int? prefillCheckBody;
  int? prefillVent;
  int? prefillCheckValve;
  int? prefillHammerTest;
  int? productionEmptyWeight;
  int? productionCo2Weight;
  int? productionT0Weight;
  int? productionColdTest;
  int? productionLeakTest;
  int? postfillT2Weight;
  int? postfillColdTest;
  int? postfillFloatLevelIndicator;
  int? postfillLeakTest;
  int? postfillPressureBuilding;
  int? postfillInspectionStatus;

  TubeLoadingDetail({
    this.id,
    this.idStr,
    this.tubeId,
    this.tubeNo,
    this.tubePhoto,
    this.tubeStatus,
    this.tubeShelfName,
    this.prefillCheckBody,
    this.prefillVent,
    this.prefillCheckValve,
    this.prefillHammerTest,
    this.productionEmptyWeight,
    this.productionCo2Weight,
    this.productionT0Weight,
    this.productionColdTest,
    this.productionLeakTest,
    this.postfillT2Weight,
    this.postfillColdTest,
    this.postfillFloatLevelIndicator,
    this.postfillLeakTest,
    this.postfillPressureBuilding,
    this.postfillInspectionStatus,
  });

  factory TubeLoadingDetail.fromJson(Map<String, dynamic> json) =>
      TubeLoadingDetail(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        tubeNo: json["tube_no"],
        tubePhoto: json["tube_photo"],
        tubeStatus: json["tube_status"],
        tubeShelfName: json["tube_shelf_name"],
        prefillCheckBody: json["prefill_check_body"],
        prefillVent: json["prefill_vent"],
        prefillCheckValve: json["prefill_check_valve"],
        prefillHammerTest: json["prefill_hammer_test"],
        productionEmptyWeight: json["production_empty_weight"],
        productionCo2Weight: json["production_co2_weight"],
        productionT0Weight: json["production_t0_weight"],
        productionColdTest: json["production_cold_test"],
        productionLeakTest: json["production_leak_test"],
        postfillT2Weight: json["postfill_t2_weight"],
        postfillColdTest: json["postfill_cold_test"],
        postfillFloatLevelIndicator: json["postfill_float_level_indicator"],
        postfillLeakTest: json["postfill_leak_test"],
        postfillPressureBuilding: json["postfill_pressure_building"],
        postfillInspectionStatus: json["PostfillInspectionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "tube_no": tubeNo,
        "tube_photo": tubePhoto,
        "tube_status": tubeStatus,
        "tube_shelf_name": tubeShelfName,
        "prefill_check_body": prefillCheckBody,
        "prefill_vent": prefillVent,
        "prefill_check_valve": prefillCheckValve,
        "prefill_hammer_test": prefillHammerTest,
        "production_empty_weight": productionEmptyWeight,
        "production_co2_weight": productionCo2Weight,
        "production_t0_weight": productionT0Weight,
        "production_cold_test": productionColdTest,
        "production_leak_test": productionLeakTest,
        "postfill_t2_weight": postfillT2Weight,
        "postfill_cold_test": postfillColdTest,
        "postfill_float_level_indicator": postfillFloatLevelIndicator,
        "postfill_leak_test": postfillLeakTest,
        "postfill_pressure_building": postfillPressureBuilding,
        "PostfillInspectionStatus": postfillInspectionStatus,
      };
}
