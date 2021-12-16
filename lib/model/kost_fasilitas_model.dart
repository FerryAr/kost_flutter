// To parse this JSON data, do
//
//     final kostFasilitasModel = kostFasilitasModelFromJson(jsonString);

import 'dart:convert';

KostFasilitasModel kostFasilitasModelFromJson(String str) =>
    KostFasilitasModel.fromJson(json.decode(str));

String kostFasilitasModelToJson(KostFasilitasModel data) =>
    json.encode(data.toJson());

class KostFasilitasModel {
  KostFasilitasModel({
    this.status = '',
    required this.data,
  });

  String status;
  KostFasilitas data;

  factory KostFasilitasModel.fromJson(Map<String, dynamic> json) =>
      KostFasilitasModel(
        status: json["status"],
        data: KostFasilitas.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class KostFasilitas {
  KostFasilitas({
    this.fasilitas = const [],
    this.icon = const [],
  });

  List<String> fasilitas;
  List<String> icon;

  factory KostFasilitas.fromJson(Map<String, dynamic> json) => KostFasilitas(
        fasilitas: List<String>.from(json["fasilitas"].map((x) => x)),
        icon: List<String>.from(json["icon"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fasilitas": List<dynamic>.from(fasilitas.map((x) => x)),
        "icon": List<dynamic>.from(icon.map((x) => x)),
      };
}
