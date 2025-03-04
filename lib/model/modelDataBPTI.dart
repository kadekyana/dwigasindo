// To parse this JSON data, do
//
//     final modelDataBpti = modelDataBptiFromJson(jsonString);

import 'dart:convert';

ModelDataBpti modelDataBptiFromJson(String str) =>
    ModelDataBpti.fromJson(json.decode(str));

String modelDataBptiToJson(ModelDataBpti data) => json.encode(data.toJson());

class ModelDataBpti {
  List<Datum>? data;
  dynamic error;

  ModelDataBpti({
    this.data,
    this.error,
  });

  factory ModelDataBpti.fromJson(Map<String, dynamic> json) => ModelDataBpti(
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
  String? no;
  int? total;

  Datum({
    this.id,
    this.no,
    this.total,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        no: json["no"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "total": total,
      };
}
