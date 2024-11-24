// To parse this JSON data, do
//
//     final modelAllBpti = modelAllBptiFromJson(jsonString);

import 'dart:convert';

ModelAllBpti modelAllBptiFromJson(String str) =>
    ModelAllBpti.fromJson(json.decode(str));

String modelAllBptiToJson(ModelAllBpti data) => json.encode(data.toJson());

class ModelAllBpti {
  List<Datum>? data;
  dynamic error;

  ModelAllBpti({
    this.data,
    this.error,
  });

  ModelAllBpti copyWith({
    List<Datum>? data,
    dynamic error,
  }) =>
      ModelAllBpti(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelAllBpti.fromJson(Map<String, dynamic> json) => ModelAllBpti(
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
  String? no;
  int? type;
  int? bptkId;
  dynamic customerId;
  int? createdBy;
  int? status;
  dynamic deliveryNoteAt;
  dynamic deliveryNoteBy;

  Datum({
    this.id,
    this.idStr,
    this.no,
    this.type,
    this.bptkId,
    this.customerId,
    this.createdBy,
    this.status,
    this.deliveryNoteAt,
    this.deliveryNoteBy,
  });

  Datum copyWith({
    int? id,
    String? idStr,
    String? no,
    int? type,
    int? bptkId,
    dynamic customerId,
    int? createdBy,
    int? status,
    dynamic deliveryNoteAt,
    dynamic deliveryNoteBy,
  }) =>
      Datum(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        no: no ?? this.no,
        type: type ?? this.type,
        bptkId: bptkId ?? this.bptkId,
        customerId: customerId ?? this.customerId,
        createdBy: createdBy ?? this.createdBy,
        status: status ?? this.status,
        deliveryNoteAt: deliveryNoteAt ?? this.deliveryNoteAt,
        deliveryNoteBy: deliveryNoteBy ?? this.deliveryNoteBy,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        type: json["type"],
        bptkId: json["bptk_id"],
        customerId: json["customer_id"],
        createdBy: json["created_by"],
        status: json["status"],
        deliveryNoteAt: json["delivery_note_at"],
        deliveryNoteBy: json["delivery_note_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "type": type,
        "bptk_id": bptkId,
        "customer_id": customerId,
        "created_by": createdBy,
        "status": status,
        "delivery_note_at": deliveryNoteAt,
        "delivery_note_by": deliveryNoteBy,
      };
}
