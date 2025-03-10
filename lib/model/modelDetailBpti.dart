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
  int? customerId;
  String? customerIdStr;
  String? customerName;
  String? customerAdress;
  Driver? driver;
  List<Detail>? details;

  Data({
    this.id,
    this.idStr,
    this.noBpti,
    this.countSuccess,
    this.countCancelled,
    this.gasType,
    this.customerId,
    this.customerIdStr,
    this.customerName,
    this.customerAdress,
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
        customerId: json["customer_id"],
        customerIdStr: json["customer_id_str"],
        customerName: json["customer_name"],
        customerAdress: json["customer_adress"],
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
        "customer_id": customerId,
        "customer_id_str": customerIdStr,
        "customer_name": customerName,
        "customer_adress": customerAdress,
        "driver": driver?.toJson(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  int? id;
  String? idStr;
  int? tubeId;
  String? tubeNo;
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
  DateTime? createdAt;
  DateTime? updatedAt;

  Detail({
    this.id,
    this.idStr,
    this.tubeId,
    this.tubeNo,
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
    this.createdAt,
    this.updatedAt,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        tubeId: json["tube_id"],
        tubeNo: json["tube_no"],
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "tube_id": tubeId,
        "tube_no": tubeNo,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
