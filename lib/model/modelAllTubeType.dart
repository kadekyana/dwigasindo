// To parse this JSON data, do
//
//     final modelAllTubeType = modelAllTubeTypeFromJson(jsonString);

import 'dart:convert';

ModelAllTubeType modelAllTubeTypeFromJson(String str) => ModelAllTubeType.fromJson(json.decode(str));

String modelAllTubeTypeToJson(ModelAllTubeType data) => json.encode(data.toJson());

class ModelAllTubeType {
    List<Datum> data;
    dynamic error;

    ModelAllTubeType({
        required this.data,
        required this.error,
    });

    ModelAllTubeType copyWith({
        List<Datum>? data,
        dynamic error,
    }) => 
        ModelAllTubeType(
            data: data ?? this.data,
            error: error ?? this.error,
        );

    factory ModelAllTubeType.fromJson(Map<String, dynamic> json) => ModelAllTubeType(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class Datum {
    int id;
    String idStr;
    String name;

    Datum({
        required this.id,
        required this.idStr,
        required this.name,
    });

    Datum copyWith({
        int? id,
        String? idStr,
        String? name,
    }) => 
        Datum(
            id: id ?? this.id,
            idStr: idStr ?? this.idStr,
            name: name ?? this.name,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
