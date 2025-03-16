// To parse this JSON data, do
//
//     final modelDetailSpb = modelDetailSpbFromJson(jsonString);

import 'dart:convert';

ModelDetailSpb modelDetailSpbFromJson(String str) =>
    ModelDetailSpb.fromJson(json.decode(str));

String modelDetailSpbToJson(ModelDetailSpb data) => json.encode(data.toJson());

class ModelDetailSpb {
  Data? data;
  dynamic error;

  ModelDetailSpb({
    this.data,
    this.error,
  });

  factory ModelDetailSpb.fromJson(Map<String, dynamic> json) => ModelDetailSpb(
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
  DateTime? spbDate;
  int? spbType;
  int? picVerified;
  String? picVerifiedName;
  int? picAcknowledged;
  String? picAcknowledgedName;
  int? picApproved;
  String? picApprovedName;
  int? createdBy;
  String? createdByName;
  List<SpbDetail>? spbDetail;
  int? picVerifiedStatus;
  int? picAcknowledgedStatus;
  int? picApprovedStatus;

  Data({
    this.id,
    this.idStr,
    this.no,
    this.spbDate,
    this.spbType,
    this.picVerified,
    this.picVerifiedName,
    this.picAcknowledged,
    this.picAcknowledgedName,
    this.picApproved,
    this.picApprovedName,
    this.createdBy,
    this.createdByName,
    this.spbDetail,
    this.picVerifiedStatus,
    this.picAcknowledgedStatus,
    this.picApprovedStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        spbDate:
            json["spb_date"] == null ? null : DateTime.parse(json["spb_date"]),
        spbType: json["spb_type"],
        picVerified: json["pic_verified"],
        picVerifiedName: json["pic_verified_name"],
        picAcknowledged: json["pic_acknowledged"],
        picAcknowledgedName: json["pic_acknowledged_name"],
        picApproved: json["pic_approved"],
        picApprovedName: json["pic_approved_name"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        spbDetail: json["spb_detail"] == null
            ? []
            : List<SpbDetail>.from(
                json["spb_detail"]!.map((x) => SpbDetail.fromJson(x))),
        picVerifiedStatus: json["pic_verified_status"],
        picAcknowledgedStatus: json["pic_acknowledged_status"],
        picApprovedStatus: json["pic_approved_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "spb_date": spbDate?.toIso8601String(),
        "spb_type": spbType,
        "pic_verified": picVerified,
        "pic_verified_name": picVerifiedName,
        "pic_acknowledged": picAcknowledged,
        "pic_acknowledged_name": picAcknowledgedName,
        "pic_approved": picApproved,
        "pic_approved_name": picApprovedName,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "spb_detail": spbDetail == null
            ? []
            : List<dynamic>.from(spbDetail!.map((x) => x.toJson())),
        "pic_verified_status": picVerifiedStatus,
        "pic_acknowledged_status": picAcknowledgedStatus,
        "pic_approved_status": picApprovedStatus,
      };
}

class SpbDetail {
  int? id;
  String? idStr;
  int? spbId;
  int? itemId;
  String? itemName;
  int? qty;
  String? specification;

  SpbDetail({
    this.id,
    this.idStr,
    this.spbId,
    this.itemId,
    this.itemName,
    this.qty,
    this.specification,
  });

  factory SpbDetail.fromJson(Map<String, dynamic> json) => SpbDetail(
        id: json["id"],
        idStr: json["id_str"],
        spbId: json["spb_id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        qty: json["qty"],
        specification: json["specification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "spb_id": spbId,
        "item_id": itemId,
        "item_name": itemName,
        "qty": qty,
        "specification": specification,
      };
}
