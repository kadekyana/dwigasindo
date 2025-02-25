// To parse this JSON data, do
//
//     final modelAllMixGas = modelAllMixGasFromJson(jsonString);

import 'dart:convert';

ModelAllMixGas modelAllMixGasFromJson(String str) =>
    ModelAllMixGas.fromJson(json.decode(str));

String modelAllMixGasToJson(ModelAllMixGas data) => json.encode(data.toJson());

class ModelAllMixGas {
  List<Datum>? data;
  dynamic error;

  ModelAllMixGas({
    this.data,
    this.error,
  });

  ModelAllMixGas copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllMixGas(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllMixGas.fromJson(Map<String, dynamic> json) => ModelAllMixGas(
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
  String? name;
  int? type;
  dynamic poNum;
  dynamic customerName;
  int? tubeQty;
  DateTime? createdAt;
  int? tubeCompleted;
  int? createdBy;
  String? createdByName;
  int? isActive;
  int? tubeRemaining;
  dynamic tubeGasId;
  dynamic tubeGasName;

  Datum({
    this.id,
    this.idStr,
    this.name,
    this.type,
    this.poNum,
    this.customerName,
    this.tubeQty,
    this.createdAt,
    this.tubeCompleted,
    this.createdBy,
    this.createdByName,
    this.isActive,
    this.tubeRemaining,
    this.tubeGasId,
    this.tubeGasName,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? name,
    int? type,
    dynamic poNum,
    dynamic customerName,
    int? tubeQty,
    DateTime? createdAt,
    int? tubeCompleted,
    int? createdBy,
    String? createdByName,
    int? isActive,
    int? tubeRemaining,
    dynamic tubeGasId,
    dynamic tubeGasName,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        type: type ?? this.type,
        poNum: poNum ?? this.poNum,
        customerName: customerName ?? this.customerName,
        tubeQty: tubeQty ?? this.tubeQty,
        createdAt: createdAt ?? this.createdAt,
        tubeCompleted: tubeCompleted ?? this.tubeCompleted,
        createdBy: createdBy ?? this.createdBy,
        createdByName: createdByName ?? this.createdByName,
        isActive: isActive ?? this.isActive,
        tubeRemaining: tubeRemaining ?? this.tubeRemaining,
        tubeGasId: tubeGasId ?? this.tubeGasId,
        tubeGasName: tubeGasName ?? this.tubeGasName,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        type: json["type"],
        poNum: json["po_num"],
        customerName: json["customer_name"],
        tubeQty: json["tube_qty"],
        createdAt: DateTime.parse(json["created_at"]),
        tubeCompleted: json["tube_completed"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        isActive: json["is_active"],
        tubeRemaining: json["tube_remaining"],
        tubeGasId: json["tube_gas_id"],
        tubeGasName: json["tube_gas_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "type": type,
        "po_num": poNum,
        "customer_name": customerName,
        "tube_qty": tubeQty,
        "created_at": createdAt!.toIso8601String(),
        "tube_completed": tubeCompleted,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "is_active": isActive,
        "tube_remaining": tubeRemaining,
        "tube_gas_id": tubeGasId,
        "tube_gas_name": tubeGasName,
      };
}
