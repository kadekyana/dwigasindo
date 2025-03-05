// To parse this JSON data, do
//
//     final modelDetailPurchase = modelDetailPurchaseFromJson(jsonString);

import 'dart:convert';

ModelDetailPurchase modelDetailPurchaseFromJson(String str) =>
    ModelDetailPurchase.fromJson(json.decode(str));

String modelDetailPurchaseToJson(ModelDetailPurchase data) =>
    json.encode(data.toJson());

class ModelDetailPurchase {
  Data? data;
  dynamic error;

  ModelDetailPurchase({
    this.data,
    this.error,
  });

  factory ModelDetailPurchase.fromJson(Map<String, dynamic> json) =>
      ModelDetailPurchase(
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
  DateTime? poDate;
  String? spbNo;
  int? spbType;
  int? categoryId;
  String? categoryName;
  int? vendorId;
  String? vendorName;
  int? paymentType;
  DateTime? paymentDeadline;
  int? totalPrice;
  int? totalPpn;
  int? totalPayment;
  int? installmentPaymentPrice;
  int? installmentPaymentPpn;
  int? installmentPaymentTotal;
  dynamic picVerifiedBy;
  dynamic picVerifiedName;
  dynamic picAcknowledgedBy;
  dynamic picAcknowledgedName;
  dynamic picApprovedBy;
  dynamic picApprovedName;
  int? createdBy;
  String? createdByName;
  List<PoDetail>? poDetail;

  Data({
    this.id,
    this.idStr,
    this.no,
    this.poDate,
    this.spbNo,
    this.spbType,
    this.categoryId,
    this.categoryName,
    this.vendorId,
    this.vendorName,
    this.paymentType,
    this.paymentDeadline,
    this.totalPrice,
    this.totalPpn,
    this.totalPayment,
    this.installmentPaymentPrice,
    this.installmentPaymentPpn,
    this.installmentPaymentTotal,
    this.picVerifiedBy,
    this.picVerifiedName,
    this.picAcknowledgedBy,
    this.picAcknowledgedName,
    this.picApprovedBy,
    this.picApprovedName,
    this.createdBy,
    this.createdByName,
    this.poDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        poDate:
            json["po_date"] == null ? null : DateTime.parse(json["po_date"]),
        spbNo: json["spb_no"],
        spbType: json["spb_type"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        paymentType: json["payment_type"],
        paymentDeadline: json["payment_deadline"] == null
            ? null
            : DateTime.parse(json["payment_deadline"]),
        totalPrice: json["total_price"],
        totalPpn: json["total_ppn"],
        totalPayment: json["total_payment"],
        installmentPaymentPrice: json["installment_payment_price"],
        installmentPaymentPpn: json["installment_payment_ppn"],
        installmentPaymentTotal: json["installment_payment_total"],
        picVerifiedBy: json["pic_verified_by"],
        picVerifiedName: json["pic_verified_name"],
        picAcknowledgedBy: json["pic_acknowledged_by"],
        picAcknowledgedName: json["pic_acknowledged_name"],
        picApprovedBy: json["pic_approved_by"],
        picApprovedName: json["pic_approved_name"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        poDetail: json["po_detail"] == null
            ? []
            : List<PoDetail>.from(
                json["po_detail"]!.map((x) => PoDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "po_date": poDate?.toIso8601String(),
        "spb_no": spbNo,
        "spb_type": spbType,
        "category_id": categoryId,
        "category_name": categoryName,
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "payment_type": paymentType,
        "payment_deadline": paymentDeadline?.toIso8601String(),
        "total_price": totalPrice,
        "total_ppn": totalPpn,
        "total_payment": totalPayment,
        "installment_payment_price": installmentPaymentPrice,
        "installment_payment_ppn": installmentPaymentPpn,
        "installment_payment_total": installmentPaymentTotal,
        "pic_verified_by": picVerifiedBy,
        "pic_verified_name": picVerifiedName,
        "pic_acknowledged_by": picAcknowledgedBy,
        "pic_acknowledged_name": picAcknowledgedName,
        "pic_approved_by": picApprovedBy,
        "pic_approved_name": picApprovedName,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "po_detail": poDetail == null
            ? []
            : List<dynamic>.from(poDetail!.map((x) => x.toJson())),
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
  dynamic itemNote;

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
