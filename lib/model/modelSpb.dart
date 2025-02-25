// To parse this JSON data, do
//
//     final modelSpb = modelSpbFromJson(jsonString);

import 'dart:convert';

ModelSpb modelSpbFromJson(String str) => ModelSpb.fromJson(json.decode(str));

String modelSpbToJson(ModelSpb data) => json.encode(data.toJson());

class ModelSpb {
  List<Datum>? data;
  dynamic error;

  ModelSpb({
    this.data,
    this.error,
  });

  factory ModelSpb.fromJson(Map<String, dynamic> json) => ModelSpb(
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
  double? totalPayment;
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
  DateTime? createdAt;

  Datum({
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
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        totalPayment: json["total_payment"]?.toDouble(),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "created_at": createdAt?.toIso8601String(),
      };
}
