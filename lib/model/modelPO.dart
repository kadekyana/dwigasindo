import 'dart:convert';

ModelPo modelPoFromJson(String str) => ModelPo.fromJson(json.decode(str));

String modelPoToJson(ModelPo data) => json.encode(data.toJson());

class ModelPo {
  List<Datum>? data;

  ModelPo({
    this.data,
  });

  factory ModelPo.fromJson(Map<String, dynamic> json) => ModelPo(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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

  // Changed these fields to double
  double? totalPrice;
  double? totalPpn;
  double? totalPayment;
  double? installmentPaymentPrice;
  double? installmentPaymentPpn;
  double? installmentPaymentTotal;

  dynamic picVerifiedBy;
  dynamic picVerifiedName;
  dynamic picVerifiedStatus;
  dynamic picAcknowledgedBy;
  dynamic picAcknowledgedName;
  dynamic picAcknowledgedStatus;
  dynamic picApprovedBy;
  dynamic picApprovedName;
  dynamic picApprovedStatus;
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
    this.picVerifiedStatus,
    this.picAcknowledgedBy,
    this.picAcknowledgedName,
    this.picAcknowledgedStatus,
    this.picApprovedBy,
    this.picApprovedName,
    this.picApprovedStatus,
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

        // Adjust parsing for double
        totalPrice: json["total_price"] == null
            ? null
            : (json["total_price"] is int
                ? (json["total_price"] as int).toDouble()
                : json["total_price"].toDouble()),
        totalPpn: json["total_ppn"] == null
            ? null
            : (json["total_ppn"] is int
                ? (json["total_ppn"] as int).toDouble()
                : json["total_ppn"].toDouble()),
        totalPayment: json["total_payment"] == null
            ? null
            : (json["total_payment"] is int
                ? (json["total_payment"] as int).toDouble()
                : json["total_payment"].toDouble()),
        installmentPaymentPrice: json["installment_payment_price"] == null
            ? null
            : (json["installment_payment_price"] is int
                ? (json["installment_payment_price"] as int).toDouble()
                : json["installment_payment_price"].toDouble()),
        installmentPaymentPpn: json["installment_payment_ppn"] == null
            ? null
            : (json["installment_payment_ppn"] is int
                ? (json["installment_payment_ppn"] as int).toDouble()
                : json["installment_payment_ppn"].toDouble()),
        installmentPaymentTotal: json["installment_payment_total"] == null
            ? null
            : (json["installment_payment_total"] is int
                ? (json["installment_payment_total"] as int).toDouble()
                : json["installment_payment_total"].toDouble()),

        picVerifiedBy: json["pic_verified_by"],
        picVerifiedName: json["pic_verified_name"],
        picVerifiedStatus: json["pic_verified_status"],
        picAcknowledgedBy: json["pic_acknowledged_by"],
        picAcknowledgedName: json["pic_acknowledged_name"],
        picAcknowledgedStatus: json["pic_acknowledged_status"],
        picApprovedBy: json["pic_approved_by"],
        picApprovedName: json["pic_approved_name"],
        picApprovedStatus: json["pic_approved_status"],
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

        // Convert double back to JSON
        "total_price": totalPrice,
        "total_ppn": totalPpn,
        "total_payment": totalPayment,
        "installment_payment_price": installmentPaymentPrice,
        "installment_payment_ppn": installmentPaymentPpn,
        "installment_payment_total": installmentPaymentTotal,

        "pic_verified_by": picVerifiedBy,
        "pic_verified_name": picVerifiedName,
        "pic_verified_status": picVerifiedStatus,
        "pic_acknowledged_by": picAcknowledgedBy,
        "pic_acknowledged_name": picAcknowledgedName,
        "pic_acknowledged_status": picAcknowledgedStatus,
        "pic_approved_by": picApprovedBy,
        "pic_approved_name": picApprovedName,
        "pic_approved_status": picApprovedStatus,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "created_at": createdAt?.toIso8601String(),
      };
}
