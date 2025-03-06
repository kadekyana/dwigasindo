// To parse this JSON data, do
//
//     final modelDetailBpti = modelDetailBptiFromJson(jsonString);

import 'dart:convert';

ModelDetailBpti modelDetailBptiFromJson(String str) =>
    ModelDetailBpti.fromJson(json.decode(str));

String modelDetailBptiToJson(ModelDetailBpti data) =>
    json.encode(data.toJson());

class ModelDetailBpti {
  Data? data;
  dynamic error;

  ModelDetailBpti({
    this.data,
    this.error,
  });

  factory ModelDetailBpti.fromJson(Map<String, dynamic> json) =>
      ModelDetailBpti(
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
  String? noBpti;
  int? countSuccess;
  int? countCancelled;
  String? gasType;
  Customer? customer;
  Driver? driver;
  List<Detail>? details;

  Data({
    this.id,
    this.idStr,
    this.noBpti,
    this.countSuccess,
    this.countCancelled,
    this.gasType,
    this.customer,
    this.driver,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        noBpti: json["no_bpti"],
        countSuccess: json["count_success"],
        countCancelled: json["count_cancelled"],
        gasType: json["gas_type"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no_bpti": noBpti,
        "count_success": countSuccess,
        "count_cancelled": countCancelled,
        "gas_type": gasType,
        "customer": customer?.toJson(),
        "driver": driver?.toJson(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Customer {
  int? id;
  String? idStr;
  String? name;
  String? address;
  String? code;
  dynamic npwp;
  int? typeCoorporation;
  int? districtId;
  int? radius;
  bool? isLimitPlatform;
  dynamic limitPlatform;
  dynamic typeDelivery;
  dynamic deliveryRequestBy;
  dynamic deliveryRequestPhone;
  dynamic typePayment;
  dynamic typeInvoice;
  dynamic paymentTermType;
  dynamic paymentTerm;
  dynamic tubePrefix;
  bool? isProyeksiProfit;
  dynamic cooperationSince;
  dynamic approval1;
  dynamic approval2;
  dynamic approval3;
  dynamic approval4;
  dynamic approval5;
  dynamic approval6;
  dynamic pics;
  dynamic addressesList;

  Customer({
    this.id,
    this.idStr,
    this.name,
    this.address,
    this.code,
    this.npwp,
    this.typeCoorporation,
    this.districtId,
    this.radius,
    this.isLimitPlatform,
    this.limitPlatform,
    this.typeDelivery,
    this.deliveryRequestBy,
    this.deliveryRequestPhone,
    this.typePayment,
    this.typeInvoice,
    this.paymentTermType,
    this.paymentTerm,
    this.tubePrefix,
    this.isProyeksiProfit,
    this.cooperationSince,
    this.approval1,
    this.approval2,
    this.approval3,
    this.approval4,
    this.approval5,
    this.approval6,
    this.pics,
    this.addressesList,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        address: json["address"],
        code: json["code"],
        npwp: json["npwp"],
        typeCoorporation: json["type_coorporation"],
        districtId: json["district_id"],
        radius: json["radius"],
        isLimitPlatform: json["is_limit_platform"],
        limitPlatform: json["limit_platform"],
        typeDelivery: json["type_delivery"],
        deliveryRequestBy: json["delivery_request_by"],
        deliveryRequestPhone: json["delivery_request_phone"],
        typePayment: json["type_payment"],
        typeInvoice: json["type_invoice"],
        paymentTermType: json["payment_term_type"],
        paymentTerm: json["payment_term"],
        tubePrefix: json["tube_prefix"],
        isProyeksiProfit: json["is_proyeksi_profit"],
        cooperationSince: json["cooperation_since"],
        approval1: json["approval1"],
        approval2: json["approval2"],
        approval3: json["approval3"],
        approval4: json["approval4"],
        approval5: json["approval5"],
        approval6: json["approval6"],
        pics: json["pics"],
        addressesList: json["addresses_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "address": address,
        "code": code,
        "npwp": npwp,
        "type_coorporation": typeCoorporation,
        "district_id": districtId,
        "radius": radius,
        "is_limit_platform": isLimitPlatform,
        "limit_platform": limitPlatform,
        "type_delivery": typeDelivery,
        "delivery_request_by": deliveryRequestBy,
        "delivery_request_phone": deliveryRequestPhone,
        "type_payment": typePayment,
        "type_invoice": typeInvoice,
        "payment_term_type": paymentTermType,
        "payment_term": paymentTerm,
        "tube_prefix": tubePrefix,
        "is_proyeksi_profit": isProyeksiProfit,
        "cooperation_since": cooperationSince,
        "approval1": approval1,
        "approval2": approval2,
        "approval3": approval3,
        "approval4": approval4,
        "approval5": approval5,
        "approval6": approval6,
        "pics": pics,
        "addresses_list": addressesList,
      };
}

class Detail {
  int? id;
  String? idStr;
  int? tubeId;
  int? isNew;
  int? status;
  int? verifiedBy;
  DateTime? verifiedAt;
  String? tubeType;
  String? tubeGas;
  String? tubeGrade;
  dynamic tubeCustomerName;
  int? type;
  dynamic cradleId;
  dynamic cradleDetails;
  int? isOwnership;

  Detail({
    this.id,
    this.idStr,
    this.tubeId,
    this.isNew,
    this.status,
    this.verifiedBy,
    this.verifiedAt,
    this.tubeType,
    this.tubeGas,
    this.tubeGrade,
    this.tubeCustomerName,
    this.type,
    this.cradleId,
    this.cradleDetails,
    this.isOwnership,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        isNew: json["is_new"],
        status: json["status"],
        verifiedBy: json["verified_by"],
        verifiedAt: json["verified_at"] == null
            ? null
            : DateTime.parse(json["verified_at"]),
        tubeType: json["tube_type"],
        tubeGas: json["tube_gas"],
        tubeGrade: json["tube_grade"],
        tubeCustomerName: json["tube_customer_name"],
        type: json["type"],
        cradleId: json["cradle_id"],
        cradleDetails: json["cradle_details"],
        isOwnership: json["is_ownership"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "is_new": isNew,
        "status": status,
        "verified_by": verifiedBy,
        "verified_at": verifiedAt?.toIso8601String(),
        "tube_type": tubeType,
        "tube_gas": tubeGas,
        "tube_grade": tubeGrade,
        "tube_customer_name": tubeCustomerName,
        "type": type,
        "cradle_id": cradleId,
        "cradle_details": cradleDetails,
        "is_ownership": isOwnership,
      };
}

class Driver {
  int? id;
  String? idStr;
  String? name;

  Driver({
    this.id,
    this.idStr,
    this.name,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
      };
}
