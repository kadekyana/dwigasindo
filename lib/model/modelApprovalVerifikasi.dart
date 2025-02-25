// To parse this JSON data, do
//
//     final modelApprovalVerifikasi = modelApprovalVerifikasiFromJson(jsonString);

import 'dart:convert';

ModelApprovalVerifikasi modelApprovalVerifikasiFromJson(String str) =>
    ModelApprovalVerifikasi.fromJson(json.decode(str));

String modelApprovalVerifikasiToJson(ModelApprovalVerifikasi data) =>
    json.encode(data.toJson());

class ModelApprovalVerifikasi {
  List<Datum>? data;
  dynamic error;

  ModelApprovalVerifikasi({
    this.data,
    this.error,
  });

  factory ModelApprovalVerifikasi.fromJson(Map<String, dynamic> json) =>
      ModelApprovalVerifikasi(
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
  int? itemId;
  String? itemName;
  int? quantity;
  int? quantityReal;
  int? quantityResult;
  int? picVerifiedType;
  int? picApprovedType;

  Datum({
    this.id,
    this.itemId,
    this.itemName,
    this.quantity,
    this.quantityReal,
    this.quantityResult,
    this.picVerifiedType,
    this.picApprovedType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        quantity: json["quantity"],
        quantityReal: json["quantity_real"],
        quantityResult: json["quantity_result"],
        picVerifiedType: json["pic_verified_type"],
        picApprovedType: json["pic_approved_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_name": itemName,
        "quantity": quantity,
        "quantity_real": quantityReal,
        "quantity_result": quantityResult,
        "pic_verified_type": picVerifiedType,
        "pic_approved_type": picApprovedType,
      };
}
