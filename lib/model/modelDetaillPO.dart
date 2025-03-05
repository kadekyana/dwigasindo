// To parse this JSON data, do
//
//     final modelDataPo = modelDataPoFromJson(jsonString);

import 'dart:convert';

ModelDataPo modelDataPoFromJson(String str) =>
    ModelDataPo.fromJson(json.decode(str));

String modelDataPoToJson(ModelDataPo data) => json.encode(data.toJson());

class ModelDataPo {
  Data? data;
  dynamic error;

  ModelDataPo({
    this.data,
    this.error,
  });

  factory ModelDataPo.fromJson(Map<String, dynamic> json) => ModelDataPo(
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
  String? poNo;
  DateTime? poDate;
  int? vendorId;
  String? vendorName;
  String? poCategory;
  String? spbNo;
  List<Detail>? detail;
  List<PoDetail>? poDetail;

  Data({
    this.id,
    this.idStr,
    this.poNo,
    this.poDate,
    this.vendorId,
    this.vendorName,
    this.poCategory,
    this.spbNo,
    this.detail,
    this.poDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        poNo: json["po_no"],
        poDate:
            json["po_date"] == null ? null : DateTime.parse(json["po_date"]),
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        poCategory: json["po_category"],
        spbNo: json["spb_no"],
        detail: json["detail"] == null
            ? []
            : List<Detail>.from(json["detail"]!.map((x) => Detail.fromJson(x))),
        poDetail: json["po_detail"] == null
            ? []
            : List<PoDetail>.from(
                json["po_detail"]!.map((x) => PoDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "po_no": poNo,
        "po_date": poDate?.toIso8601String(),
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "po_category": poCategory,
        "spb_no": spbNo,
        "detail": detail == null
            ? []
            : List<dynamic>.from(detail!.map((x) => x.toJson())),
        "po_detail": poDetail == null
            ? []
            : List<dynamic>.from(poDetail!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? idStr;
  int? itemId;
  String? itemName;
  String? itemCategory;
  int? qty;
  String? photo;
  int? warehouseId;
  String? warehouseName;
  String? note;
  int? status;

  Detail({
    this.id,
    this.idStr,
    this.itemId,
    this.itemName,
    this.itemCategory,
    this.qty,
    this.photo,
    this.warehouseId,
    this.warehouseName,
    this.note,
    this.status,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemCategory: json["item_category"],
        qty: json["qty"],
        photo: json["photo"],
        warehouseId: json["warehouse_id"],
        warehouseName: json["warehouse_name"],
        note: json["note"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "item_id": itemId,
        "item_name": itemName,
        "item_category": itemCategory,
        "qty": qty,
        "photo": photo,
        "warehouse_id": warehouseId,
        "warehouse_name": warehouseName,
        "note": note,
        "status": status,
      };
}

class PoDetail {
  int? id;
  String? idStr;
  int? poId;
  int? itemId;
  String? itemName;
  int? itemPrice;
  int? itemQty;
  int? subtotal;
  String? itemNote;

  PoDetail({
    this.id,
    this.idStr,
    this.poId,
    this.itemId,
    this.itemName,
    this.itemPrice,
    this.itemQty,
    this.subtotal,
    this.itemNote,
  });

  factory PoDetail.fromJson(Map<String, dynamic> json) => PoDetail(
        id: json["id"],
        idStr: json["id_str"],
        poId: json["po_id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        itemQty: json["item_qty"],
        subtotal: json["subtotal"],
        itemNote: json["item_note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "po_id": poId,
        "item_id": itemId,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_qty": itemQty,
        "subtotal": subtotal,
        "item_note": itemNote,
      };
}
