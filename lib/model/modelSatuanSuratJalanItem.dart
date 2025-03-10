// To parse this JSON data, do
//
//     final modelSatuanSuratJalanItem = modelSatuanSuratJalanItemFromJson(jsonString);

import 'dart:convert';

ModelSatuanSuratJalanItem modelSatuanSuratJalanItemFromJson(String str) =>
    ModelSatuanSuratJalanItem.fromJson(json.decode(str));

String modelSatuanSuratJalanItemToJson(ModelSatuanSuratJalanItem data) =>
    json.encode(data.toJson());

class ModelSatuanSuratJalanItem {
  Data? data;
  dynamic error;

  ModelSatuanSuratJalanItem({
    this.data,
    this.error,
  });

  factory ModelSatuanSuratJalanItem.fromJson(Map<String, dynamic> json) =>
      ModelSatuanSuratJalanItem(
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
  int? status;
  int? type;
  dynamic driverId;
  dynamic driverName;
  String? nonUserName;
  String? vehicleNumber;
  List<Order>? orders;
  List<Detail>? details;
  List<dynamic>? suspects;

  Data({
    this.id,
    this.idStr,
    this.no,
    this.status,
    this.type,
    this.driverId,
    this.driverName,
    this.nonUserName,
    this.vehicleNumber,
    this.orders,
    this.details,
    this.suspects,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        idStr: json["id_str"],
        no: json["no"],
        status: json["status"],
        type: json["type"],
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        nonUserName: json["non_user_name"],
        vehicleNumber: json["vehicle_number"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
        suspects: json["suspects"] == null
            ? []
            : List<dynamic>.from(json["suspects"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "no": no,
        "status": status,
        "type": type,
        "driver_id": driverId,
        "driver_name": driverName,
        "non_user_name": nonUserName,
        "vehicle_number": vehicleNumber,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "suspects":
            suspects == null ? [] : List<dynamic>.from(suspects!.map((x) => x)),
      };
}

class Detail {
  int? id;
  String? idStr;
  int? deliveryNoteItemId;
  int? itemId;
  String? itemName;
  int? orderId;
  int? qty;
  String? string;
  dynamic verifiedAt;
  dynamic deletedBy;
  dynamic deletedByName;
  dynamic deletedReason;
  int? createdBy;
  String? createdByName;

  Detail({
    this.id,
    this.idStr,
    this.deliveryNoteItemId,
    this.itemId,
    this.itemName,
    this.orderId,
    this.qty,
    this.string,
    this.verifiedAt,
    this.deletedBy,
    this.deletedByName,
    this.deletedReason,
    this.createdBy,
    this.createdByName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        idStr: json["id_str"],
        deliveryNoteItemId: json["delivery_note_item_id"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        orderId: json["order_id"],
        qty: json["qty"],
        string: json["string"],
        verifiedAt: json["verified_at"],
        deletedBy: json["deleted_by"],
        deletedByName: json["deleted_by_name"],
        deletedReason: json["deleted_reason"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "delivery_note_item_id": deliveryNoteItemId,
        "item_id": itemId,
        "item_name": itemName,
        "order_id": orderId,
        "qty": qty,
        "string": string,
        "verified_at": verifiedAt,
        "deleted_by": deletedBy,
        "deleted_by_name": deletedByName,
        "deleted_reason": deletedReason,
        "created_by": createdBy,
        "created_by_name": createdByName,
      };
}

class Order {
  int? id;
  String? idStr;
  String? code;

  Order({
    this.id,
    this.idStr,
    this.code,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idStr: json["id_str"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_str": idStr,
        "code": code,
      };
}
