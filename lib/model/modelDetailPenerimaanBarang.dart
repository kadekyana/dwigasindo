// To parse this JSON data, do
//
//     final modeldetailPenerimaanBarang = modeldetailPenerimaanBarangFromJson(jsonString);

import 'dart:convert';

ModeldetailPenerimaanBarang modeldetailPenerimaanBarangFromJson(String str) =>
    ModeldetailPenerimaanBarang.fromJson(json.decode(str));

String modeldetailPenerimaanBarangToJson(ModeldetailPenerimaanBarang data) =>
    json.encode(data.toJson());

class ModeldetailPenerimaanBarang {
  Data? data;
  dynamic error;

  ModeldetailPenerimaanBarang({
    this.data,
    this.error,
  });

  factory ModeldetailPenerimaanBarang.fromJson(Map<String, dynamic> json) =>
      ModeldetailPenerimaanBarang(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
  String? no;
  int? divisionId;
  String? divisionName;
  int? picVerified;
  String? picVerifiedName;
  int? picAcknowledged;
  String? picAcknowledgedName;
  int? picApproved;
  String? picApprovedName;
  int? createdBy;
  String? createdByName;
  DateTime? createdAt;
  String? category;
  List<Detail>? detail;

  Data({
    this.id,
    this.idStr,
    this.no,
    this.divisionId,
    this.divisionName,
    this.picVerified,
    this.picVerifiedName,
    this.picAcknowledged,
    this.picAcknowledgedName,
    this.picApproved,
    this.picApprovedName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.category,
    this.detail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        divisionId: json["division_id"],
        divisionName: json["division_name"],
        picVerified: json["pic_verified"],
        picVerifiedName: json["pic_verified_name"],
        picAcknowledged: json["pic_acknowledged"],
        picAcknowledgedName: json["pic_acknowledged_name"],
        picApproved: json["pic_approved"],
        picApprovedName: json["pic_approved_name"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        category: json["category"],
        detail: json["detail"] == null
            ? []
            : List<Detail>.from(json["detail"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "division_id": divisionId,
        "division_name": divisionName,
        "pic_verified": picVerified,
        "pic_verified_name": picVerifiedName,
        "pic_acknowledged": picAcknowledged,
        "pic_acknowledged_name": picAcknowledgedName,
        "pic_approved": picApproved,
        "pic_approved_name": picApprovedName,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "created_at": createdAt?.toIso8601String(),
        "category": category,
        "detail": detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? idStr;
  int? itemRequestId;
  int? qty;
  int? qtyReceived;
  String? note;
  int? isTransferStock;
  dynamic photo;
  dynamic warehouseId;
  dynamic warehouseName;

  Detail({
    this.id,
    this.idStr,
    this.itemRequestId,
    this.qty,
    this.qtyReceived,
    this.note,
    this.isTransferStock,
    this.photo,
    this.warehouseId,
    this.warehouseName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        itemRequestId: json["item_request_id"],
        qty: json["qty"],
        qtyReceived: json["qty_received"],
        note: json["note"],
        isTransferStock: json["is_transfer_stock"],
        photo: json["photo"],
        warehouseId: json["warehouse_id"],
        warehouseName: json["warehouse_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "item_request_id": itemRequestId,
        "qty": qty,
        "qty_received": qtyReceived,
        "note": note,
        "is_transfer_stock": isTransferStock,
        "photo": photo,
        "warehouse_id": warehouseId,
        "warehouse_name": warehouseName,
      };
}
