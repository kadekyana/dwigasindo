// To parse this JSON data, do
//
//     final modelVerifikasiBptk = modelVerifikasiBptkFromJson(jsonString);

import 'dart:convert';

ModelVerifikasiBptk modelVerifikasiBptkFromJson(String str) =>
    ModelVerifikasiBptk.fromJson(json.decode(str));

String modelVerifikasiBptkToJson(ModelVerifikasiBptk data) =>
    json.encode(data.toJson());

class ModelVerifikasiBptk {
  Data? data;
  dynamic error;

  ModelVerifikasiBptk({
    this.data,
    this.error,
  });

  ModelVerifikasiBptk copyWith({
    Data? data,
    dynamic error,
  }) =>
      ModelVerifikasiBptk(
        data: data ?? this.data,
        error: error ?? this.error,
      );

  factory ModelVerifikasiBptk.fromJson(Map<String, dynamic> json) =>
      ModelVerifikasiBptk(
        data: Data.fromJson(json["data"]),
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
  String? noBptk;
  int? count;
  String? gasType;
  DateTime? createdAt;
  Customer? customer;
  Customer? driver;
  List<Detail>? details;

  Data({
    this.id,
    this.idStr,
    this.noBptk,
    this.count,
    this.gasType,
    this.createdAt,
    this.customer,
    this.driver,
    this.details,
  });

  Data copyWith({
    int? id,
    String? idStr,
    String? noBptk,
    int? count,
    String? gasType,
    DateTime? createdAt,
    Customer? customer,
    Customer? driver,
    List<Detail>? details,
  }) =>
      Data(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        noBptk: noBptk ?? this.noBptk,
        count: count ?? this.count,
        gasType: gasType ?? this.gasType,
        createdAt: createdAt ?? this.createdAt,
        customer: customer ?? this.customer,
        driver: driver ?? this.driver,
        details: details ?? this.details,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        noBptk: json["no_bptk"],
        count: json["count"],
        gasType: json["gas_type"],
        createdAt: DateTime.parse(json["created_at"]),
        customer: Customer.fromJson(json["customer"]),
        driver: Customer.fromJson(json["driver"]),
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no_bptk": noBptk,
        "count": count,
        "gas_type": gasType,
        "created_at": createdAt?.toIso8601String(),
        "customer": customer?.toJson(),
        "driver": driver?.toJson(),
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Customer {
  int? id;
  String? idStr;
  String? name;
  String? address;

  Customer({
    this.id,
    this.idStr,
    this.name,
    this.address,
  });

  Customer copyWith({
    int? id,
    String? idStr,
    String? name,
    String? address,
  }) =>
      Customer(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        name: name ?? this.name,
        address: address ?? this.address,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        idStr: json["id_str"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "name": name,
        "address": address,
      };
}

class Detail {
  int? id;
  String? idStr;
  int? tubeId;
  String? tubeCode;
  int? isNew;
  bool? isHasGrade;
  int? status;
  dynamic verifiedBy;
  dynamic verifiedAt;
  int? isOwnership;
  String? tubeType;
  String? tubeGas;
  String? tubeGrade;
  dynamic tubeCustomerName;
  String? lastLocation;
  int? isCradle;
  dynamic cradleId;
  DateTime? createdAt;
  List<dynamic>? cradleDetails;

  Detail({
    this.id,
    this.idStr,
    this.tubeId,
    this.tubeCode,
    this.isNew,
    this.isHasGrade,
    this.status,
    this.verifiedBy,
    this.verifiedAt,
    this.isOwnership,
    this.tubeType,
    this.tubeGas,
    this.tubeGrade,
    this.tubeCustomerName,
    this.lastLocation,
    this.isCradle,
    this.cradleId,
    this.createdAt,
    this.cradleDetails,
  });

  Detail copyWith({
    int? id,
    String? idStr,
    int? tubeId,
    String? tubeCode,
    int? isNew,
    bool? isHasGrade,
    int? status,
    dynamic verifiedBy,
    dynamic verifiedAt,
    int? isOwnership,
    String? tubeType,
    String? tubeGas,
    String? tubeGrade,
    dynamic tubeCustomerName,
    String? lastLocation,
    int? isCradle,
    dynamic cradleId,
    DateTime? createdAt,
    List<dynamic>? cradleDetails,
  }) =>
      Detail(
        id: id ?? this.id,
        idStr: idStr ?? this.idStr,
        tubeId: tubeId ?? this.tubeId,
        tubeCode: tubeCode ?? this.tubeCode,
        isNew: isNew ?? this.isNew,
        isHasGrade: isHasGrade ?? this.isHasGrade,
        status: status ?? this.status,
        verifiedBy: verifiedBy ?? this.verifiedBy,
        verifiedAt: verifiedAt ?? this.verifiedAt,
        isOwnership: isOwnership ?? this.isOwnership,
        tubeType: tubeType ?? this.tubeType,
        tubeGas: tubeGas ?? this.tubeGas,
        tubeGrade: tubeGrade ?? this.tubeGrade,
        tubeCustomerName: tubeCustomerName ?? this.tubeCustomerName,
        lastLocation: lastLocation ?? this.lastLocation,
        isCradle: isCradle ?? this.isCradle,
        cradleId: cradleId ?? this.cradleId,
        createdAt: createdAt ?? this.createdAt,
        cradleDetails: cradleDetails ?? this.cradleDetails,
      );

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        tubeCode: json["tube_code"],
        isNew: json["is_new"],
        isHasGrade: json["is_has_grade"],
        status: json["status"],
        verifiedBy: json["verified_by"],
        verifiedAt: json["verified_at"],
        isOwnership: json["is_ownership"],
        tubeType: json["tube_type"],
        tubeGas: json["tube_gas"],
        tubeGrade: json["tube_grade"],
        tubeCustomerName: json["tube_customer_name"],
        lastLocation: json["last_location"],
        isCradle: json["is_cradle"],
        cradleId: json["cradle_id"],
        createdAt: DateTime.parse(json["created_at"]),
        cradleDetails: List<dynamic>.from(json["cradle_details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "tube_code": tubeCode,
        "is_new": isNew,
        "is_has_grade": isHasGrade,
        "status": status,
        "verified_by": verifiedBy,
        "verified_at": verifiedAt,
        "is_ownership": isOwnership,
        "tube_type": tubeType,
        "tube_gas": tubeGas,
        "tube_grade": tubeGrade,
        "tube_customer_name": tubeCustomerName,
        "last_location": lastLocation,
        "is_cradle": isCradle,
        "cradle_id": cradleId,
        "created_at": createdAt?.toIso8601String(),
        "cradle_details": List<dynamic>.from(cradleDetails!.map((x) => x)),
      };
}
