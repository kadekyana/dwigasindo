// To parse this JSON data, do
//
//     final modelDetailCmd = modelDetailCmdFromJson(jsonString);

import 'dart:convert';

ModelDetailCmd modelDetailCmdFromJson(String str) =>
    ModelDetailCmd.fromJson(json.decode(str));

String modelDetailCmdToJson(ModelDetailCmd data) => json.encode(data.toJson());

class ModelDetailCmd {
  Data? data;
  dynamic error;

  ModelDetailCmd({
    this.data,
    this.error,
  });

  factory ModelDetailCmd.fromJson(Map<String, dynamic> json) => ModelDetailCmd(
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
  String? name;
  String? address;
  String? code;
  String? npwp;
  int? typeCoorporation;
  int? districtId;
  double? radius;
  bool? isLimitPlatform;
  int? limitPlatform;
  int? typeDelivery;
  String? deliveryRequestBy;
  String? deliveryRequestPhone;
  int? typePayment;
  int? typeInvoice;
  int? paymentTermType;
  int? paymentTerm;
  String? tubePrefix;
  bool? isProyeksiProfit;
  DateTime? cooperationSince;
  int? approval1;
  int? approval2;
  int? approval3;
  int? approval4;
  int? approval5;
  int? approval6;
  List<Pic>? pics;
  List<AddressesList>? addressesList;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        address: json["address"],
        code: json["code"],
        npwp: json["npwp"],
        typeCoorporation: json["type_coorporation"],
        districtId: json["district_id"],
        radius: json["radius"]?.toDouble(),
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
        cooperationSince: json["cooperation_since"] == null
            ? null
            : DateTime.parse(json["cooperation_since"]),
        approval1: json["approval1"],
        approval2: json["approval2"],
        approval3: json["approval3"],
        approval4: json["approval4"],
        approval5: json["approval5"],
        approval6: json["approval6"],
        pics: json["pics"] == null
            ? []
            : List<Pic>.from(json["pics"]!.map((x) => Pic.fromJson(x))),
        addressesList: json["addresses_list"] == null
            ? []
            : List<AddressesList>.from(
                json["addresses_list"]!.map((x) => AddressesList.fromJson(x))),
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
        "cooperation_since": cooperationSince?.toIso8601String(),
        "approval1": approval1,
        "approval2": approval2,
        "approval3": approval3,
        "approval4": approval4,
        "approval5": approval5,
        "approval6": approval6,
        "pics": pics == null
            ? []
            : List<dynamic>.from(pics!.map((x) => x.toJson())),
        "addresses_list": addressesList == null
            ? []
            : List<dynamic>.from(addressesList!.map((x) => x.toJson())),
      };
}

class AddressesList {
  int? id;
  String? idStr;
  String? address;

  AddressesList({
    this.id,
    this.idStr,
    this.address,
  });

  factory AddressesList.fromJson(Map<String, dynamic> json) => AddressesList(
        id: json["id"],
        idStr: json["id_str"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "address": address,
      };
}

class Pic {
  int? id;
  String? idStr;
  String? name;
  String? department;
  String? phone;
  String? email;

  Pic({
    this.id,
    this.idStr,
    this.name,
    this.department,
    this.phone,
    this.email,
  });

  factory Pic.fromJson(Map<String, dynamic> json) => Pic(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        department: json["department"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "department": department,
        "phone": phone,
        "email": email,
      };
}
